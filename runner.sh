#!/bin/bash
qemu-system-x86_64 -machine type=q35,accel=kvm -cpu host -smp $(nproc) --enable-kvm -m 4096 -cdrom output/images/rootfs.iso9660 -display vnc=0.0.0.0:0
