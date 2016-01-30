#!/bin/sh

python2 -m ensurepip --user
pip2 install --upgrade --user pip setuptools
pip2 install --upgrade --user powerline-status
rm "${HOME}/.local/bin/pip"
