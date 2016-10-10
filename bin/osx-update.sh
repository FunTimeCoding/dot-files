#!/bin/sh -e

echo "Check for OS X updates."
OUTPUT=$(softwareupdate --list 2>&1)
GREP=$(echo "${OUTPUT}" | grep 'No new software available.') || GREP=""

if [ ! "${GREP}" = "" ]; then
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

softwareupdate --install --all

# TODO: Capture output and make this message more apparent.
#GREP=$(echo ${OUTPUT} | grep 'Please restart immediately.') || GREP=""
