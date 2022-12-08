<p align="center">
<a href="https://dahliaos.io">Website</a> •
<a href="https://dahliaos.io/discord">Discord</a> •
<a href="https://dahliaos.io/download">Releases</a> •
<a href="https://dahliaos.io/donate">Donate</a> •
<a href="https://docs.dahliaos.io">Documentation</a>

# Buildroot

- Buildroot is a simple, efficient and easy-to-use tool to generate embedded Linux systems through cross-compilation
- This tool compiles dahliaOS Linux-based builds

## Required packages
- syslinux-utils
- ccd2iso
- docbook-xsl
- clang

## Usage

- ```make menuconfig``` to configure the build settings
- ```make linux-menuconfig``` to configure the Linux kernel
- ```make``` to compile the image, which can be found under ```output/images```

Files can be inserted into the image using the ```output/target``` directory

## Build and reload

To compile and run the base dahliaOS toolchain, use:

- ```make&&qemu-system-x86_64 --enable-kvm -m 4096 -cdrom output/images/rootfs.iso9660&&cp output/images/rootfs.iso9660 output/images/rootfs.iso```

## Requirements

It is recommended to have at minumum an Ethernet connection (directly to router), a dual-core x86 CPU and at least 4GB of RAM when compiling.

I personally recommend a 4C/8T or better CPU with 16GB of RAM for optimal speeds.

You will also need a decent amount of hard drive space, I recommend around 50GB if you clear out the build directory often. 

It takes around 6 hours to build a full image from scratch on a Dell Optiplex 790 with a 3GHZ i5-2400 and 16GB of RAM. 

I am sure a Threadripper or a newer Xeon CPU could easily handle compiling.

## Warning:

- If you are using a laptop, make sure that you are aware of its temperature, some laptops easily heat up to 93-100c when compiling.

## Contribute

If you're wondering how to contribute to the project, please refer to [CONTRIBUTING.md](../CONTRIBUTING.md)

## License

<p align="left">
  <img width="30%" src="https://github.com/dahliaOS/brand/blob/main/dahliaOS/logotype/svg/logotype-dark.svg#gh-dark-mode-only"/>
  <img width="30%" src="https://github.com/dahliaOS/brand/blob/main/dahliaOS/logotype/svg/logotype-light.svg#gh-light-mode-only"/>
</p>

Copyright @ 2019-2022 - The dahliaOS Authors - contact@dahliaos.io

This project is licensed under the [Apache 2.0 license](/LICENSE)
