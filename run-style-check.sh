#!/bin/sh -e

find . \( -name '*.sh' -and -not -path '*/.vim/*' \) -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;
