#!/bin/sh -e

echo "Check for brew updates."
brew update
OUTPUT=$(brew outdated)

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
else
    echo "Available updates:"
    echo "${OUTPUT}"
fi

echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    brew upgrade --all
    brew cleanup -s
    brew cask cleanup
fi
