#!/bin/sh

cc="cusr15.1107" #-- "cusr12.1039"

yymm="2506" #-- 2506
cd ~/Downloads; mkdir ; cd 

echo "#-- rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*//last* . #-- /last 를 이곳으로 가져옵니다."
echo "#-- press 'y':"
read a
if [ "x" != "xy" ]; then
	echo "#-- 'y' 가 아니므로 가져오기를 중단합니다."
	exit -1
fi
rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*//last* .
echo "#-- rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*//last* ."
