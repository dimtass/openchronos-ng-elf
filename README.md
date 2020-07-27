CMake template for TI eZ430 Chronos
----

[![dimtass](https://circleci.com/gh/dimtass/openchronos-ng-elf.svg?style=svg)](https://circleci.com/gh/dimtass/openchronos-ng-elf)

This repo is a fork from [here](https://github.com/BenjaminSoelberg/openchronos-ng-elf).

The reason I've forked the repo is that it wasn't working for me and therefore needed to
update some parts in order to be able to built using cmake. I've also created a docker image
that contains the `msp430-gcc-9.2.0.50_linux64` toolchain using packer and Ansible.

There is already some documentation in the original repo, but there are a few things that
are deprecated. Also, I'll only provide some info on how to build this repo and flash the
code.

> Note: The [http://www.ti.com/lit/zip/slac388](http://www.ti.com/lit/zip/slac388) support
package from TI is not available online anymore and I couldn't also find it anywhere. For
this reason I was only able to flash the firmware via USB and using [mspdebug](https://github.com/dlbeer/mspdebug)

Configure the firmware
----

You can configure the firmware and select which modules you need. To do this, run:
```sh
docker run --rm -it -v $(pwd):/tmp -w=/tmp dimtass/msp430-cde-image:latest -c "python ./tools/config.py"
```

Then select the modules you need. After this you need to create the `modinit.c` file. To do
this run the following command:
```sh
docker run --rm -it -v $(pwd):/tmp -w=/tmp dimtass/msp430-cde-image:latest -c "python ./tools/make_modinit.py"
```

Building the firmware
----

It's better to use the docker image in order to build the firmware, so you don't have to
install the toolchain and several other packages needed for the image. In order to do this
you need to run the following command:

```sh
docker run --rm -it -v $(pwd):/tmp -w=/tmp dimtass/msp430-cde-image:latest -c ./build.sh
```

The above command will create a new folder ('build-msp430/`) and build the firmware in there.
The resulted file will be the `openchronos.elf`.

Flashing the firmware
----

In order to flash the firmware you need the `mspdebug` tool, but you don't have to install it
because it's already installed in the docker image. Nevertheless, you need to give docker access
to the USB ports, therefore you need to run the following command (after you've built the firmware)

```sh
docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd):/tmp -w=/tmp dimtass/msp430-cde-image:latest -c ./flash.sh
```
