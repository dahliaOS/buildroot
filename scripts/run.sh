#!/bin/bash
# Start container and start process inside container.
#
# Example:
#   ./run.sh            Start a sh shell inside container.
#   ./run.sh ls -la     Run `ls -la` inside container.
#
# Calls to `make` are intercepted and the "O=/buildroot_output" is added to
# command. So calling `./run.sh make savedefconfig` will run `make
# savedefconfig O=/buildroot_output` inside the container.
#
# Example:
#   ./run.sh make       Run `make O=/buildroot_output` in container.
#   ./run.sh make docker_python2_defconfig menuconfig
#                       Build config based on docker_python2_defconfig.
#
# When working with Buildroot you probably want to create a config, build
# some products based on that config and save the config for future use.
# Your workflow will look something like this:
#
# ./run.sh make docker_python2_defconfig defconfig
# ./run.sh make menuconfig
# ./run.sh make BR2_DEFCONFIG=/root/buildroot/external/configs/docker_python2_defconfig savedefconfig
# ./run.sh make
set -e

echo "it has ran!"

OUTPUT_DIR=/buildroot_output
BUILDROOT_DIR=/root/buildroot

DOCKER_RUN="docker run
    --rm
    -ti
    --volumes-from buildroot_output
    -v $(pwd)/data:$BUILDROOT_DIR/data
    -v $(pwd)/external:$BUILDROOT_DIR/external
    -v $(pwd)/rootfs_overlay:$BUILDROOT_DIR/rootfs_overlay
    -v $(pwd)/images:$OUTPUT_DIR/images
    dahlia/buildroot:latest"

make() {
    echo "make O=$OUTPUT_DIR"
}

echo $DOCKER_RUN
if [ "$1" == "make" ]; then
    eval $DOCKER_RUN $(make) ${@:2}
else
    eval $DOCKER_RUN $@
fi
