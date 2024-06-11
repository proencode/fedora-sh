#!/bin/sh

rc_lsl=~/rclone-lsl
if [ ! -d ${rc_lsl} ]; then
	echo "----> mkdir ${rc_lsl}"
	mkdir ${rc_lsl}
fi
echo "----> cd ${rc_lsl}"
cd ${rc_lsl}

ymd=$(date +%y%m%d-%H%M%S)
if [ ! -d ${ymd} ]; then
	mkdir ${ymd}
fi
temp_file=qqq_temp-${ymd}
size_file=total_size-${ymd}

echo "cc=100 ; for cn in dosomi edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi tpn4mi y5dnmi y5ncmi yosjgc ysw10mi yswone ;do cc=\$((cc + 1)) ; echo \"----> (\${cc:(-2)}) \${cn}: \$(rclone size \${cn}: | grep size)\" ; done" > ${ymd}/${size_file}

cnt=100

for CLOUD_NAME in dosomi edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi tpn4mi y5dnmi y5ncmi yosjgc ysw10mi yswone
do
	dattim=$(date +%y%m%d%a%H%M%S)
	cnt=$((cnt + 1))
	echo "#-----------------> (${cnt:(-2)}) ${CLOUD_NAME}:"
	rclone lsl ${CLOUD_NAME}: | sort -k4 > ${temp_file}
	# 유닉스 쉘에서 스페이스 잘리지 않게 유지하고 읽는 방법 멜번초이 2016. 10. 29. 10:22 https://pangate.com/904
	while IFS= read -r ONE_LINE
	do
		if [ -z "${ONE_LINE}" ]; then
			qqq="null line skip"
		else
			REM_a_LINE="rem ${ONE_LINE}" #-- ONE_LINE 처음의 공백을 없애지 않기 위해서,
			arg4_time=$(echo "${REM_a_LINE}" | awk -F" " '{print $4}')
			rem_size_date=$(echo "${REM_a_LINE}" | awk -F"${arg4_time}" '{print $1}')
			namoji=$(echo "${REM_a_LINE}" | awk -F"${arg4_time}" '{print $2}')
			echo "${rem_size_date:3}${arg4_time} ${CLOUD_NAME}:${namoji:1}" >> ${ymd}/${cnt:(-2)}-${CLOUD_NAME}-${dattim}.lsl
		fi
	done < ${temp_file}
	echo "#----> (${cnt:(-2)}) ${CLOUD_NAME}: $(rclone size ${CLOUD_NAME}: | grep size)" >> ${ymd}/${size_file}
	tail -1 ${ymd}/${size_file}
done
rm -f ${temp_file}
#----> (9) 7za a -mx=9 lsl-rclone-230831-142555.7z 230831-142555 ; ls -l . 230831-142555
7za a -mx=9 lsl-rclone-${ymd}.7z ${ymd} ; ls -l . ${ymd}
