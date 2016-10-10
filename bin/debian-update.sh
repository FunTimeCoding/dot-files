#!/bin/sh -e

echo "Check for Debian updates (apt-get upgrade)."
sudo apt-get -qq update
OUTPUT=$(sudo apt-get -s upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update (apt-get upgrade)."
else
    if [ ! "${1}" = --yes ]; then
        echo "Available updates:"
        echo "${OUTPUT}"
        HOST_NAME=$(hostname)
        echo "Update ${HOST_NAME}? [y/n]"
        read -r READ

        if [ ! "${READ}" = y ]; then
            exit 0
        fi
    fi

    sudo apt-get -qq upgrade
    echo "Run autoremove and clean."
    sudo apt-get -qq autoremove
    sudo apt-get -qq clean
fi

echo "Check for Debian updates (apt-get dist-upgrade)."
OUTPUT=$(sudo apt-get -s dist-upgrade)
GREP=$(echo "${OUTPUT}" | grep 'The following packages will be upgraded:') || GREP=""

if [ "${GREP}" = "" ]; then
    echo "Nothing to update (apt-get dist-upgrade)."
else
    if [ ! "${1}" = --yes ]; then
        echo "Available updates:"
        echo "${OUTPUT}"
        HOST_NAME=$(hostname)
        echo "Update ${HOST_NAME}? [y/n]"
        read -r READ

        if [ ! "${READ}" = y ]; then
            exit 0
        fi

        sudo apt-get -qq dist-upgrade
        echo "Run autoremove and clean."
        sudo apt-get -qq autoremove
        sudo apt-get -qq clean
    fi
fi
