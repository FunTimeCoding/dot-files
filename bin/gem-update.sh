#!/bin/sh -e

if [ "$(command -v gem || true)" = "" ]; then
    echo "Command not found: gem"

    exit 1
fi

OUTPUT=$(gem outdated)

if [ "${OUTPUT}" = "" ]; then
    exit 0
fi

echo "Available updates:"
echo "${OUTPUT}"
echo "Update? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

gem update
# TODO: Figure out how to keep important gems for tools like veewee.
#gem cleanup
