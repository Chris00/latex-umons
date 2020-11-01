#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from typing import NamedTuple, List
from configparser import ConfigParser, ExtendedInterpolation
import csv, re
import smtplib
import os, subprocess, tempfile
from email.message import EmailMessage
from email.headerregistry import Address
import mimetypes # Guess MIME type based on file name extension
import sys
from optparse import OptionParser

class Error(Exception):
    pass

csv_re = re.compile("\\\\generatetestsfromCSV{([^{}]+)}")
jobname_re = re.compile("\\\\jobname *")

class Student(NamedTuple):
    name: str
    email: str
    row: dict

    def email_address(self):
        (user, domain) = self.email.split("@")
        return Address(self.name, user, domain)

    def write_csv(self, csvfile):
        """Write the CSV file only for the specified student."""
        with open(csvfile, "w", newline="") as csvhandle:
            fieldnames = list(self.row)
            writer = csv.DictWriter(csvhandle, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerow(self.row)

class TeX:
    name: str # basename without extension (LaTeX \jobname)
    texfile: str # absolute path
    csvfile: str # absolute path

    def __init__(self, texfile: str):
        self.name = os.path.splitext(os.path.basename(texfile))[0]
        self.texfile = os.path.abspath(texfile)
        # Retrieve the name of the CSV file in the TeX file.
        csvfile = ""
        with open(texfile) as tex:
            for line in tex:
                m = csv_re.search(line)
                if m is not None:
                    csvfile = jobname_re.sub(self.name, m.group(1))
                    break
        if csvfile == "":
            raise Error("CSV file not found in TeX file {}.".format(texfile))
        self.csvfile = os.path.abspath(csvfile)

    def pdf_name(self):
        return self.name + ".pdf"

    def student_dir(self, s: Student):
        return os.path.join(self.name + ".d", s.name)


class Students:
    list: List[Student]
    tex: TeX

    def __init__(self, tex: TeX):
        """Find the CSV file in the TeX file and parse it."""
        self.tex = tex
        self.list = []
        with open(tex.csvfile, newline="") as csvhandle:
            csvreader = csv.DictReader(csvhandle, skipinitialspace=True)
            for row in csvreader:
                name = row["Nom"].strip() + " " + row["Prenom"].strip()
                if "email" in row:
                    email = row["email"]
                elif "matricule" in row:
                    email = row["matricule"] + "@umons.ac.be"
                else:
                    email = None
                self.list.append(Student(name, email, row))

    def compile_tex(self):
        """Compile separate PDF files for each student."""
        if len(self.list) == 0:
            print("No student to compile for.")
            return True
        print("Compiling", texfile)
        # There may be other local files that the test depend upon
        # (some people put « tests.cls » in the current directory and
        # there may be some included files, e.g., for images), so
        # compile in place (changing the local CSV file).
        backup = tempfile.NamedTemporaryFile(
            prefix=os.path.basename(tex.csvfile) + ".", dir=".")
        backup.close()
        os.replace(tex.csvfile, backup.name)
        cmd = ["pdflatex", "-halt-on-error", self.tex.texfile]
        log = tex.name + ".log"
        pdf = tex.pdf_name()
        ok = True
        try:
            for s in self.list:
                print("- for", s.name, ": ", end="", flush=True)
                s_dir = tex.student_dir(s)
                try:
                    os.makedirs(s_dir)
                except FileExistsError:
                    pass
                s.write_csv(tex.csvfile) # Overwrite CSV file
                ret = subprocess.run(cmd, stdout=subprocess.DEVNULL,
                                     stdin=subprocess.DEVNULL)
                if ret.returncode == 0:
                    # run twice to resolve references
                    ret = subprocess.run(cmd, stdout=subprocess.DEVNULL,
                                         stdin=subprocess.DEVNULL)
                if ret.returncode == 0:
                    print("OK.")
                    os.replace(pdf, os.path.join(s_dir, pdf))
                    # Remove possibly leftover log file (from a previous run):
                    try:
                        os.remove(os.path.join(s_dir, log))
                    except FileNotFoundError:
                        pass
                else:
                    ok = False
                    os.replace(log, os.path.join(s_dir, log))
                    print("unsuccessful. See log file.")
        finally:
            # Restore the original CSV file
            os.replace(backup.name, tex.csvfile)
        return ok


### Sending emails

def global_conf_file():
    try:
        conf = os.environ["XDG_CONFIG_HOME"]
        return os.path.join(conf, "TeX/tests.ini")
    except KeyError:
        return os.path.expanduser("~/.config/TeX/tests.ini")

class Email:
    prof_name: str = None
    prof_email: str = None
    smtp_login: str = None
    smtp_server: str = None
    smtp_port: int = 587
    smtp_password: str = None
    subject: str = None
    message: str = None

    def __init__(self, tex: TeX):
        """Locate the config file and parse it."""
        # Accumulate the configutation of various files to enable
        # interpolation from the global config to local ones.
        self.conf = ConfigParser(interpolation=ExtendedInterpolation())
        global_conf = global_conf_file()
        if os.path.isfile(global_conf):
            self.merge(global_conf)
        conffile0 = "tests.ini"
        conffile1 = tex.name + ".ini"
        exists_ini = False
        if os.path.isfile(conffile0):
            self.merge(conffile0) # may contain options for all exams
            exists_ini = True
        if os.path.isfile(conffile1):
            self.merge(conffile1)
            exists_ini = True
        if not exists_ini:
            raise Error("Aucun fichier de configuration"
                        " ({}, {}) trouvé.".format(conffile0, conffile1))

    def merge(self, conf_file):
        self.conf.read(conf_file)
        if "Prof" in self.conf:
            prof = self.conf["Prof"]
            self.prof_name = prof.get("name", self.prof_name)
            self.prof_email = prof.get("email", self.prof_email)
            self.smtp_login = prof.get("login", self.smtp_login)
            self.smtp_server = prof.get("smtp", self.smtp_server)
            self.smtp_port = prof.getint("port", self.smtp_port)
            self.smtp_password = prof.get("password", self.smtp_password)
        if "Course" in self.conf:
            course = self.conf["Course"]
            if "subject" in course:
                self.subject = course["subject"]
            elif "name" in course:
                self.subject = course["name"] + " : examen"
            self.message = course.get("message", self.message)

    def send1(self, server, s: Student, pdf_file):
        """Send the message to the student `s` attaching his PDF exam file.

        This function does not compile the PDF file — it assumes it exists.
        """
        msg = EmailMessage()
        msg["Subject"] = self.subject
        (prof_user, prof_domain) = self.prof_email.split("@")
        msg["From"] = Address(self.prof_name, prof_user, prof_domain)
        msg["To"] = s.email_address()
        #msg["Date"] = formatdate(localtime=True)
        msg["Return-Receipt-To"] = self.prof_email
        msg["Disposition-Notification-To"] = self.prof_email

        try:
            msg_txt = self.message.format(student=s.name)
        except KeyError as v:
            raise Error("The message contains the invalid key {}".format(v)
                        + ", only 'student' is recognized")
        msg.set_content(msg_txt)
        ctype, encoding = mimetypes.guess_type(pdf_file)
        if ctype is None or encoding is not None:
            ctype = 'application/octet-stream'
        maintype, subtype = ctype.split('/', 1)
        with open(pdf_file, "rb") as fp:
            msg.add_attachment(fp.read(),
                               maintype = maintype,
                               subtype = subtype,
                               filename = os.path.basename(pdf_file))
        server.sendmail(self.prof_email, [s.email], msg.as_string())

    def send(self, students: Students):
        tex = students.tex
        print("Send", tex.pdf_name(), "to")
        if self.smtp_port == 465:
            server = smtplib.SMTP_SSL(self.smtp_server)
            server.ehlo()
        else:
            server = smtplib.SMTP(self.smtp_server, self.smtp_port)
            server.ehlo()
            server.starttls()
        server.login(self.smtp_login, self.smtp_password)
        pdf = tex.pdf_name()
        try:
            for s in students.list:
                print("-", s.email_address(), flush=True)
                self.send1(server, s, os.path.join(tex.student_dir(s), pdf))
        finally:
            server.quit()


### Parse command line arguments

usage = "usage: %prog [options] exam.tex"
description="""\
With no option, compile a separate PDF file for each student."""
parser = OptionParser(usage=usage, description=description)
parser.add_option("-s", "--send", default=False,
                  action="store_true", dest="send",
                  help="Email the PDF files to the students")
parser.add_option("--conf-global", default=False,
                  action="store_true", dest="conf_global",
                  help="Print the location of the global conf file")

(options, args) = parser.parse_args()

if options.conf_global:
    global_conf = global_conf_file()
    exists = ""
    if not(os.path.isfile(global_conf)):
        exists = "(does not exists)"
    print("Global conf file:", global_conf, exists)
    exit(0)
if len(args) == 0:
    print("You must provide a TeX file (see --help)")
    exit(1)
if len(args) > 1:
    print("A single TeX file must be provided (see --help)")
    exit(1)
texfile=args[0]

try:
    tex = TeX(texfile)
    students = Students(tex)
    #print(students.list)
    if not students.compile_tex():
        print("⚠ Please correct the compilation errors.")
        exit(1)
    if options.send:
        Email(tex).send(students)
except Error as msg:
    print("⚠ Error:", msg)
