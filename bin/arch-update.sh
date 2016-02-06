#!/bin/sh -e

sudo pacman -Syu
yaourt -Syua

ORPHANS=$(pacman -Qtdq) || true

if [ ! "${ORPHANS}" = "" ]; then
    sudo pacman -Rns ${ORPHANS}
fi
