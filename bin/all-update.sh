#!/bin/sh -e

#nvim-update.sh # No plugin manager used.
pip3-update.sh
pip2-update.sh
#atom-update.sh # No plugins used.
#npm-update.sh # NPM has an issue when updating from a script instead of an interactive shell. It keeps updating the same versions or something.
gem-update.sh
#cabal-update.sh # This always installs the same things over and over, even if they are already installed.
#php-update.sh # Unstable
SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    brew-update.sh
    macos-update.sh
else
    if [ -f /etc/arch-release ]; then
        arch-update.sh
    elif [ -f /etc/debian_version ]; then
        debian-update.sh
    fi
fi

cd "${HOME}/src/ansible"
bin/run-playbook.sh playbooks/repositories.yaml
