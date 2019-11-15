#!/bin/bash

if [ -f "${HOME}/.paths.sh" ]; then
    # shellcheck source=.paths.sh
    . "${HOME}/.paths.sh"
fi

while read -r LINE; do
    if [ -d "${LINE}" ]; then
        PATH="${LINE}:${PATH}"
    fi
done <<< "${PATHS}"

export PATH
export PATHS
SYSTEM=$(uname)
LS='ls'
GNU_LS_FOUND=false

if [ "${SYSTEM}" = Darwin ]; then
    DIRCOLORS='gdircolors'

    if [ ! "$(command -v gls || true)" = "" ]; then
        LS='gls'
        GNU_LS_FOUND=true
    fi
else
    DIRCOLORS='dircolors'
    GNU_LS_FOUND=true
fi

export LS
export GNU_LS_FOUND

# shellcheck source=.aliases.sh
. "${HOME}/.aliases.sh"

if [ -f "${HOME}/.phpbrew/bashrc" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.phpbrew/bashrc"
fi

case "${TERM}" in
    xterm* | screen*)
        if [ ! "$(command -v ${DIRCOLORS} || true)" = "" ]; then
            eval "$(${DIRCOLORS} "${HOME}/src/dot-files/dircolors")"
        fi
        ;;
esac
