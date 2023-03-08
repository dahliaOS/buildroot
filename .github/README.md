<p align="center">
<a href="https://dahliaos.io">Website</a> •
<a href="https://dahliaos.io/discord">Discord</a> •
<a href="https://dahliaos.io/download">Releases</a> •
<a href="https://dahliaos.io/donate">Donate</a> •
<a href="https://docs.dahliaos.io">Documentation</a>

# Buildroot

- Buildroot is a simple, efficient and easy-to-use tool to generate embedded Linux systems through cross-compilation.
- This tool compiles dahliaOS Linux-based builds.

This project is a fork from [AdvancedClimateSystems/docker-buildroot](https://github.com/AdvancedClimateSystems/docker-buildroot).

## Install Docker

- We use Docker so that we don't have to install all sorts of packages, everything is already included in this Docker image.

- You can find Docker installation instructions [here](https://docs.docker.com/get-docker/).

## Usage

1. Build the Docker image

``` shell
sudo docker build -t "dahliaos/buildroot:latest" .
```

2. Setup Buildroot's volumes

``` shell
$ docker run -i --name buildroot_output dahliaos/buildroot /bin/echo "Data only."
```

This container has 2 volumes at `/root/buildroot/dl` and `/buildroot_output`.
Buildroot downloads all data to the first volume, the last volume contains the build cache, the cross compiler and the build results.

3. Run:

- ```sudo ./build make menuconfig``` to configure the build settings
- ```sudo ./build make linux-menuconfig``` to configure the Linux kernel
- ```sudo ./build make``` to compile the image, which can be found on the host machine in ```/images``` 

## Build and reload

To compile and run the base dahliaOS toolchain, use:

```sh
sudo ./build make&&qemu-system-x86_64 --enable-kvm -m 4096 -cdrom images/rootfs.iso9660&&cp images/rootfs.iso9660 images/rootfs.iso
```

## Requirements

It is recommended to have at miniumum an Ethernet connection (directly to thr router), a dual-core x86 CPU and at least 4GB of RAM when compiling.

We personally recommend a 4C/8T or better CPU with 16GB of RAM for optimal speeds.

You will also need a decent amount of hard drive space, we recommend around 50GB if you clear out the build directory often. 

It takes around 6 hours to build a full image from scratch on a Dell Optiplex 790 with a 3GHZ i5-2400 and 16GB of RAM. 

We are sure a Threadripper or a newer Xeon CPU could easily handle compiling.

## Warning:

- If you are using a laptop, make sure that you are aware of its temperature, some laptops easily heat up to 93-100c when compiling.

## To do

- [ ] Add the Surface touchscreen patches to the kernel via Buildroot: https://github.com/linux-surface/linux-surface

- [ ] Add the Nvidia driver in the Buildroot config

## Contribute

If you're wondering how to contribute to the project, please refer to [CONTRIBUTING.md](../CONTRIBUTING.md)

## License

<p align="left">
  <img width="30%" src="https://github.com/dahliaOS/brand/blob/main/dahliaOS/logotype/svg/logotype-dark.svg#gh-dark-mode-only"/>
  <img width="30%" src="https://github.com/dahliaOS/brand/blob/main/dahliaOS/logotype/svg/logotype-light.svg#gh-light-mode-only"/>
</p>

Copyright @ 2019-2023 - The dahliaOS Authors - contact@dahliaos.io

Copyright @ 2017 - Auke Willem Oosterhoff and [Advanced Climate Systems](https://acs-buildings.com/).

This project is licensed under the [Mozilla Public License](/LICENSE)
