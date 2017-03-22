#!/bin/sh -e

OUTPUT=$(npm outdated -g)

if [ "${OUTPUT}" = "" ]; then
    exit 0
fi

echo "npm updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

npm install npm@latest -g
npm up -g
