#!/bin/sh -e

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    brew-update.sh
    brew-cask-update.sh
    mas-update.sh
    macos-update.sh
    pip3-update.sh
    pip2-update.sh
    gem-update.sh
elif [ -f /etc/debian_version ]; then
    "${HOME}/src/debian-tools/bin/update.sh"
elif [ -f /etc/arch-release ]; then
    arch-update.sh
fi

cd "${HOME}/src/ansible"
bin/play.sh playbook/repositories.yaml
