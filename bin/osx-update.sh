#!/bin/sh -e

echo "Check for OS X updates."
OUTPUT=$(softwareupdate --list 2>&1)
GREP=$(echo "${OUTPUT}" | grep 'No new software available.')

if [ "${GREP}" = "" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
else
    echo "Nothing to update."

    exit 0
fi

echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    softwareupdate --install --all
fi
