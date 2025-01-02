#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="rclone 원격 호스트의 사이즈 확인"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


storage_listing () {
	about_v=$1
	size_v=$2
	measure_v=$3

	# echo "${about_v} --- ${size_v} --- ${measure_v}"

	if [ "x${about_v}" = "xTotal:" ]; then
		about_Total=${about_v} ; size_Total=${size_v} ; measure_Total=${measure_v}
	fi
	if [ "x${about_v}" = "xUsed:" ]; then
		about_Used=${about_v} ; size_Used=${size_v} ; measure_Used=${measure_v}
	fi
	if [ "x${about_v}" = "xFree:" ]; then
		about_Free=${about_v} ; size_Free=${size_v} ; measure_Free=${measure_v}
	fi
	if [ "x${about_v}" = "xTrashed:" ]; then
			about_Trashed=${about_v} ; size_Trashed=${size_v} ; measure_Trashed=${measure_v}
	fi
	if [ "x${about_v}" = "xOther:" ]; then
		about_Other=${about_v} ; size_Other=${size_v} ; measure_Other=${measure_v}
	fi
}
	
a_site_check () {
	# about_v  size_v  measure_v
	# Total:   15 GiB
	# Used:    2.889 GiB
	# Free:    12.107 GiB
	# Trashed: 177.505 MiB
	# Other:   4.825 MiB
	about_Total="NO_DATA"
	about_Used="NO_DATA"
	about_Free="NO_DATA"
	about_Trashed="NO_DATA"
	about_Other="NO_DATA"
	
	# remote_host="kaosb4mi"
	# cat <<__EOF__
	# ${cBlue}
	# kaosbmi  kaosb2mi  kaosb3mi  kaosb4mi
	# yosjgc  kaosngc  swlibgc  ysj5ncmi
	# ${cCyan}
	# ----> rclone 원격 호스트 이름을 콜론 (:) 을 제외하고 입력하세요. ${cMagenta}[ ${cGreen}${remote_host} ${cMagenta}]${cReset}
	# __EOF__
	# read a ; echo "${cUp}"
	# if [ "x$a" = "x" ]; then
	# 	a=${remote_host}
	# fi
	# remote_host=$a
	
	remote_host=$1
	
# cat <<__EOF__
# ${cRed}[ ${cYellow}${remote_host} ${cRed}]${cReset}
# 
# ${cGreen}----> ${cYellow}rclone about ${remote_host}:${cReset}
# __EOF__
	
	rclone_list=$(rclone about ${remote_host}:)
	
	line_seq=0
	for rc_list in ${rclone_list}
	do
		if [ $line_seq == 0 ]; then
			about_v=$rc_list
			((line_seq+=1))
		else
			if [ $line_seq == 1 ]; then
				size_v=$rc_list
				((line_seq+=1))
			else
				if [ $line_seq == 2 ]; then
					measure_v=$rc_list
					storage_listing ${about_v} ${size_v} ${measure_v}
					about_v=""
					size_v=""
					measure_v=""
					line_seq=0
				fi
			fi
		fi
	done
	
#	if [ "x$about_Total" != "xNO_DATA" ]; then
#		echo "--> total --- ${about_Total} --- ${size_Total} --- ${measure_Total} ---"
#	fi
#	if [ "x$about_Used" != "xNO_DATA" ]; then
#		echo "--> used --- ${about_Used} --- ${size_Used} --- ${measure_Used} ---"
#	fi
#	if [ "x$about_Free" != "xNO_DATA" ]; then
#		echo "--> free --- ${about_Free} --- ${size_Free} --- ${measure_Free} ---"
#	fi
#	if [ "x$about_Trashed" != "xNO_DATA" ]; then
#		echo "--> trashed --- ${about_Trashed} --- ${size_Trashed} --- ${measure_Trashed} ---"
#	fi
#	if [ "x$about_Other" != "xNO_DATA" ]; then
#		echo "--> other --- ${about_Other} --- ${size_Other} --- ${measure_Other} ---"
#	fi
	out_v=""
	if [ "x$about_Total" != "xNO_DATA" ]; then
		out_v="${out_v}${about_Total} ${size_Total} ${measure_Total} | "
	else
		out_v="${out_v}- | "
	fi
	if [ "x$about_Used" != "xNO_DATA" ]; then
		out_v="${out_v}${about_Used} ${size_Used} ${measure_Used} | "
	else
		out_v="${out_v}- | "
	fi
	if [ "x$about_Free" != "xNO_DATA" ]; then
		out_v="${out_v}${about_Free} ${size_Free} ${measure_Free} | "
	else
		out_v="${out_v}- | "
	fi
	if [ "x$about_Trashed" != "xNO_DATA" ]; then
		out_v="${out_v}${about_Trashed} ${size_Trashed} ${measure_Trashed} | "
	else
		out_v="${out_v}- | "
	fi
	if [ "x$about_Other" != "xNO_DATA" ]; then
		out_v="${out_v}${about_Other} ${size_Other} ${measure_Other} | "
	else
		out_v="${out_v}- | "
	fi
	echo "| ${remote_host}: | ${out_v}"
}

echo ""
echo "# rclone: $(uname -n) $(date +'%Y-%m-%d %a %H:%M:%S')"
echo "| remote_host: | total | used | free | trashed | other |"
echo "|:---:|:---:|:---:|:---:|:---:|:---:|"

for cloud_name in kaos1mi  kaos2mi  kaos3mi  kaos4mi  kaosngc  swlibgc  tpnote1mi  tpnote2mi  tpnote3mi  y5dnmi  y5ncmi  yosjgc  ysw10mi
do
	a_site_check ${cloud_name}
done
echo ""


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
