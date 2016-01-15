#!/bin/sh -e

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    FIND="gfind"
else
    FIND="find"
fi

${FIND} "${HOME}/Code/Personal" -regextype posix-extended -type f -path '*-skeleton\/*' -and ! -regex '^.*/(build|node_modules|bower_components|vendor|\.git|\.idea|\.pyvenv)/.*$'
