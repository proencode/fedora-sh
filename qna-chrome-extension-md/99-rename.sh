#!/bin/sh

for i in $(ls *md)
do
	d=$(echo $i | sed 's/.md//')
	echo "#-- mkdir $d; mv $i $d/"
	mkdir $d; mv $i $d/
done
