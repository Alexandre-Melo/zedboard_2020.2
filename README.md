# zedboard_2020.2

Zedboard Yocto OS study based on release of Xilinx 2020.2 layers

## How to use this

- 1 - (Only once) Download Xilinx repository with *./xilinx_repo_init.sh*
- 2 - Run docker with *./setup.sh*. The first run will take a while, since all compilation dependencies will be downloaded. 
- 3 - Prepare the compilation environment with *. setupsdk*.
- 4 - Compile the image with *bitbake myzedboard-image*. This will take a few hours on the first run, with long download hours.
 wait.
- 5 - In another console, outside of docker, run *./prepare_sd.sh* to send BOOT.bin and image.ub to the sdcard
- 6 - Set jumpers of Zedboard JP[7...11] to [00110] to enable the boot by the SD card
- 7 - Insert the prepared sd card and use a console to watch the boot.



# How was this developed?

## Getting started 

This was started following this tutorial:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841862/Install+and+Build+with+Xilinx+Yocto

A custom layer meta-myzedboard was created based on this tutorial, without any additional recipe:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/57836605/Creating+a+Custom+Xilinx+Yocto+Layer

This is an intermediate result, which is capable of booting by manually entering commands at uboot shell

```
[...]
Hit any key to stop autoboot:  0 
Zynq> fatload mmc 0 0x2000000 image.ub
Zynq> bootm 0x2000000
Loading kernel from FIT Image at 02000000 ...
[...]

```

The size of this image is (compiled with bitbake petalinux-image-minimal as stated at Xilinx tutorial):
- boot.bin: 1.4Mbytes -- U-boot and PL .bit.bin
- image.ub: 29Mbytes -- kernel: 4Mbytes initramfs: 24Mbytes


## Changing default environment of U-boot (instead of using boot.scr solution as suggested by Xilinx tutorial)

Using devtool, as indicated at https://wiki.yoctoproject.org/wiki/TipsAndTricks/Patching_the_source_for_a_recipe

```
devtool modify u-boot-xlnx
... edit files at workspace dir at build directory ...
devtool update-recipe -a ../meta-myzedboard u-boot-xlnx
devtool reset u-boot-xlnx
```

This created the patch for u-boot at meta-myzedboard. Basically the Default bootcmd variable was hardcoded to boot the fitimage (image.ub) at the SD Card.


#Creation of myzedboard-image.bb and machine/myzedboard.conf

The machine/myzedboard.conf file was created based on 
Xilinx/sources/meta-xilinx/meta-xilinx-bsp/conf/machine/zedboard-zynq7.conf

The meta-myzedboard/recipes-core/images/myzedimage-image.bb was created, based on
https://hub.mender.io/t/how-to-create-custom-images-using-yocto-project/902/1

This *image.bb was created considering the pending tasks

The size of this image is (compiled with bitbake myzedboard-image):
- boot.bin: 1.4Mbytes -- U-boot and PL .bit.bin
- image.ub: 8.8Mbytes -- kernel: 4Mbytes initramfs: 4.5Mbytes


## Pending implementations

- [x] basic functional image
- [ ] RSA boot, checking signatures of BOOT.bin and image.ub
- [ ] AES of BOOT.bin and image.ub
- [x] ~~find out howto use zImage, to reduce their size.~~ this is the default setup
- [ ] Remove PL bit.bin from BOOT.bin and send it to a "lazy load", which did not work properly so far
- [ ] add public keys to allow SSH
- [ ] replace root by another user
- [ ] remove uboot console, or find a other way to avoid changing uEnv
- [x] reduce the size of image.ub which is way too big

