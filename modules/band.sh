#!/bin/bash
#
# band
#+
#+ Interface:
#+    - incValue
#+    - decValue
#+    - getValue
#+    - nextCell
#+    - prevCell
#+    - currentCell

BASHBF_BAND=(0);

BASHBF_BAND_INDEX="0";

# increments the value on the current cell 
#+
incValue () {

    local value="${BASHBF_BAND[$BASHBF_BAND_INDEX]}";
    BASHBF_BAND[$BASHBF_BAND_INDEX]=$((value+1));
}

# decrements the value on the current cell 
#+
decValue () {

    local value="${BASHBF_BAND[$BASHBF_BAND_INDEX]}";
    BASHBF_BAND[$BASHBF_BAND_INDEX]=$((value-1));
}

# echos the value on the current cell
#+
getValue () {

    printf "%s" "${BASHBF_BAND[$BASHBF_BAND_INDEX]}";
}

# echos the index of the band
#+
currentCell () {

    printf "%s" "${BASHBF_BAND_INDEX}";
}

# switches to the next cell
#+
nextCell () {

    local size=${#BASHBF_BAND[*]};

    BASHBF_BAND_INDEX="$((BASHBF_BAND_INDEX+1))";

    if [ "$(($BASHBF_BAND_INDEX+1))" -gt "$size" ]; then
        BASHBF_BAND[$BASHBF_BAND_INDEX]="0";
    fi;
}

# switches to the previous cell
#+
prevCell () {

    if [ "$BASHBF_BAND_INDEX" -eq "0" ]; then
        return;
    fi;

    BASHBF_BAND_INDEX="$((BASHBF_BAND_INDEX-1))";
}
