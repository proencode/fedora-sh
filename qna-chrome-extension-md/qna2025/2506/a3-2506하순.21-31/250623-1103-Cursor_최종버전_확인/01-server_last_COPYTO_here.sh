#!/bin/sh

cc="(Cursor 최종버전 확인) cusr23.1103" #-- "cusr12.1039"

yymm="2506" #-- 2506
cd ~/Downloads; mkdir ${yymm}; cd ${yymm}

echo "#-- rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*/${yymm}/last* . #-- ${yymm}/last 를 이곳으로 가져옵니다."
echo "#-- press 'y':"
read a
if [ "x$a" != "xy" ]; then
	echo "#-- 'y' 가 아니므로 가져오기를 중단합니다."
	exit -1
fi
rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*/${yymm}/last* .
echo "#-- rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*/${yymm}/last* ."
