#!/bin/sh

python3 -m ensurepip --user
pip3 install --upgrade --user pip setuptools
pip3 install --upgrade --user powerline-status
rm "${HOME}/.local/bin/pip"
