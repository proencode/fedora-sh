#!/bin/sh

if [ "x$1" != "x" ]; then
	c_name="$1"
else
	echo "----> From directory name:"
	read c_name
	if [ "x$c_name" = "x" ]; then
		exit -1
	fi
fi
if [ "x$2" != "x" ]; then
	d_name="$2"
else
	echo "----> To directory name:"
	read d_name
	if [ "x$d_name" = "x" ]; then
		exit -1
	fi
fi
echo "----> $c_name is"
echo "$c_name"
echo "::::> $d_name is"
echo "$d_name"
echo "====> press Enter: for $c_name =:= $d_name"
read a
echo "-ok-"

for dd in fedora-36-iso  fedora-37-iso  vdi-fedora-37  windows-iso fedora-36-vdi-etc  vdi-ubuntu-2203  vdi-windows
do
	# echo "----> ls ./backup-files/$dd /d/backup-files/$dd | sort #-- | uniq"
	# ls ./backup-files/$dd /d/backup-files/$dd | sort #-- | uniq
	# c_name="./backup-files"
	c_dir=$(ls -l $c_name/$dd | grep -v "^total ")
	# d_name="/d/backup-files"
	d_dir=$(ls -l $d_name/$dd | grep -v "^total ")
	if [ "x$c_dir" = "x$d_dir" ]; then
		echo "====> $dd is equal"
	else
		echo "----> $c_name/$dd is"
		echo "$c_dir"
		echo "::::> $d_name/$dd is"
		echo "$d_dir"
	fi
done
