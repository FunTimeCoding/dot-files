#!/bin/sh -e

echo "Check for Debian updates."
sudo apt-get update -qq
OUTPUT=$(sudo apt-get upgrade -s)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update."

    exit 0
else
    echo "Available updates:"
    echo "${OUTPUT}"
fi

echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    sudo apt-get upgrade -qq
    sudo apt-get clean
fi
