#!/bin/sh -e

gem outdated
echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    gem update
    gem cleanup
fi
