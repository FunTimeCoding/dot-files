#!/bin/sh -e

echo "Run all updates."
OPERATING_SYSTEM=$(uname)
vim-update.sh

pip3-update.sh "${1}"
pip2-update.sh "${1}"
#atom-update.sh "${1}" # No plugins used, no update needed.
#npm-update.sh "${1}" # NPM has an issue when updating from a script instead of an interactive shell. It keeps updating the same versions or something.
gem-update.sh "${1}"
#cabal-update.sh # This always installs the same things over and over, even if they are already installed.

# Unstable
#if [ ! "$(command -v composer || true)" = "" ]; then
#    php-update.sh
#fi

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    brew-update.sh "${1}"
    osx-update.sh "${1}"
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
