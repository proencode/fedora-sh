#!/bin/sh

ymd=$(date +%y%m%d-%H%M%S)
if [ ! -d ${ymd} ]; then
	mkdir ${ymd}
fi
temp_file=qqq_temp-${ymd}
size_file=total_size-${ymd}

echo "for cn in edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi yswone ;do echo \"----> \${cn}: \$(rclone size \${cn}: | grep size)\" ; done" > ${ymd}/${size_file}

cnt=100

for CLOUD_NAME in edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi yswone
do
	dattim=$(date +%y%m%d%a%H%M%S)
	cnt=$((cnt + 1))
	echo "----> rclone ls ${CLOUD_NAME}: > ${ymd}/${cnt:(-2)}-${CLOUD_NAME}-${dattim}.list"
	rclone ls ${CLOUD_NAME}: > ${temp_file}
	#-- $2 .. $9 혹시 "[0-9] " 가 여러번 나올까봐..
	awk -v rc_name="$CLOUD_NAME" -F"[0-9] " '{print $1 " " rc_name ":" $2 $3 $4 $5 $6 $7 $8 $9}' ${temp_file} > ${ymd}/${cnt:(-2)}-${CLOUD_NAME}-${dattim}.list
	echo "----> (${cnt:(-2)}) ${CLOUD_NAME}: $(rclone size ${CLOUD_NAME}: | grep size)" >> ${ymd}/${size_file}
done
rm -f ${temp_file}
echo "----> 7za a -mx=9 list-rclone-${ymd}.7z ${ymd} ; ls -l . ${ymd}"
7za a -mx=9 list-rclone-${ymd}.7z ${ymd} ; ls -l . ${ymd}
