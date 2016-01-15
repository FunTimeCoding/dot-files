#!/bin/sh -e

find -E . -type f -and ! -regex '^.*/(\.git|\.vim)/.*$' -exec sh -c 'grep -rn TODO ${1} | grep -v ${2}' '_' '{}' '${0}' \;
