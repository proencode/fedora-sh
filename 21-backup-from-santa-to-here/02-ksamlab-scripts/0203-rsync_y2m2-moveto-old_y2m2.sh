#!/bin/sh

ynow=$(date +'%y')
y2=$ynow

yy01="$((ynow - 1))01"
yy12="$((ynow + 1))12"

mnow=$(date +'%m')
m2="$((mnow + 99))" #-- 1...12월 => 100...111 --> 100 은 지난해의 지난달 112 로
if [ "$m2" = "100" ]; then
	m2="112"
	y2=$((y2 - 1))
fi
mm=${m2:(-2)} #-- 뒤에서 2자리 ; 지난달
ym=${y2}${mm}
if [ ! -f rsync_${ym}* ]; then
	#-- 지난달이 없으면,
	m2="$((mnow + 100))" #-- 1...12월 => 101...112
	mm=${m2:(-2)} #-- 뒤에서 2자리 = 이번달
	ym=${ynow}${mm}
fi

cat <<__EOF__

$(if [ -f rsync_${ym}* ]; then ls rsync_${ym}* ; fi)

----> Enter yymm: [ ${ym} ]
__EOF__
read y2m2
if [ "x${y2m2}" = "x" ]; then
	y2m2=${ym}
fi
echo "[ ${y2m2} ]"

if [ ${y2m2} -gt $yy01 ] && [ ${y2m2} -lt $yy12 ]; then
	# if [ -f ksamlab_rsync_${y2m2}.7z ]; then
	# 	echo "----> rm -f ksamlab_rsync_${y2m2}.7z"
	# 	rm -f ksamlab_rsync_${y2m2}.7z
	# fi
	#-- 두번이상 하면 7z 파일에 중복돼 만들어진다.
	echo "----> ls -l rsync_${y2m2}* | 7za a -mx=9 -si ksamlab_rsync_${y2m2}-$(date +'%y%m%d_%H%M%S').7z ; ls -l k* #-- 삭제할때, rm -f rsync_${y2m2}*"
	ls -l rsync_${y2m2}* | 7za a -mx=9 -si ksamlab_rsync_${y2m2}-$(date +'%y%m%d_%H%M%S').7z ; ls -l ksamlab_rsync_*
	if [ ! -d old_${y2m2} ]; then
		mkdir old_${y2m2}
	fi
	mv rsync_${y2m2}* old_${y2m2}
else
	echo "!!!! ----> (${y2m2}) 입력값이 년월의 범위 ${yy01} ... ${yy12} 를 넘어섭니다."
fi
