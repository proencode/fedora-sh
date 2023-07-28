#!/bin/sh

ymd=$(date +%y%m%d-%H%M%S)
temp_file=qqq_temp-${ymd}

for name in edone jjdrb jjone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi
do
	dattim=$(date +%y%m%d%a%H%M%S)
	echo "----> rclone ls ${name}: > ${ymd}/ls-${name}-${dattim}.list"
	rclone ls ${name}: > ${temp_file}
	if [ ! -d ${ymd} ]; then
		mkdir ${ymd}
	fi
	#-- $2 .. $9 혹시 "[0-9] " 가 여러번 나올까봐..
	awk -v rc_name="$name" -F"[0-9] " '{print $1 " " rc_name ":" $2 $3 $4 $5 $6 $7 $8 $9}' ${temp_file} > ${ymd}/ls-${name}-${dattim}.list
done
rm -f ${temp_file}
