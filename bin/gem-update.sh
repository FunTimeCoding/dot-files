#!/bin/sh -e

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
    read READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

gem update
gem cleanup
