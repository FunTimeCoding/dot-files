#!/bin/sh -e

for FILE in ${HOME}/.local/bin/*; do
    FIRST_LINE=$(head -n 1 "${FILE}")
    echo "${FIRST_LINE}" | grep -q python && CONTAINS_PYTHON=true || CONTAINS_PYTHON=false

    if [ "${CONTAINS_PYTHON}" = true ]; then
        INTERPRETER=$(basename "${FIRST_LINE#\#!*}")

        if [ "${INTERPRETER}" = "python2" ]; then
            echo "Delete ${FILE}"
            rm "${FILE}"
        fi
    fi
done

rm -rf "${HOME}"/.local/lib/python2*
