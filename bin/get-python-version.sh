#!/bin/sh -e

OUTPUT=$(wget --quiet https://www.python.org/ftp/python --output-document -)
LIST=$(echo ${OUTPUT} | hxselect -s "\n" -c a 2>/dev/null | grep '^[0-9].*') || true
LIST=$(echo "${LIST}" | sed -E 's/^([0-9])\.([0-9])\//\1.\2.0\//')
LIST=$(echo "${LIST}" | sort -V)
LATEST_TWO=""
LATEST_THREE=""

for ELEMENT in ${LIST}; do
    TWO=$(echo "${ELEMENT}" | grep '^2.*') || true
    THREE=$(echo "${ELEMENT}" | grep '^3.*') || true

    if [ ! "${TWO}" = "" ]; then
        LATEST_TWO="${TWO}"
    fi

    if [ ! "${THREE}" = "" ]; then
        LATEST_THREE="${THREE}"
    fi
done

echo "Python 2: ${LATEST_TWO%*/}"
echo "Python 3: ${LATEST_THREE%*/}"