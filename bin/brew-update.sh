#!/bin/sh -e

brew update
brew outdated
echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    brew upgrade --all
    brew cleanup -s
fi
