# Requirements

## SBCL

Use your package manger (brew, apt-get, ...) or fetch binary distribution from http://sbcl.org/platform-table.html

Try it out

    $ sbcl
    * (+ 1 2 3)
    * 6
    * (quit)

## Quicklisp

Try following steps

    $ curl -O http://beta.quicklisp.org/quicklisp.lisp
    $ sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(setf ql-util::*do-not-prompt* t)' --eval '(ql:add-to-init-file)' --quit

Or follow full instructions from http://www.quicklisp.org/beta/

### Quicklisp libraries

* cl-json
* usocket

Quicklisp downloads required libraries to local repository on first use, so network connection is needed on first run.

Or preinstall with

    $ sbcl --quit --eval '(ql:quickload "usocket")'
    $ sbcl --quit --eval '(ql:quickload "cl-json")'
