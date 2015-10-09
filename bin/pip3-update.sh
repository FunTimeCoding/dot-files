#!/bin/sh -e

echo "Check for pip3 updates."
OUTPUT=$(pip3 list --outdated 2> /dev/null | awk '{ print $1 }')

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    echo "Update? [y/n]"
    read -r READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

pip3 install -U pip setuptools

for PACKAGE in ${OUTPUT}; do
    pip3 install -U "${PACKAGE}"
done
