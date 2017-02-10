#!/bin/sh -e

if [ "$(command -v shellcheck || true)" = "" ]; then
    echo "Command not found: shellcheck"

    exit 1
fi

#    12345678901234567890123456789012345678901234567890123456789012345678901234567890
echo ================================================================================
echo

echo "Run ShellCheck."

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    FIND=gfind
else
    FIND=find
fi

# shellcheck disable=SC2016
${FIND} . -name '*.sh' -regextype posix-extended ! -regex '^.*/(build|.git)/.*$' -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;

echo
echo ================================================================================
echo

echo "Search for empty files."
${FIND} . -empty -and -not -path '*/.git/*' -ls

echo
echo ================================================================================
