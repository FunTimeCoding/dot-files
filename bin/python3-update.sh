#!/bin/sh

pip3 remove powerline-status
rm -rf "${HOME}/.local/lib/python3.5"
rm "${HOME}/.local/bin/pip"
rm "${HOME}/.local/bin/pip3*"
python3 -m ensurepip --user
pip3 install --upgrade --user pip setuptools
pip3 install --upgrade --user powerline-status
rm "${HOME}/.local/bin/pip"
