#!/bin/sh

set -e

BOARD_DIR=$(dirname "$0")

# Detect boot strategy, EFI or BIOS
if [ -d "$BINARIES_DIR/efi-part/" ]; then
    cp -f "$BOARD_DIR/grub-efi.cfg" "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
else
    cp -f "$BOARD_DIR/grub-bios.cfg" "$TARGET_DIR/boot/grub/grub.cfg"

    # Copy grub 1st stage to binaries, required for genimage
    cp -f "$TARGET_DIR/grub.img" "$BINARIES_DIR"
fi

fallocate -l 512M "$BINARIES_DIR/stateful.img"
mkfs.btrfs -L stateful -f "$BINARIES_DIR/stateful.img"

#echo "Installing dahliaOS overlays to $(echo $TARGET_DIR)"
cp -rvf dahliaOS-overlays/* $TARGET_DIR
