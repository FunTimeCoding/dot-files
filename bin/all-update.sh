#!/bin/sh -e

echo "Run all updates."
OS=$(uname)
vim-update.sh
brew-update.sh "${1}"
gem-update.sh "${1}"
npm-update.sh "${1}"
pip2-update.sh "${1}"
pip3-update.sh "${1}"
atom-update.sh "${1}"
cabal-update.sh

if [ "${OS}" = "Darwin" ]; then
    osx-update.sh "${1}"
elif [ "${OS}" = "Linux" ]; then
    debian-update.sh "${1}"
fi

cd "${HOME}/Code"
repo-update.rb -d 2
