#!/bin/sh

for i in $(ls calls-*.xml)
do
	echo "#----> time 7za a -mx=9 -p ${i}.7z ${i}"
	time 7za a -mx=9 -p ${i}.7z ${i}
done
