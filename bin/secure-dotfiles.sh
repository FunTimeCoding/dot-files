#!/bin/sh -e

FILES=$(ls -al | grep ^- | awk '{print $9}')

for FILE in ${FILES}; do
    FIRST=$(echo "${FILE}" | cut -c 1-1)

    if [ "${FIRST}" = "." ]; then
        ls -l "${FILE}"
    fi
done

echo "Apply chmod 600? [y/n]"
read -r READ

if [ ! "${READ}" = "y" ]; then
    exit 0
fi

DOTFILES_CONFIG="${HOME}/.dotfiles.conf"

if [ -f "${DOTFILES_CONFIG}" ]; then
    . "${DOTFILES_CONFIG}"
else
    GROUP_LIST=""
    READ_ONLY_LIST=""
fi

for FILE in ${FILES}; do
    FIRST=$(echo "${FILE}" | cut -c 1-1)

    if [ "${FIRST}" = "." ]; then
        GROUP_SEARCH=$(echo "${GROUP_LIST}" | grep "${FILE}") || GROUP_SEARCH=""

        if [ "${GROUP_SEARCH}" = "${FILE}" ]; then
            echo "Group readable: ${FILE}"
            chmod 640 "${FILE}"

            continue
        fi

        READ_ONLY_SEARCH=$(echo "${READ_ONLY_LIST}" | grep "${FILE}") || READ_ONLY_SEARCH=""

        if [ "${READ_ONLY_SEARCH}" = "${FILE}" ]; then
            echo "Read only: ${FILE}"
            chmod 400 "${FILE}"

            continue
        fi

        chmod 600 "${FILE}"
    fi
done
