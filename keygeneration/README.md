#AES Key

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
 