#!/bin/sh -e

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    brew-update.sh
    pip3-update.sh
    pip2-update.sh
    gem-update.sh
    brew-cask-update.sh
    mas-update.sh
    macos-update.sh
elif [ -f /etc/debian_version ]; then
    debian-update.sh
elif [ -f /etc/arch-release ]; then
    arch-update.sh
fi

cd "${HOME}/src/ansible"
bin/run-playbook.sh playbooks/repositories.yaml
