#!/bin/sh -e

echo "Check for OS X updates."
OUTPUT=$(softwareupdate --list 2>&1)
GREP=$(echo "${OUTPUT}" | grep 'No new software available.') || GREP=""

if [ ! "${GREP}" = "" ]; then
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

softwareupdate --install --all
