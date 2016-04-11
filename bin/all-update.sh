#!/bin/sh -e

ALWAYS_YES="${1}"

if [ ! "${ALWAYS_YES}" = "--yes" ] && [ ! "${ALWAYS_YES}" = "" ]; then
    echo "Usage: ${0} [--yes]"

    exit 1
fi

echo "Run all updates."
nvim-update.sh
pip3-update.sh "${ALWAYS_YES}"
pip2-update.sh "${ALWAYS_YES}"
#atom-update.sh "${ALWAYS_YES}" # No plugins used, no update needed.
#npm-update.sh "${ALWAYS_YES}" # NPM has an issue when updating from a script instead of an interactive shell. It keeps updating the same versions or something.
gem-update.sh "${ALWAYS_YES}"
#cabal-update.sh # This always installs the same things over and over, even if they are already installed.
#php-update.sh # Unstable
OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    brew-update.sh "${ALWAYS_YES}"
    osx-update.sh "${ALWAYS_YES}"
elif [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    if [ -f "/etc/arch-release" ]; then
        arch-update.sh "${ALWAYS_YES}"
    elif [ -f "/etc/debian_version" ]; then
        debian-update.sh "${ALWAYS_YES}"
    fi
fi

CODE_DIRECTORY="${HOME}/Code"

if [ -d "${CODE_DIRECTORY}" ]; then
    cd "${CODE_DIRECTORY}" || exit 1
    update-code-repositories.rb -d 2
fi
