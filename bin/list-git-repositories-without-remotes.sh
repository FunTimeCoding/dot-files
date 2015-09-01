#!/bin/sh -e

DIRS=$(find . -type d -maxdepth 2 -mindepth 2)

for DIR in ${DIRS}; do
    if [ -d "${DIR}/.git" ]; then
        cd "${DIR}"
        OUTPUT=$(git remote -v)

        if [ "${OUTPUT}" = "" ]; then
            echo "${DIR}"
        fi
    fi
done
