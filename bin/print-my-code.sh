#!/bin/sh -e

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    FIND="gfind"
else
    FIND="find"
fi

# shellcheck disable=SC2016
${FIND} "${HOME}/Code/Personal" -type f -size -4096c -regextype posix-extended ! -regex '^.*/(build|node_modules|bower_components|vendor|\.git|\.idea|\.pyvenv)/.*$' -exec sh -c 'grep -Hn "${2}" "${1}"' '_' '{}' "${1}" \;
