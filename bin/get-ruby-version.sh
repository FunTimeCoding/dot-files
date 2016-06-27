#!/bin/sh -e

if [ "$(command -v hxselect || true)" = "" ]; then
    echo "Command not found: hxselect"

    exit 1
fi

OUTPUT=$(wget --quiet https://cache.ruby-lang.org/pub/ruby --output-document - | gunzip)
LIST=$(echo ${OUTPUT} | hxselect -s "\n" -c a 2>/dev/null | grep '^ruby-[0-9].*') || true
LATEST=""

for ELEMENT in ${LIST}; do
    ELEMENT="${ELEMENT#ruby-*}"
    ELEMENT="${ELEMENT%*.xz}"
    ELEMENT="${ELEMENT%*.gz}"
    ELEMENT="${ELEMENT%*.bz2}"
    ELEMENT="${ELEMENT%*.zip}"
    ELEMENT="${ELEMENT%*.tar}"

    if [ ! "${ELEMENT}" = "" ]; then
        LATEST="${ELEMENT}"
    fi
done

echo "Ruby: ${LATEST}"
