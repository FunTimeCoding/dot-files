#!/bin/sh -e

if [ "$(command -v composer || true)" = "" ]; then
    echo "Skip. Composer does not seem to be installed."

    exit 0
fi

composer selfupdate
composer global update
