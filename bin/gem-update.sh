#!/bin/sh -e

if [ "$(command -v gem || true)" = "" ]; then
    echo "Skip. Gem does not seem to be installed."

    exit 0
fi

echo "Check for gem updates."
OUTPUT=$(gem outdated)

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    echo "Update? [y/n]"
    read -r READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

gem update
gem cleanup
