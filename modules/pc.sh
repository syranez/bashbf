#!/bin/bash
#
# program counter
#+
#+ Interface:
#+    - getProgramCounter
#+    - incProgramCounter
#+    - decProgramCounter
#+    - setProgramCounter

BASHBF_PC=0;

# echoes the current program counter
#+
getProgramCounter () {

    printf "%s" "$BASHBF_PC";
}

# increments the program counter
#+
incProgramCounter () {

    BASHBF_PC=$((BASHBF_PC+1));
}

# decrements the program counter
#+
decProgramCounter () {

    if [ "$BASHBF_PC" -eq "0" ]; then
        echo "Error: decProgramCounter tried to dec program counter to -1";
        exit 1;
    fi;

    BASHBF_PC=$((BASHBF_PC-1));
}

# resets the program counter to 0
#
resetProgramCounter () {

    setProgramCounter "0";
}

# sets the program counter to the given value
#+
#+ @param number counter to set
setProgramCounter () {

    if [ -z "$1" ]; then
        echo 'Error: setProgramCounter called without param.';
        exit 1;
    fi;

    BASHBF_PC="$1";
}
