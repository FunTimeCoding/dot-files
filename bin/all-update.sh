#!/bin/sh -e

echo "Run all updates."
OPERATING_SYSTEM=$(uname)
vim-update.sh

if [ ! -f "/etc/arch-release" ]; then
    pip2-update.sh "${1}"
    pip3-update.sh "${1}"
fi

#atom-update.sh "${1}" # No plugins used, no update needed.

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    brew-update.sh "${1}"
    #npm-update.sh "${1}" # NPM has an issue when updating from a script instead of an interactive shell. It keeps updating the same versions or something.
    gem-update.sh "${1}"
    osx-update.sh "${1}"
    cabal-update.sh
elif [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    if [ -f "/etc/arch-release" ]; then
        arch-update.sh "${1}"
    elif [ -f "/etc/debian_version" ]; then
        debian-update.sh "${1}"
    fi
fi

CODE_DIRECTORY="${HOME}/Code"

if [ -d "${CODE_DIRECTORY}" ]; then
    cd "${CODE_DIRECTORY}" || exit 1
    update-code-repositories.rb -d 2
fi
