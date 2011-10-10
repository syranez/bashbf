#!/bin/bash
#
# A Brainfuckinterpreter in Bash
#+
#+ Usage:
#+
#+    ./bashbf PROGRAM
#+ or
#+    BASHBF_PROGRAM=PROGRAM; ./bashbf

# set -u
# set -e
# set -x

# program counter
. ./modules/pc.sh

# parser
. ./modules/parser.sh

# band
. ./modules/band.sh

# program wrapper
. ./modules/program.sh

if [ -z $1 ]; then
    echo "No program.";
    exit 0;
fi

setProgram $1

execute;

exit 0;
