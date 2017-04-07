#!/bin/sh -e

brew update > /dev/null
OUTPUT=$(brew cask outdated --verbose)

if [ "${OUTPUT}" = "" ]; then
    exit 0
fi

echo "brew cask updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

CASKS=$(brew cask outdated)

for CASK in ${CASKS}; do
    brew cask reinstall "${CASK}"
done

brew cask cleanup
