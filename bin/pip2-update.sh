#!/bin/sh -e

echo "Check for pip2 updates."
OUTPUT=$(pip2 list --outdated 2> /dev/null | awk '{ print $1 }')

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

pip2 install --upgrade setuptools
pip2 install --upgrade pip

for PACKAGE in ${OUTPUT}; do
    pip2 install --upgrade "${PACKAGE}"
done
