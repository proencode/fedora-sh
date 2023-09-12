#!/bin/sh

hhh=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2) #-- 230908

backup_file="$1"
echo "${bbb}---->${xxx} rclone ls yosjgc:calls_sms/ | sort -k4"
rclone ls yosjgc:calls_sms/ | sort -k4

if [ "x${backup_file}" = "x" ]; then
	cat <<__EOF__

${rrr}---->${xxx} 파일을 고른 다음, 아래와 같이 이 스크립트에 붙여 실행하세요.

$0 calls-20230910023532.xml
__EOF__
	exit -1
fi

echo "${bbb}---->${xxx} time rclone copy yosjgc:calls_sms/${backup_file} ./"
time rclone copy yosjgc:calls_sms/${backup_file} ./
if [ -f ${backup_file} ]; then
	echo "${bbb}---->${xxx} time 7za a -p ${backup_file}.7z ${backup_file}"
	time 7za a -p8972 ${backup_file}.7z ${backup_file}
	echo "${bbb}---->${xxx} ls -l"
	ls -l
	echo "${bbb}---->${xxx}"
	echo "${bbb}---->${xxx} time rclone copy ${backup_file}.7z tpn3mi:calls_sms/"
	time rclone copy ${backup_file}.7z tpn3mi:calls_sms/
	echo "${bbb}---->${xxx} time rclone lsl tpn3mi:calls_sms/"
	time rclone lsl tpn3mi:calls_sms/
	echo "${bbb}---->${xxx} rm -f ${backup_file}"
	rm -f ${backup_file}
	echo "${bbb}---->${xxx} ls -l"
	ls -l
	cat <<__EOF__

${bbb}---->${xxx} 다음 명령으로 클라우드의 ${ccc}원본 파일${bbb}을 삭제하세요.${xxx}

${ggg}time rclone delete yosjgc:calls_sms/${backup_file}${xxx}
__EOF__
else
	echo "${rrr}---->${xxx} ERROR: 파일이 다운로드되지 않았습니다."
fi
