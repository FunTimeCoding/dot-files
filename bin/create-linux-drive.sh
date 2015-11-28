#!bin/sh -e

LOCATOR="http://example.org/linux.iso"
echo "Enter URL. Example: ${LOCATOR}"
read -r LOCATOR
wget "${LOCATOR}" -O linux.iso
hdiutil convert -format UDRW -o linux.img linux.iso
mv linux.img.dmg linux.img
echo "List of targets:"
diskutil list
TARGET="disk2"
echo "Select target. Example: ${TARGET}"
read -r TARGET
diskutil unmountDisk "/dev/${TARGET}"
sudo dd if=linux.img of="/dev/r${TARGET}" bs=1m
diskutil eject "/dev/${TARGET}"
