#!/bin/sh -e

echo "Check for pip3 updates."
OUTPUT=$(pip3 list --outdated 2> /dev/null | awk '{ print $1 }')

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
    pip3 install -U pip setuptools

    for PACKAGE in ${OUTPUT}; do
        pip3 install -U "${PACKAGE}"
    done
fi
