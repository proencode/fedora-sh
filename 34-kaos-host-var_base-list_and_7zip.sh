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
base_dir="/opt/kaos_backup/${kaos_var_base}"
if [ ! -d ${base_dir} ]; then
	cmdRun "sudo mkdir -p ${base_dir} ; sudo chown -R yosj:yosj ${base_dir}" "(1) 디렉토리를 새로 만듭니다."
fi
opt_home_dir="/opt/kaos_backup/zip_dir"
zip_7z_kaos="zip_7z_kaos"
remote_dir="${opt_home_dir}/${zip_7z_kaos}"
if [ ! -d ${remote_dir} ]; then
	cmdRun "sudo mkdir -p ${remote_dir} ; sudo chown -R yosj:yosj ${remote_dir}" "(2) 디렉토리를 새로 만듭니다."
fi

begin_time=$(date +%y%m%d%a-%H%M%S)
for basename in cadbase emailbase georaebase #-- scanbase
do
	basename_dir="${base_dir}/${basename}"
	local_dir="${basename_dir}/${y4}"
	if [ -d ${local_dir} ]; then
		cmdRun "cd ${local_dir}; ls -lR | 7za a -mx=9 -si ${remote_dir}/${begin_time}-${basename}-${y4}.ls-lR.7z" "(3) ${basename} ${y4} 용량을 확인합니다."
		cmdRun "cd ${local_dir}; 7za a -mx=9 ${remote_dir}/${begin_time}-${basename}-${y4}.7z *" "(4) ${basename} ${y4} 데이터를 압축합니다."
	fi
done
for basename in scanbase
do
	basename_dir="${base_dir}/${basename}"
	for m2 in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		local_dir="${basename_dir}/${y4}/${m2}"
		if [ -d ${local_dir} ]; then
			cmdRun "cd ${local_dir}; ls -lR | 7za a -mx=9 -si ${remote_dir}/${begin_time}-${basename}-${y4}-${m2}.ls-lR.7z" "(3) ${basename} ${y4}-${m2} 용량을 확인합니다."
			cmdRun "cd ${local_dir}; 7za a -mx=9 ${remote_dir}/${begin_time}-${basename}-${y4}-${m2}.7z *" "(4) ${basename} ${y4}-${m2} 데이터를 압축합니다."
		fi
	done
done

cmdRun "cd ${base_dir}; sh ${HOME}/bin/du-sh-sort-hr.sh" "(5) 디렉토리별 사이즈 확인"
# rclone copy /opt/kaos_backup/zip_dir kaosb4mi:
cmdRun "rclone copy ${opt_home_dir}/ kaosb4mi:" "(6) 클라우드로 복사합니다."
#-- ${opt_home_dir}/ <---- 뒤에 '/' 가 있던 없던 저 디렉토리 안에 있는 내용이 복사된다.


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
