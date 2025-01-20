#!/bin/bash

#-- 요일 문자열
yoil="일월화수목금토"

#-- 이번주 일요일 (last Sun)
yy=$(date +%y --date='TZ="Asia/Seoul" 09:00 last Sun')
mm=$(date +%m --date='TZ="Asia/Seoul" 09:00 last Sun')
dd=$(date +%d --date='TZ="Asia/Seoul" 09:00 last Sun')
y2=${yy}; m2=${mm}; d2=${dd}
echo "---$y2---$m2---$d2---"

#-- 다음주 일요일 (next Sun)

#-- 이달의 마지막 날
last_dd=$(date -d "$(date +%Y-%m-01) + 1 month - 1 day" +%d)

total_ju=3 #-- 표시할 주

#-- XXX for all_week in {1..${total_ju}}
while [ $total_ju -gt 0 ]
do
	total_ju=$((total_ju - 1))
	this_week=""
	for week in {0..6} #-- 일..토
	do
		#--
		this_week="${this_week}| ${y2}${m2}${d2}${yoil:${week}:1} "
		#--
		if [ "x${dd}" == "x${last_dd}" ]; then #-- 말일인 경우.
			dd=1
			if [ "x${mm}" == "x12" ]; then
				mm=1
				if [ "x${yy}" == "x99" ]; then
					yy=0
				else
					yy=$(( $yy + 1 ))
				fi
				if [ "$yy" -lt "10" ]; then
					y2="0${yy}"
				else
					y2=$yy
				fi
			else
				mm=$(( $mm + 1 ))
			fi
			if [ "$mm" -lt "10" ]; then
				m2="0${mm}"
			else
				m2=$mm
			fi
		else #// 말일이 아닌 경우.
			dd=$(( $dd + 1 ))
		fi

		if [ "$dd" -lt "10" ]; then
			d2="0${dd}"
		else
			d2=$dd
		fi
	done
	this_week="${this_week}|"
	echo "---${this_week}---"
done
