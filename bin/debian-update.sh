#!/bin/sh -e

echo "Check for Debian updates (apt-get upgrade)."
sudo apt-get --quiet 2 update
OUTPUT=$(sudo apt-get --simulate upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update (apt-get upgrade)."
else
    if [ ! "${1}" = --yes ]; then
        echo "Available updates:"
        echo "${OUTPUT}"
        HOST_NAME=$(hostname)
        echo "Update ${HOST_NAME}? [y/N]"
        read -r READ

        if [ ! "${READ}" = y ]; then
            exit 0
        fi
    fi

    sudo apt-get --quiet 2 upgrade
    echo "Run autoremove and clean."
    sudo apt-get --quiet 2 autoremove
    sudo apt-get --quiet 2 clean
fi

echo "Check for Debian updates (apt-get dist-upgrade)."
OUTPUT=$(sudo apt-get --simulate dist-upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update (apt-get dist-upgrade)."
else
    if [ ! "${1}" = --yes ]; then
        echo "Available updates:"
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
fi
