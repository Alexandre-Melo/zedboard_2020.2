#!/bin/sh
OUTPUT_FOLDER="build/tmp/deploy/images/myzedboard"
FITIMAGE="fitImage-myzedboard-image-myzedboard-myzedboard"
BOOTBIN="boot.bin"
BOOTSCR="boot.scr"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 DESTINY_PATH"
    exit 9
fi

cp -v ${OUTPUT_FOLDER}/${FITIMAGE} $1/image.ub
cp -v ${OUTPUT_FOLDER}/${BOOTBIN} $1
#cp -v ${OUTPUT_FOLDER}/${BOOTSCR} $1