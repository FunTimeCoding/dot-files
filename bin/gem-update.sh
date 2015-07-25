#!/bin/sh -e

echo "Check for gem updates."
OUTPUT=$(gem outdated)

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
    gem update
    gem cleanup
fi
