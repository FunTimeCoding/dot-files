#!/bin/sh -e

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    FIND="gfind"
else
    FIND="find"
fi

${FIND} . -regextype posix-extended -type f -and ! -regex '^.*/(\.git|\.vim)/.*$' -exec sh -c 'grep -rn TODO ${1} | grep -v ${2}' '_' '{}' '${0}' \;
