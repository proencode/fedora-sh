#!/bin/sh

for i in {11..199}
do
	ping -c 1 192.168.219.${i}  | grep "시간=" &
done
