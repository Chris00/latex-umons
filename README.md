LaTeX Classes
=============

This repository contains various LaTeX classes that are primarily
intended to be used by professors and students of the university of
Mons but may also be of interest to a larger audience.

- `tests.cls` aims to provide a simple way of composing tests.  One or
  more tests may be in the same file (in case, say, they share
  questions).  To understand how to use this class, take a look to the
  two examples:
  - [tests-exemple.tex][]
  - [tests-exemple2.tex][]

  You can also automatically generate different tests for different
  students by naming your questions and using a CSV file to assign
  them to students, see [tests-exemple2.tex][].  To have a separate
  PDF file for each student and to send them by email, you can use the
  script [tests.py](tests.py).
- `memoire-umons.cls` is a simple class to write a master's thesis.
  It's use is exemplified by the files in
  [memoire-template](memoire-template/).
- `exprog.cls` is an class to write homework.
- `letter-umons.cls` is a class to write letters according to the
  UMONS layout.
- `testsslides.cls` enables to easily build slides from questions
  written using `tests.cls`.  It is no longer developed.


[tests-exemple.tex]: tests-exemple.tex
[tests-exemple2.tex]: tests-exemple2.tex

![UMONS](https://math.umons.ac.be/fr/images/UMONS.jpg)
