#!/bin/sh -e

sudo pacman -Syu
sudo yaourt -Syu --aur
# Recursively remove orphans.
pacman -Rns $(pacman -Qtdq)
