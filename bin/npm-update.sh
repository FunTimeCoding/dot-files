#!/bin/sh -e

echo "Check for npm updates."
OUTPUT=$(npm outdated -g)

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
fi

if [ ! "${1}" = --yes ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    echo "Update? [y/n]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        exit 0
    fi
fi

npm install npm@latest -g
npm up -g
