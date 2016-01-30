#!/bin/sh

python2 -m ensurepip --user
pip2 install --upgrade --user pip setuptools
rm "${HOME}/.local/bin/pip"
