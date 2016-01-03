#!/bin/sh -e

LIST=$(find . -type d -maxdepth 2 -mindepth 2)

for ELEMENT in ${LIST}; do
    if [ -d "${ELEMENT}/.git" ]; then
        cd "${ELEMENT}" || exit 1
        OUTPUT=$(git remote -v)

        if [ "${OUTPUT}" = "" ]; then
            echo "${ELEMENT}"
        fi
    fi
done
