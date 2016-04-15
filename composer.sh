#!/bin/sh -e

if [ "$(command -v php || true)" = "" ]; then
    echo "Command not found: php"

    exit 1
fi

BIN_DIRECTORY="${HOME}/.local/bin"
COMPOSER_BIN="${BIN_DIRECTORY}/composer"

if [ ! -f "${COMPOSER_BIN}" ]; then
    mkdir -p "${BIN_DIRECTORY}"
    curl -sS https://getcomposer.org/installer | php -- --install-dir="${BIN_DIRECTORY}" --filename=composer
fi

${COMPOSER_BIN} self-update
composer global require "squizlabs/php_codesniffer=*"
composer global require "phpmd/phpmd=*"
composer global update
