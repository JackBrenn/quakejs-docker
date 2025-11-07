#!/bin/sh

#You need to have libarchive-zip-perl installed in order to use crc32 command
#
# sudo apt install libarchive-zip-perl
#
# Examples
#
# crc32-info for one file
# ./crc32info /var/www/html/pak0.pk3
#
# crc32-info all pk3-files in a directory
# ./crc32info /var/www/htnl/*pk3

printf "CRC32\tFilename\n"

for file in "$@"
do
  checksum=$((0x$(crc32 $file)))
  printf "$checksum\t$file\n"
done
