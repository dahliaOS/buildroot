# Buildroot
A Docker image for using [Buildroot][buildroot]. It can be found on [Docker
Hub][hub].

## Get started
To get started build the Docker image.

``` shell
$ docker build -t "dahlia/buildroot:latest" .
```

Create a [data-only container][data-only] to use as build and download
cache and to store your build products.

``` shell
$ docker run -i --name buildroot_output dahlia/buildroot /bin/echo "Data only."
```

This container has 2 volumes at `/root/buildroot/dl` and `/buildroot_output`.
Buildroot downloads all data to the first volume, the last volume is used as
build cache, cross compiler and build results.

## Usage
A small script has been provided to make using the container a little easier.
It's located at [scripts/run.sh][run.sh]. Instructions below show how
to build a kernel for the Raspberry Pi using the a defconfig provided by
Buildroot.

``` shell
$ ./scripts/run.sh make raspberrypi2_defconfig menuconfig
$ ./scripts/run.sh make
```

Build products are stored inside the container at `/buildroot_output/images`.
Because `run.sh` mounts the local folder `images/` at this place the
build products are also stored on the host.

## Build with existing config
It is possible to build from a custom configuration. To demonstrate this, the
repository contains a configuration to build a minimal root filesystem, around
25 mb, with Python 2. This config is located at
[external/configs/docker_python2_defconfig][docker_python2_defconfig].

The `external/` directory contains a set of modifications for Buildroot. The
modifications can be apllied with the environment variable `BR2_EXTERNAL`.
Read [here][br2_external] more about customizations of Buildroot.

```shell
$ ./scripts/run.sh make "BR2_EXTERNAL=/root/buildroot/external docker_python2_defconfig menuconfig"
$ ./scripts/run.sh make
```

If you've modified the configuration using `menuconfig` and you want to save
those changes run:

```shell
$ ./scripts/run.sh make BR2_DEFCONFIG=/root/buildroot/external/configs/docker_python2_defconfig savedefconfig
```
## Docker image from root fileystem
Import the root filesystem in to Docker to create an image run it and start
a container.

```shell
$ docker import - dietfs < images/rootfs.tar
$ docker run --rm -ti dietfs sh
```
## License
This software is licensed under Mozila Public License.
&copy; 2017 Auke Willem Oosterhoff and [Advanced Climate Systems][acs].

[acs]:http://advancedclimate.nl
[buildroot]:http://buildroot.uclibc.org/
[data-only]:https://docs.docker.com/userguide/dockervolumes/
[hub]:https://hub.docker.com/r/advancedclimatesystems/docker-buildroot/builds/
[run.sh]:scripts/run.sh
[docker_python2_defconfig]:external/configs/docker_python2_defconfig
[br2_external]:http://buildroot.uclibc.org/downloads/manual/manual.html#outside-br-custom
[docker_blog]:https://blog.docker.com/2013/06/create-light-weight-docker-containers-buildroot/
