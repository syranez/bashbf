#!/bin/bash
#
# program parser
#+
#+ Interface:
#+    - parse

# parses an instruction
#+
#+ @param string instruction
parse () {

    if [ -z "$1" ]; then
        echo "Error: parse called without param.";
        exit 1;
    fi;

    local instruction="$1";

    case $instruction in
        "+")
             parseInc;
             ;;
        "-")
             parseDec;
             ;;
        ">")
             parseNext;
             ;;
        "<")
             parsePrev;
             ;;
        ".")
             parseDot;
             ;;
        "[")
             parseOpenParenthese;
             ;;
        "]")
             parseCloseParenthese;
             ;;
    esac
}

# parses an increment instruction
#+
parseInc () {

    incValue;
}

# parses a decrement instruction
#+
parseDec () {

    decValue;
}

# parses a next cell instruction
#+
parseNext () {

    nextCell;
}

# parses a previous cell instruction
#+
parsePrev () {

    prevCell;
}

# parses an output instruction
#+
parseDot () {

    printf "\x$(printf %x $(getValue))"
}

# parses an open parentheses instruction
#+
parseOpenParenthese () {

    local value=$(getValue);

    if [ ! "$value" -eq "0" ]; then
        return;
    fi;

    # Die Schleife nicht (mehr) ausführen. Suche die schließende Klammer.
    # Da mehrere Schleifen geschachtelt sein können, muss die Anzahl der
    # öffnenden Klammern minus die Anzahl der schließenden Klammern 0 ergeben.
    # Erst dann ist die aktuelle Schleife auch wirklich vorbei.
    local open_parentheses="0";
    local do_ne="false";
    local token=$(getToken);
    until [ "$do_ne" = "true" ]
    do
        case $token in
            "[")
                open_parentheses=$((open_parentheses+1));
                ;;
            "]")
                open_parentheses=$((open_parentheses-1));
                ;;
        esac;

        if [ "$open_parentheses" -eq "0" ]; then
            do_ne="true";
        fi

        incProgramCounter;
        token=$(getToken);
    done;

}

# parses an close parentheses instruction
#+
parseCloseParenthese () {

    local value=$(getValue);

    if [ "$value" -eq "0" ]; then
        return;
    fi;

    local close_parentheses="0";
    local do_ne="false";
    local token=$(getToken);
    until [ "$do_ne" = "true" ]
    do
        case $token in
            "[")
                close_parentheses=$((close_parentheses-1));
                ;;
            "]")
                close_parentheses=$((close_parentheses+1));
                ;;
        esac;

        if [ "$close_parentheses" -eq "0" ]; then
            do_ne="true";
        fi

        decProgramCounter;
        token=$(getToken);
    done;

    incProgramCounter;
}
