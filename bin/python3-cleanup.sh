#!/bin/sh -e

for FILE in ${HOME}/.local/bin/*; do
    FIRST_LINE=$(head -n 1 "${FILE}")
    echo "${FIRST_LINE}" | grep -q python && CONTAINS_PYTHON=true || CONTAINS_PYTHON=false

    if [ "${CONTAINS_PYTHON}" = true ]; then
        INTERPRETER=$(basename "${FIRST_LINE#\#!*}")

        if [ "${INTERPRETER}" = "python3" ]; then
            echo "Delete ${FILE}"
            rm "${FILE}"
        fi
    fi
done

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    rm -rf "${HOME}"/.local/lib/python3*
elif [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    rm -rf "${HOME}"/Library/Python/3*
else
    echo "Unsupported operating system: ${OPERATING_SYSTEM}"

    exit 1
fi
