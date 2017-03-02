#!/bin/sh -e

PACKAGES=$(pip3 list --outdated --format legacy 2> /dev/null | awk '{ print $1 }')

if [ "${PACKAGES}" = "" ]; then
    exit 0
fi

if [ ! "${1}" = --yes ]; then
    echo "Available updates:"
    echo "${PACKAGES}"
    echo "Update? [y/N]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        exit 0
    fi
fi

pip3 install --upgrade pip setuptools

for PACKAGE in ${PACKAGES}; do
    pip3 install --upgrade "${PACKAGE}"
done
