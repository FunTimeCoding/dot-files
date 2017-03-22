#!/bin/sh -e

OUTPUT=$(mas outdated)

if [ "${OUTPUT}" = "" ]; then
    exit 0
fi

echo "mas updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

mas upgrade
