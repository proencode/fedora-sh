#!/bin/sh

ymd=$(date +%y%m%d-%H%M%S)
if [ ! -d ${ymd} ]; then
	mkdir ${ymd}
fi
temp_file=qqq_temp-${ymd}
size_file=total_size-${ymd}

echo "for cn in edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi yswone ;do echo \"----> \${cn}: \$(rclone size \${cn}: | grep size)\" ; done" > ${ymd}/${size_file}

cnt=100
#-- old_cloud_name: for cn in jjedone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi

for CLOUD_NAME in edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi tpn4mi y5dnmi y5ncmi yosjgc ysw10mi yswone
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
			###echo "#----> (1) ONE_LINE ===${ONE_LINE}==="
			#----> (1) ONE_LINE ===     4492 2023-01-06 07:45:48.000000000 문서/YES24eBook/6f6a52790c9c428abcaaf053fb576fb9/OEBPS/Styles/style.css===


			REM_a_LINE="rem ${ONE_LINE}" #-- ONE_LINE 처음의 공백을 없애지 않기 위해서,
			###echo "#----> (2) REM_a_LINE ===${REM_a_LINE}==="
			#----> (2) REM_a_LINE ===rem     4492 2023-01-06 07:45:48.000000000 문서/YES24eBook/6f6a52790c9c428abcaaf053fb576fb9/OEBPS/Styles/style.css===

			# rem     8597 2023-08-30 10:08:19.000000000 zalba/keepass-yswone.kdbx
			# rem     1314 2023-08-03 14:07:58.000000000 바탕 화면/WinSCP.lnk
			# rem       20 2023-01-05 16:26:38.000000000 문서/YES24eBook/6f6a52790c9c428abcaaf053fb576fb9/mimetype
			# rem 25721740 2023-04-21 13:10:12.000000000 문서/YES24eBook/2b9292f57c52462a8103735ba629a845/2b9292f57c52462a8103735ba629a845.PDF
			#arg1 arg2---- arg3_date- arg4_time--------- arg5---- ---- ---- ----

			arg4_time=$(echo "${REM_a_LINE}" | awk -F" " '{print $4}')
			###echo "#----> (3) arg4_time ===${arg4_time}==="
			#----> (3) arg4_time ===07:45:48.000000000===

			rem_size_date=$(echo "${REM_a_LINE}" | awk -F"${arg4_time}" '{print $1}')
			###echo "#----> (4) rem_size_date ===${rem_size_date}==="
			#----> (4) rem_size_date ===rem     4492 2023-01-06 ===

			namoji=$(echo "${REM_a_LINE}" | awk -F"${arg4_time}" '{print $2}')
			###echo "#----> (5) namoji ===${namoji}==="
			#----> (5) namoji === 문서/YES24eBook/6f6a52790c9c428abcaaf053fb576fb9/OEBPS/Styles/style.css===

			###echo "#----> (6) ===${rem_size_date}${arg4_time} ${CLOUD_NAME}:${namoji:1}==="
			#----> (6) ===rem     4492 2023-01-06 07:45:48.000000000 yswone:문서/YES24eBook/6f6a52790c9c428abcaaf053fb576fb9/OEBPS/Styles/style.css===

			echo "${rem_size_date:3}${arg4_time} ${CLOUD_NAME}:${namoji:1}" >> ${ymd}/${cnt:(-2)}-${CLOUD_NAME}-${dattim}.lsl
			#-- :3 으로 'rem' 을 떼어내고, namoji 의 앞에 붙은 ' ' 공백도 :1 로 뗸다.
		fi
	done < ${temp_file}
	echo "#----> (${cnt:(-2)}) ${CLOUD_NAME}: $(rclone size ${CLOUD_NAME}: | grep size)" >> ${ymd}/${size_file}
	tail -1 ${ymd}/${size_file}
done
rm -f ${temp_file}
echo "#----> (9) 7za a -mx=9 list-rclone-${ymd}.7z ${ymd} ; ls -l . ${ymd}"
#----> (9) 7za a -mx=9 lsl-rclone-230831-142555.7z 230831-142555 ; ls -l . 230831-142555
7za a -mx=9 lsl-rclone-${ymd}.7z ${ymd} ; ls -l . ${ymd}
