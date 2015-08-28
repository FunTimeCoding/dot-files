#!/bin/sh -e

echo "Check for brew updates."
brew update
OUTPUT=$(brew outdated)

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    echo "Update? [y/n]"
    read READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

brew upgrade --all
brew cleanup -s
brew cask cleanup
