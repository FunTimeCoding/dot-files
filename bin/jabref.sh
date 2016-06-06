#!/bin/sh -e

JAR_DIRECTORY="${HOME}/.local/jar"

if [ ! -d "${JAR_DIRECTORY}" ]; then
    mkdir -p "${JAR_DIRECTORY}"
fi

FILE="${JAR_DIRECTORY}/jabref.jar"

if [ ! -f "${FILE}" ]; then
    wget https://github.com/JabRef/jabref/releases/download/v3.4/JabRef-3.4.jar --output-document "${FILE}"
fi

java -jar "${FILE}" "$@"
