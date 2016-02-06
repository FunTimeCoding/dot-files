#!/bin/sh -e

FILE="${1}"

if [ "${FILE}" = "" ]; then
    echo "Usage: ${0} FILE"

    exit 1
fi

cp "${FILE}" temp
git checkout "${FILE}"
cat temp >> "${FILE}"
rm temp
