#!/bin/bash

code_table="0123456789abcdefghijkmnpqrstuvwxyz"

cat <<__EOF__
#-- 
#-- sh $0 proj_name #-- 프로젝트 이름을 proj_name 처럼 입력하면 설명에 추가합니다.
#-- 

__EOF__

proj_name=""

if [ "x$1" != "x" ]; then
	proj_name="$1-"
else
	gen_code=""
	for current_date in {1..12}
	do
		#-- date_code=${code_table:$(($current_date - 1)):1} #-- current_date 가 1 부터 시작하므로 -1 함.
		date_code=${code_table:$current_date:1} #-- current_date 가 0 일때 오류를 막기 위해.
		gen_code="${gen_code} ${current_date}월(${date_code})"
	done
	cat <<__EOF__
월 코드: ${gen_code}

__EOF__

	gen_code=""
	for current_date in {1..31}
	do
		date_code=${code_table:$current_date:1}
		gen_code="${gen_code} ${current_date}일(${date_code})"
	done
	cat <<__EOF__
일 코드: ${gen_code}

__EOF__

	gen_code=""
	for current_date in {0..23}
	do
		date_code=${code_table:$current_date:1}
		gen_code="${gen_code} ${current_date}시(${date_code})"
	done
	cat <<__EOF__
시 코드: ${gen_code}

__EOF__

	gen_code=""
	for current_date in {0..59}
	do
		a=$(($current_date / 2)) #-- 2분 간격으로 하기 위해서.
		date_code=${code_table:$a:1}
		gen_code="${gen_code} ${current_date}분(${date_code})"
	done
	cat <<__EOF__
2분 간격 분 코드: ${gen_code}

변환 테이블: ${code_table}

__EOF__

fi

while true :
do
	this_yy=$(date +%y)
	a=${this_yy:1}
	yy_to_abc=$(( a + 12 ))
	this_mm=$(date +%m)
	wol_to_xyz=$(( this_mm + 15 ))
	this_dd=$(date +%d)
	this_HH=$(date +%H)
	this_MM=$(date +%M)
	min_HALF=$((this_MM / 2)) #-- 2분 간격으로 하기 위해서.

	yyx=${code_table:$(( $yy_to_abc )):1}
	wolx=${code_table:$(( $wol_to_xyz )):1}
	ddx=${code_table:$(( $this_dd )):1}
	hhx=${code_table:$(( $this_HH )):1}
	minx=${code_table:$(( $min_HALF )):1}

	cat <<__EOF__
#--${this_yy}-${this_mm}-${this_dd}-${this_HH}-${this_MM}--

${wolx}${hhx}${ddx}${minx}    ${proj_name}${wolx}${hhx}${ddx}${minx}    time_code    ${wolx}${hhx}${ddx}${yyx}${minx}    ${proj_name}${wolx}${hhx}${ddx}${yyx}${minx}

#----> press wHdym Enter or <CTRL> + <C> to quit:
__EOF__
	read a
done
