#!/bin/sh -e

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    "${HOME}/src/macos-tools/bin/brew-update.sh"
    "${HOME}/src/macos-tools/bin/brew-cask-update.sh"
    "${HOME}/src/macos-tools/bin/mas-update.sh"
    "${HOME}/src/macos-tools/bin/macos-update.sh"
    "${HOME}/src/python-tools/bin/pip3-update.sh"
    "${HOME}/src/python-tools/bin/pip2-update.sh"
    "${HOME}/src/ruby-tools/bin/gem-update.sh"
elif [ -f /etc/debian_version ]; then
    "${HOME}/src/debian-tools/bin/update.sh"
elif [ -f /etc/arch-release ]; then
    arch-update.sh
fi

cd "${HOME}/src/ansible"
bin/play.sh --tags repository playbook/development.yaml
