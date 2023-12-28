#!/bin/sh

yoil=$(date +%u) #-- %u (1은 월요일...7은 일요일). %w (0은 일요일...6 은 토요일)

for base in cadbase emailbase georaebase kaosorder2 scanbase
do
	if [ "x${yoil}" = "x7" ]; then
		grep_value=$(date -d '2 day ago' +%y%m%d) #-- 7(일요일) 이면 2일전인 금요일 데이터를 본다.
	else
		grep_value=$(date -d '1 day ago' +%y%m%d) #-- 일요일이 아니면 하루전의 데이터를 본다.
	fi
	echo "----> rclone lsl kaosngc:kaosdb/$(date +%Y)/${base}/$(date +%m)/ | grep \" $(date -d '1 day ago' +%y%m%d)-\""
	rclone lsl kaosngc:kaosdb/$(date +%Y)/${base}/$(date +%m)/ | grep " $(date -d '1 day ago' +%y%m%d)-"
done
