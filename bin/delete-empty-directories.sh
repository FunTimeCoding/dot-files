#!/bin/sh -e

echo "Check for empty directories."
OUTPUT=$(find . -type d -depth -empty)

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to delete."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Empty directories found:"
    echo "${OUTPUT}"
    echo "Delete? [y/n]"
    read -r READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

find . -type d -depth -empty -delete
