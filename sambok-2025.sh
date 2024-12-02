#!/bin/sh

y=2025
wol=101
for jolgi in "소한5 대한20" "입춘3 우수18" "경칩5 춘분20" "청명4 곡우20" "입하5 소만21" "망종5 하지21" "소서7 대서22 초복20 중복30" "말복9 입추7 처서23" "백로7 추분23" "한로8 상강23" "입동7 소설22" "대설7 동지22" "소한5 대한20"
do
	if [ $wol -eq "101" ]; then
	        echo "${y}-${wol:1} 오늘 -->>>-- ${y}-${wol:1} 일지"
		echo "${jolgi}"
		echo "home -->>>-- ilji/${y}/${y:2}${wol:1}"
	else
	        echo "${y}-${wol:1} 오늘"
		echo "${jolgi}"
		echo "home"
	fi
        echo " "
        wol=$(($wol+1))
        if [ $wol -gt "112" ]; then
                wol=101
                y=$(($y+1))
        fi
done
