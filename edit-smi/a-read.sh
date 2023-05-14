#!/bin/sh

cat $1 | while read line
do
	if [ "${line:0:12}" = "<SYNC Start=" ]; then
		if [ "${line:0:19}" > "<SYNC Start=1556926" ]; then
			echo "----${line}===="
		fi
	fi
done
