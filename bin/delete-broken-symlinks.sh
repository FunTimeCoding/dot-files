#!/bin/sh -e

echo "Check for broken symlinks."
OUTPUT=$(find . -type l)

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to delete."

    exit 0
fi

echo "${OUTPUT}" | while read FILE; do
    if [ ! -e "${FILE}" ]; then
        ls -l "$FILE"
    fi
done

if [ ! "${1}" = "--yes" ]; then
    echo "Broken symlinks found:"
    echo "${OUTPUT}"
    echo "Delete? [y/n]"
    read READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

echo "${OUTPUT}" | while read FILE; do
    if [ ! -e "${FILE}" ]; then
        rm "$FILE"
    fi
done
