#!/bin/sh -e

DIR="${HOME}/Documents/powerline"
mkdir -p "${DIR}"
cd "${DIR}"
URL="https://github.com/powerline/powerline/raw/develop/font"
FONT_FILE="PowerlineSymbols.otf"
CONFIG_FILE="10-powerline-symbols.conf"

if [ ! -f "${FONT_FILE}" ]; then
    wget "${URL}/${FONT_FILE}"
fi

if [ ! -f "${CONFIG_FILE}" ]; then
    wget "${URL}/${CONFIG_FILE}"
fi

FONT_DIR="${HOME}/.fonts"
mkdir -p "${FONT_DIR}"
cp PowerlineSymbols.otf "${FONT_DIR}"
fc-cache -vf "${FONT_DIR}"
FONT_CONFIG_DIR="${HOME}/.config/fontconfig/conf.d"
mkdir -p "${FONT_CONFIG_DIR}"
cp 10-powerline-symbols.conf "${FONT_CONFIG_DIR}"
