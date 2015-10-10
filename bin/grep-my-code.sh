#!/bin/sh -e

find -E "${HOME}/Code/Personal" -type f -size -4096c ! -regex '^.*/(node_modules|bower_components|vendor|\.git|\.idea|\.pyvenv)/.*$' -exec sh -c 'grep -Hn "${2}" "${1}"' '_' '{}' "${1}" \;
