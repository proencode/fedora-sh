#!/bin/sh

name_a="240616-1730노들섬" #-- 240616-1730노들섬10.jpg
#------ -----|-----------
move_a="240615-1730노들섬"
name_b=".jpg"

echo "#-- exit -1 #-- 240616-2140 작업완료"
exit -1 #-- 240616-2140 작업완료

cnt=100

for i in {0..10}
do
	nb=${cnt:(-2)}
	echo "#-- mv ${name_a}${nb}${name_b} ${move_a}${nb}${name_b}"
	mv ${name_a}${nb}${name_b} ${move_a}${nb}${name_b}
	echo "#-- rclone moveto yosjgc:root/phone/${name_a}${nb}${name_b} yosjgc:root/phone/${move_a}${nb}${name_b}"
	rclone moveto yosjgc:root/phone/${name_a}${nb}${name_b} yosjgc:root/phone/${move_a}${nb}${name_b}
	cnt=$(( cnt + 1 ))
done
echo "#-- ls 24061*"
ls 24061*
echo "#-- rclone ls yosjgc:root/phone/ --include \"24061*\""
rclone ls yosjgc:root/phone/ --include "24061*"
