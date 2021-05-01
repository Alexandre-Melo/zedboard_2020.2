# AES Key

*bootgen* can be used to generate AES keys, but this is a little bizarre how the procedure was documentated. 
You need to follow https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_2/ug1283-bootgen-user-guide.pdf
but this is obsolete! 

Notice that you need to have some data being encripted and a missing key file. You also need to indicate the -p parameter and the 
processor model to succeed in the key generation. This is not clearly stated anywhere. 


Then run the command 
 
``` 
./bootgen -image aeskey.bif -generate_keys
```

You will to find the bootgen binary within docker. It is located at build/tmp/work/x86_64-linux/bootgen-native/1.0-r0/recipe-sysroot-native/usr/bin

Bootgen will generate the aeskey.nky *if it cannot find the specified nky file* AND *if the [encryption=aes] is stated within the .bif file*.


# RSA Authentication

According to https://www.xilinx.com/support/documentation/application_notes/xapp1175_zynq_secure_boot.pdf

The following commands will generate the primary and secondary certificates. 
The primary will be used to sign the secondary when generating the device image.

```
openssl genrsa -out psk.pem 2048
openssl genrsa -out ssk.pem 2048

openssl rsa -pubout -in psk.pem -out ppk.pub
openssl rsa -pubout -in ssk.pem -out spk.pub
``` 

Use the following command to generate the primary public key hash. This will need to be saved on eFuses.

```
./bootgen -image bootgen.bif -efuseppkbits ppk_hash.txt
```

 
