#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="kaos 백업자료 압축하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

y4=$(date +%Y) #-- 2022
if [ "x$1" != "x" ]; then
	y4=$1
fi

cat <<__EOF__
년도 4자리를 입력하세요.
----> [${y4}]
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x" ]; then
	a=$y4
fi
y4=$a

kaos_var_base="kaos_var_base"
home_dir="/opt/kaos_backup/${kaos_var_base}"
if [ ! -d ${home_dir} ]; then
	cmdRun "sudo mkdir -p ${home_dir} ; sudo chown -R yosj:yosj ${home_dir}" "(1) 디렉토리를 새로 만듭니다."
fi

for basename in cadbase emailbase georaebase scanbase
do
	base_dir="${home_dir}/${basename}"
	for m2 in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		local_dir="${base_dir}/${y4}/${m2}"
		if [ -d ${local_dir} ]; then
			cmdRun "cd ${local_dir}; ls -lR > ../${basename}-${y4}-${m2}-$(date +%y%m%d%a-%H%M%S).ls-lR"
			cmdRun "cd ${local_dir}; 7za a -mx=9 ../${basename}-${y4}-${m2}-$(date +%y%m%d%a-%H%M%S).7z *" "${y4}-${m2} 데이터를 압축합니다."
		fi
	done
done

cmdRun "cd ${home_dir}; sh ${HOME}/bin/du-sh-sort-hr.sh" "디렉토리별 사이즈 확인"
cmdRun "rclone copy ${home_dir} kaosb4mi:${kaos_var_base}" "클라우드로 복사합니다."


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
