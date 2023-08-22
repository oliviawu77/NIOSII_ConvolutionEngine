#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting Binary File: C:\intelFPGA_lite\18.0\NiosIISystem\software\Zip\system\files.zip to: "..\flash/files_ext_flash.flash"
#
bin2flash --input="C:/intelFPGA_lite/18.0/NiosIISystem/software/Zip/system/files.zip" --output="../flash/files_ext_flash.flash" --location=0x0 --verbose 

#
# Programming File: "..\flash/files_ext_flash.flash" To Device: ext_flash
#
nios2-flash-programmer "../flash/files_ext_flash.flash" --base=0x4000000 --sidp=0xC103030 --id=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-BlasterII on localhost [USB-1]' --program --verbose 

