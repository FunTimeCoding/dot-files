#!/bin/sh -e

echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    npm install -g npm
    npm up -g
fi
