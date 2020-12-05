#!/bin/sh

set -e

BOARD_DIR=$(dirname "$0")
OWD=$PWD
if [ -f "dahliaos-overlays/dahlia/pangolin_desktop/pangolin_desktop"]; then
    echo Using custom Pangolin build. Skipping automatic build.
else 
    if [ -d "$BINARIES_DIR/pangolin_desktop/" ]; then
        echo Pangolin folder already exists, updating it...
        cd $BINARIES_DIR/pangolin_desktop
        git pull
    else
        echo Pangolin folder does not exist, getting it...
        cd $BINARIES_DIR
        git clone https://github.com/dahlia-os/pangolin-desktop pangolin_desktop
        cd pangolin_desktop
    fi

    if ! which flutter 2>/dev/null || echo FALSE ; then
        echo Flutter available: building Pangolin
        flutter config --enable-linux-desktop
        flutter build linux
        if [ -d "$TARGET_DIR/dahlia/pangolin_desktop" ]; then
            echo Directory exists, continuing...
        else
            mkdir $TARGET_DIR/dahlia/pangolin_desktop
        fi
        cp -r build/linux/release/bundle/* $TARGET_DIR/dahlia/pangolin_desktop/
    else
        echo "WARNING: Flutter not available! Pangolin will not be included!"
    fi
fi
cd $OWD

# Detect boot strategy, EFI or BIOS
if [ -f "$BINARIES_DIR/efi-part/startup.nsh" ]; then
    cp -f "$BOARD_DIR/grub-efi.cfg" "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
else
    cp -f "$BOARD_DIR/grub-bios.cfg" "$TARGET_DIR/boot/grub/grub.cfg"

    # Copy grub 1st stage to binaries, required for genimage
    cp -f "$HOST_DIR/lib/grub/i386-pc/boot.img" "$BINARIES_DIR"
fi


