#!/bin/sh -e

sudo apt-get --quiet 2 update
OUTPUT=$(sudo apt-get --simulate upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ ! "${GREP}" = "" ]; then
    echo "apt-get update updates:"
    echo "${OUTPUT}"
    HOST_NAME=$(hostname)
    echo "Update ${HOST_NAME}? [y/N]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        exit 0
    fi

    sudo apt-get --quiet 2 upgrade
    sudo apt-get --quiet 2 autoremove
    sudo apt-get --quiet 2 clean
fi

OUTPUT=$(sudo apt-get --simulate dist-upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ ! "${GREP}" = "" ]; then
    echo "apt-get dist-upgrade updates:"
    echo "${OUTPUT}"
    HOST_NAME=$(hostname)
    echo "Update ${HOST_NAME}? [y/N]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        exit 0
    fi

    sudo apt-get --quiet 2 dist-upgrade
    sudo apt-get --quiet 2 autoremove
    sudo apt-get --quiet 2 clean
fi
