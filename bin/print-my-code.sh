#!/bin/sh -e

find "${HOME}/Code/Personal" -type f -size -4096c -regextype posix-extended ! -regex '^.*/(build|node_modules|bower_components|vendor|\.git|\.idea|\.pyvenv)/.*$' -exec sh -c 'grep -Hn "${2}" "${1}"' '_' '{}' "${1}" \;
