#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="db-to-cloud.sh 비교 및 복사"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


home_dir=${HOME}/git-projects
main_dir=${home_dir}/fedora-sh/10-wikijs-docker-by-markdown

for dir in gate242/run_sh kaosorder/run_scripts_dir ubuntu-sh/10-wikijs-docker

do
	echo "${cGreen}----> ${cYellow}${dir} ${cCyan}디렉토리를 확인합니다.${cReset}"
	for file in color_base db-to-cloud.sh header
	do
		cmdRun "diff ${main_dir}/${file} ${home_dir}/${dir}/${file}"
		echo "${cGreen}----> ${cCyan}차이가 있으면 ${cMagenta}^C ${cCyan}로 중단하고, 확인하세요.${cReset}"
		read a
	done
done


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
