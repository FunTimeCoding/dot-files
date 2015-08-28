#!/bin/sh -e

echo "Check for atom updates."
OUTPUT=$(apm --no-color outdated)
GREP=$(echo "${OUTPUT}" | grep 'Package Updates Available (0)') || GREP=""

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

apm upgrade
