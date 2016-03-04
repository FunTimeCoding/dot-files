#!/bin/sh -e

if [ "$(command -v shellcheck || true)" = "" ]; then
    echo "Command not found: shellcheck"

    exit 1
fi

echo "Search for shellcheck warnings."
# shellcheck disable=SC2016
find . \( -name '*.sh' -and -not -path '*/.vim/*' \) -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;

echo "Search for empty files."
find . -empty -and -not -path '*/.svn/*' -and -not -path '*/.git/*' -ls
