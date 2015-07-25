#!/bin/sh -e

echo "Run all updates."
brew-update.sh
gem-update.sh
npm-update.sh
pip2-update.sh
pip3-update.sh
