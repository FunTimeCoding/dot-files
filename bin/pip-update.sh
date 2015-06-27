#!/bin/sh -e

echo "pip2"
pip2 list --outdated
echo "pip3"
pip3 list --outdated
echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    echo "You should manually update what you need."
fi
