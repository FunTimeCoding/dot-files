#!/bin/sh -e

sudo apt-get --quiet 2 update
OUTPUT=$(sudo apt-get --simulate upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ ! "${GREP}" = "" ]; then
    echo "Available updates (apt-get update):"
    echo "${OUTPUT}"
    HOST_NAME=$(hostname)
    echo "Update ${HOST_NAME}? [y/N]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        exit 0
    fi

    sudo apt-get --quiet 2 upgrade
    echo "Run autoremove and clean."
    sudo apt-get --quiet 2 autoremove
    sudo apt-get --quiet 2 clean
fi

OUTPUT=$(sudo apt-get --simulate dist-upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ ! "${GREP}" = "" ]; then
    echo "Available updates (apt-get dist-upgrade):"
    echo "${OUTPUT}"
    HOST_NAME=$(hostname)
    echo "Update ${HOST_NAME}? [y/N]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        exit 0
    fi

    sudo apt-get --quiet 2 dist-upgrade
    echo "Run autoremove and clean."
    sudo apt-get --quiet 2 autoremove
    sudo apt-get --quiet 2 clean
fi
