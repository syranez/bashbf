#!/bin/bash
#
# program
#+
#+ Interface:
#+    - setProgram
#+    - getProgram
#+    - execute

BASHBF_PROGRAM="";

# sets the program
#+
#+ @param string program
setProgram () {

    if [ -z "$1" ]; then
        echo 'Error: setProgram called without param.';
        exit 1;
    fi;

    BASHBF_PROGRAM="$1";
}

# echoes the current program
#+
getProgram () {

    printf "%s" "$BASHBF_PROGRAM";
}

# echoes the program length
#+
getProgramLength () {

    printf "%s" "${#BASHBF_PROGRAM}";
}

# echoes the current token
#+
getToken () {

    local pc=$(getProgramCounter);
    local program=$(getProgram);
    printf "%s" ${program:$pc:1};
}

# executes the current loaded program
execute () {

    resetProgramCounter;
    # resetBand;
    # resetOutput;

    local token="";
    local pc=$(getProgramCounter);
    local length=$(getProgramLength);

    while (( $pc < $length )); do
        token=$(getToken);
        parse "$token";

        incProgramCounter;
        pc=$(getProgramCounter);
    done;
}
