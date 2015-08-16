#!/bin/sh -e

LIST=$(grep -v '^#' < /etc/passwd | awk 'BEGIN { FS = ":" }; {print $1}')

for ELEMENT in ${LIST}; do
    if [ ! "${ELEMENT}" = "" ]; then
        echo "User: ${ELEMENT}"
        INNER_LIST=$(sudo crontab -u "${ELEMENT}" -l | grep -v '^#' )

        for INNER_ELEMENT in ${INNER_LIST}; do
            echo "${INNER_ELEMENT}"
        done

        echo
    fi
done
