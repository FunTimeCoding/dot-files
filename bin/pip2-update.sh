#!/bin/sh -e

echo "Check for pip2 updates."
OUTPUT=$(pip2 list --outdated 2> /dev/null | awk '{ print $1 }')

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
else
    echo "Available updates:"
    echo "${OUTPUT}"
fi

echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    pip2 install -U pip setuptools

    for PACKAGE in ${OUTPUT}; do
        pip2 install -U "${PACKAGE}"
    done
fi
