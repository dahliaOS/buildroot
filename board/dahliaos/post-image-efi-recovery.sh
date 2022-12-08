#!/bin/sh

set -e

UUID=$(dumpe2fs "$BINARIES_DIR/rootfs.btrfs" 2>/dev/null | sed -n 's/^Filesystem UUID: *\(.*\)/\1/p')
sed -i "s/UUID_TMP/$UUID/g" "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
sed "s/UUID_TMP/$UUID/g" board/dahliaos/genimage-efi-recovery.cfg > "$BINARIES_DIR/genimage-efi-recovery.cfg"


support/scripts/genimage.sh -c "$BINARIES_DIR/genimage-efi-recovery.cfg"
