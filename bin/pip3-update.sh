#!/bin/sh -e

if [ "$(command -v pip3 || true)" = "" ]; then
    python3 -m ensurepip --user
    pip3 install --upgrade --user pip
    pip3 install --upgrade --user setuptools
    pip3 install --upgrade --user powerline-status
    rm "${HOME}"/.local/bin/pip
fi

echo "Check for pip3 updates."
OUTPUT=$(pip3 list --outdated 2> /dev/null | awk '{ print $1 }')

if [ "${OUTPUT}" = "" ]; then
    echo "Nothing to update."

    exit 0
fi

if [ ! "${1}" = "--yes" ]; then
    echo "Available updates:"
    echo "${OUTPUT}"
    echo "Update? [y/n]"
    read -r READ

    if [ ! "${READ}" = "y" ]; then
        exit 0
    fi
fi

pip3 install --upgrade --user pip
pip3 install --upgrade --user setuptools

for PACKAGE in ${OUTPUT}; do
    pip3 install --upgrade --user "${PACKAGE}"
done
