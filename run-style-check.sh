#!/bin/sh -e

if [ ! -x "$(command -v shellcheck)" ]; then
    echo "Command not found: shellcheck"

    exit 1
fi

find . \( -name '*.sh' -and -not -path '*/.vim/*' \) -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;
