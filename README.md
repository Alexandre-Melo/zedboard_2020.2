# zedboard_2020.2

Zedboard Yocto OS study based on release of Xilinx 2020.2 layers

## Getting started 

This was started following this tutorial:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841862/Install+and+Build+with+Xilinx+Yocto

A custom layer meta-myzedboard was created based on this tutorial:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/57836605/Creating+a+Custom+Xilinx+Yocto+Layer

The result is an intermediate result, which is capable of booting by manually entering commands at uboot shell

```
[...]
Hit any key to stop autoboot:  0 
Zynq> fatload mmc 0 0x2000000 image.ub
Zynq> bootm 0x2000000
Loading kernel from FIT Image at 02000000 ...
[...]

```

## Changing default environment of U-boot (instead of using boot.scr solution as suggested by Xilinx tutorial)

Using devtool, as indicated at https://wiki.yoctoproject.org/wiki/TipsAndTricks/Patching_the_source_for_a_recipe

```
devtool modify u-boot-xlnx
... edit files at workspace dir at build directory ...
devtool update-recipe -a ../meta-myzedboard u-boot-xlnx
devtool reset u-boot-xlnx
```

This created the patch for u-boot at meta-myzedboard


