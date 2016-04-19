#!/bin/sh -e

JAR_DIRECTORY="$HOME/.local/jar"

if [ ! -d "${JAR_DIRECTORY}" ]; then
    mkdir -p "${JAR_DIRECTORY}"
fi

FILE="${JAR_DIRECTORY}/plantuml.jar"

if [ ! -f "${FILE}" ]; then
    wget http://downloads.sourceforge.net/project/plantuml/plantuml.jar --output-document "${FILE}"
fi

java -jar "${FILE}" "$@"
