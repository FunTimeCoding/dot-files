#!/bin/sh -e

OUTPUT=$(gem outdated)

if [ "${OUTPUT}" = "" ]; then
    exit 0
fi

echo "gem updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

gem update
# TODO: Keep important gems for projects like veewee.
#gem cleanup
