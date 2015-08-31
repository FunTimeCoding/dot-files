#!/bin/sh -e

echo "Check for Debian updates."
sudo apt-get update -qq
OUTPUT=$(sudo apt-get upgrade -s)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    HOST_NAME=$(hostname)
    echo "Update ${HOST_NAME}? [y/n]"
    read READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

sudo apt-get upgrade -qq
sudo apt-get clean
