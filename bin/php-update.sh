#!/bin/sh -e

if [ "$(command -v composer || true)" = "" ]; then
    echo "Command not found: composer"

    exit 1
fi

composer selfupdate
composer global update
