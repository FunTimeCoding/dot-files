#!/bin/sh -e

FILES=$(ls -al | grep ^- | awk '{print $9}')

for FILE in ${FILES}; do
    FIRST=$(echo "${FILE}" | cut -c 1-1)

    if [ "${FIRST}" = "." ]; then
        ls -l "${FILE}"
    fi
done

echo "Apply chmod 600? [y/n]"
read READ

if [ ! "${READ}" = "y" ]; then
    exit 0
fi

for FILE in ${FILES}; do
    FIRST=$(echo "${FILE}" | cut -c 1-1)

    if [ "${FIRST}" = "." ]; then
        chmod 600 "${FILE}"
    fi
done
