#!/bin/sh

cc="(다운로드사이트 버전확인) gemini01.1155" #-- "cusr12.1039"

yymm="2507" #-- 2506
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
