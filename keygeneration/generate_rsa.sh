#!/bin/sh

#According to https://www.xilinx.com/support/documentation/application_notes/xapp1175_zynq_secure_boot.pdf

openssl genrsa -out psk.pem 2048
openssl genrsa -out ssk.pem 2048

openssl rsa -pubout -in psk.pem -out ppk.pub
openssl rsa -pubout -in ssk.pem -out spk.pub

echo Use the following command to generate the primary public key hash
echo ./bootgen -image bootgen.bif -efuseppkbits ppk_hash.txt