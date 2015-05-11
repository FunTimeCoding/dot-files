#!/bin/sh -a

brew update
brew outdated
echo "Run upgrade and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    brew upgrade --all
    brew cleanup -s
fi
