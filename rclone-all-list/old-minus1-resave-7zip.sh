#!/bin/sh

for fn in $(rclone ls yosjgc: | grep " -1 " | awk -F"yosjgc:" '{print "yosjgc:"$2}')
do
	echo "----> $fn"
done
