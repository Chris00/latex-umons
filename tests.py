#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from typing import NamedTuple, List
from configparser import ConfigParser, ExtendedInterpolation
import csv, re
import smtplib
import os, shutil, subprocess, glob
from email.message import EmailMessage
from email.headerregistry import Address
import mimetypes # Guess MIME type based on file name extension
import sys
from optparse import OptionParser

class Error(Exception):
    pass

csv_re = re.compile("\\\\generatetestsfromCSV{([^{}]+)}")
jobname_re = re.compile("\\\\jobname *")

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

class Student(NamedTuple):
    name: str
    email: str
    row: dict
    tex: TeX

    def dir(self):
        return os.path.join(self.tex.name + ".d", self.name)

    def email_address(self):
        (user, domain) = self.email.split("@")
        return Address(s.name, user, domain)

    def write_csv(self, csvfile):
        """Write the CSV file only for the specified student."""
        with open(csvfile, "w", newline="") as csvhandle:
            fieldnames = list(self.row)
            writer = csv.DictWriter(csvhandle, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerow(self.row)

class Students:
    list: List[Student]

    def __init__(self, ctx: TeX):
        """Find the CSV file in the TeX file and parse it."""
        self.list = []
        with open(ctx.csvfile, newline="") as csvhandle:
            csvreader = csv.DictReader(csvhandle, skipinitialspace=True)
            for row in csvreader:
                name = row["Nom"] + " " + row["Prenom"]
                if "email" in row:
                    email = row["email"]
                elif "matricule" in row:
                    email = row["matricule"] + "@umons.ac.be"
                else:
                    email = None
                self.list.append(Student(name, email, row, ctx))

    def compile_tex(self):
        """Compile separate PDF files for each student."""
        base_dir = os.getcwd()
        print("Compiling", texfile)
        for s in self.list:
            print("- for", s.name, ": ", end="", flush=True)
            s_dir = s.dir()
            try:
                os.makedirs(s_dir)
            except FileExistsError:
                pass
            s.write_csv(os.path.join(s_dir, os.path.basename(s.tex.csvfile)))
            os.chdir(s_dir)
            cmd = ["pdflatex", "-halt-on-error", s.tex.texfile]
            if subprocess.run(cmd, stdout=subprocess.DEVNULL,
                              stdin=subprocess.DEVNULL).returncode == 0:
                # run twice to resolve references
                subprocess.run(cmd, stdout=subprocess.DEVNULL,
                               stdin=subprocess.DEVNULL)
                print("OK.")
                os.remove(s.tex.name + ".aux")
                os.remove(s.tex.name + ".log")
            else:
                print("unsuccessful. See log file.")
            os.chdir(base_dir)

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
    smtp_password: str = None
    course: str = None
    message: str = None

    def __init__(self, ctx: TeX):
        """Locate the config file and parse it."""
        # Accumulate the configutation of various files to enable
        # interpolation from the global config to local ones.
        self.conf = ConfigParser(interpolation=ExtendedInterpolation())
        global_conf = global_conf_file()
        if os.path.isfile(global_conf):
            self.merge(global_conf)
        conffile0 = "tests.ini"
        conffile1 = ctx.name + ".ini"
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
            self.smtp_password = prof.get("password", self.smtp_password)
        if "Course" in self.conf:
            course = self.conf["Course"]
            self.course = course.get("name", self.course)
            self.message = course.get("message", self.message)

    def send(self, s: Student):
        """Send the message to the student `s` attaching his PDF exam file.

        This function does not compile the PDF file — it assumes it exists.
        """
        msg = EmailMessage()
        msg["Subject"] = self.course + " : examen"
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
        filename = s.tex.pdf_name()
        pdf_file = os.path.join(s.dir(), filename)
        ctype, encoding = mimetypes.guess_type(pdf_file)
        if ctype is None or encoding is not None:
            ctype = 'application/octet-stream'
        maintype, subtype = ctype.split('/', 1)
        with open(pdf_file, "rb") as fp:
            msg.add_attachment(fp.read(),
                               maintype = maintype,
                               subtype = subtype,
                               filename=filename)
        server = smtplib.SMTP(self.smtp_server, 587)
        server.ehlo()
        server.starttls()
        server.login(self.smtp_login, self.smtp_password)
        server.sendmail(self.prof_email, [s.email], msg.as_string())
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
    ctx = TeX(texfile)
    students = Students(ctx)
    #print(students.list)
    students.compile_tex()
    if options.send:
        email = Email(ctx)
        print("Send", ctx.name, "to")
        for s in students.list:
            print("-", s.email_address())
            email.send(s)
except Error as msg:
    print("⚠ Error:", msg)
