#!/bin/sh

cat <<__EOF__
#-- [yymm: $1] [original_file: $1]
#--
__EOF__

yymm=$1
if [ "x${yymm}" \< "x2101" ] || [ "x${yymm}" \> "x2912" ]; then
	echo "Error: yymm: 2101 ... 2912"
	exit -1
fi
original_file=$2
if [ ! -f ${original_file} ]; then
	echo "Error: '${original_file}' NOT found"
	exit -1
fi

name_change=$(echo ${original_file} | sed 's/ /_/g')

echo "----> rclone ls y5ncmi:eb/${yymm}"
rclone ls y5ncmi:eb/${yymm}
echo "----> rclone copy \"${original_file}\" y5ncmi:eb/${yymm}/${name_change}"
echo "----> press Enter:"
read a
rclone copy "${original_file}" y5ncmi:eb/${yymm}/${name_change}
echo "----> rclone ls y5ncmi:eb/${yymm}"
rclone ls y5ncmi:eb/${yymm}
