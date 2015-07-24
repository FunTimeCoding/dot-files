#!/bin/sh -e

echo "pip2"
PIP2_PACKAGES=$(pip2 list --outdated 2> /dev/null | awk '{ print $1 }')
echo ${PIP2_PACKAGES}
echo "pip3"
PIP3_PACKAGES=$(pip3 list --outdated 2> /dev/null | awk '{ print $1 }')
echo ${PIP3_PACKAGES}
echo "Update packages and cleanup? [y/n]"
read READ

if [ "${READ}" = "y" ]; then
    pip2 install -U pip setuptools

    for PACKAGE in ${PIP2_PACKAGES}; do
        pip2 install -U ${PACKAGE}
    done

    pip3 install -U pip setuptools

    for PACKAGE in ${PIP3_PACKAGES}; do
        pip3 install -U ${PACKAGE}
    done
fi
