#!/bin/sh -e

for USER in $(cut -f1 -d: /etc/passwd); do
    echo "User: ${USER}"
    OUTPUT=$(sudo crontab -u "${USER}" -l)

    while read -r LINE; do
        FIRST_CHARACTER="${LINE:0:1}"

        if [ ! "${LINE}" = "" ] && [ ! "${FIRST_CHARACTER}" = "#" ]; then
            echo "${LINE}"
        fi
    done <<< "${OUTPUT}"

    echo
done
