#!/bin/sh -e

echo "Run all updates."
OPERATING_SYSTEM=$(uname)
vim-update.sh
pip2-update.sh "${1}"
pip3-update.sh "${1}"
#atom-update.sh "${1}" # No plugins used, no update needed.

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    brew-update.sh "${1}"
    #npm-update.sh "${1}" # NPM has an issue when updating from a script instead of an interactive shell.
    gem-update.sh "${1}"
    osx-update.sh "${1}"
    cabal-update.sh
elif [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    debian-update.sh "${1}"
fi

CODE_DIRECTORY="${HOME}/Code"

if [ -d "${CODE_DIRECTORY}" ]; then
    cd "${CODE_DIRECTORY}" || exit 1
    repo-update.rb -d 2
fi
