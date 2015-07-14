#!/bin/sh -e

echo "pip2"
pip2 list --outdated
echo "pip3"
pip3 list --outdated
echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    pip2 install -U pip setuptools
    pip3 install -U pip setuptools
    echo "You should manually update what you need."
fi
