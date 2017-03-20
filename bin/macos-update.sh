#!/bin/sh -e

OUTPUT=$(softwareupdate --list 2>&1)
GREP=$(echo "${OUTPUT}" | grep 'No new software available.') || GREP=""

if [ ! "${GREP}" = "" ]; then
    exit 0
fi

echo "Available updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

softwareupdate --install --all

# TODO: Capture output and make this message more apparent.
#GREP=$(echo ${OUTPUT} | grep 'Please restart immediately.') || GREP=""
