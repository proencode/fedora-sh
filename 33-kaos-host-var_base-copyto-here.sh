#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="HOST order file copyto here"
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
	local_dir="${home_dir}/${basename}/${y4}"
	if [ ! -d ${local_dir} ]; then
		cmdRun "mkdir -p ${local_dir}" "년월지정 디렉토리를 만듭니다."
	fi
	cmdRun "rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' kaosco@kaos.kr:/var/base/${basename}/${y4}/ ${local_dir}/" "원격 파일을 로컬 백업으로 복사합니다."
done


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
