#!/bin/sh -e

brew update > /dev/null
OUTPUT=$(brew outdated)

if [ "${OUTPUT}" = "" ]; then
    exit 0
fi

echo "brew updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

brew upgrade
brew cleanup -s
brew cask cleanup
