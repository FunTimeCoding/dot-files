#!/bin/sh -e

echo "Check for Debian updates."
sudo apt-get -qq update
OUTPUT=$(sudo apt-get -s upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update (upgrade)."
else
    if [ ! "${1}" = "--yes" ]; then
        echo "Available updates:"
        echo "${OUTPUT}"
        HOST_NAME=$(hostname)
        echo "Update ${HOST_NAME}? [y/n]"
        read -r READ

        if [ ! "${READ}" = "y" ]; then
            exit 0
        fi
    fi

    sudo apt-get -qq upgrade
    sudo apt-get -qq autoremove
    sudo apt-get -qq clean
fi

OUTPUT=$(sudo apt-get -s dist-upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update (dist-upgrade)."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    HOST_NAME=$(hostname)
    echo "Update ${HOST_NAME}? [y/n]"
    read -r READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

sudo apt-get -qq dist-upgrade
sudo apt-get -qq autoremove
sudo apt-get -qq clean
