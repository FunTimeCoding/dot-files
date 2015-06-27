#!/bin/sh -e

JAR_DIR="$HOME/.local/jar"

if [ ! -d "${JAR_DIR}" ]; then
    mkdir -p "${JAR_DIR}"
fi

FILE="${JAR_DIR}/plantuml.jar"

if [ ! -f "${FILE}" ]; then
    wget http://downloads.sourceforge.net/project/plantuml/plantuml.jar -O "${FILE}"
fi

java -jar "${FILE}" -tsvg "$@"
