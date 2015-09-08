#!/bin/sh -e

echo "Run all updates."
OS=$(uname)
brew-update.sh "${1}"
gem-update.sh "${1}"
npm-update.sh "${1}"
pip2-update.sh "${1}"
pip3-update.sh "${1}"
atom-update.sh "${1}"
vim-update.sh
cabal-update.sh

if [ "${OS}" = "Darwin" ]; then
    osx-update.sh "${1}"
elif [ "${OS}" = "Linux" ]; then
    debian-update.sh "${1}"
fi
