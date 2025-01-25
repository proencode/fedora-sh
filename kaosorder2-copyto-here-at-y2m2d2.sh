#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="kaosorder2 데이터 백업"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


top_backup_dir="./kaos-backup"

cmdRun "ls --color" "현재의 디렉토리 입니다."
cat <<__EOF__
----> 현재의 디렉토리 아래에 백업할 ${top_backup_dir} 디렉토리를 만들고, 이 곳으로 복사합니다.
---->
----> press Enter:
__EOF__
read a

echo "----> 백업할 년도 2 자리, 월 2 자리 를 입력하세요."
read a
if [ "x$a" = "x" ]; then
	exit 1
fi
yymm0000="${a}0000"
y4="20${yymm0000:0:2}"
y2="${yymm0000:0:2}"
m2="${yymm0000:2:2}"
cat <<__EOF__
y4 = ${y4}
y2 = ${y2}
m2 = ${m2}
----> 맞으면 'y' 를 누르세요.
__EOF__
read a
if [ "x$a" != "xy" ]; then
	exit 1
fi

cmdRun "ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 kaosco@kaos.kr ls -l /var/base_db/kaosorder2/${y4}/${m2}/" "로그인 비밀번호를 입력하세요"

echo "----> 백업할 일 2자리 를 입력하세요."
read a
if [ "x$a" = "x" ]; then
	exit 1
fi
d2="${a:0:2}"
cat <<__EOF__
d2 = ${d2}
----> 맞으면 'y' 를 누르세요.
__EOF__
read a
if [ "x$a" != "xy" ]; then
	exit 1
fi
y2m2d2="${y2}${m2}${d2}"

this_backup_dir="${top_backup_dir}/kaosorder2/${y4}-${m2}"
if [ ! -d ${this_backup_dir} ]; then
	cmdRun "mkdir -p ${this_backup_dir}" "디렉토리를 새로 만듭니다."
fi

echo "${cCyan}----> ${y2m2d2} 파일을 ${this_backup_dir} 디렉토리로 가져옵니다.${cReset}"
rsync -avzr --delete --rsh="/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/*${y2m2d2}* ${this_backup_dir}
echo "${cGreen}<---- ${y2m2d2} 파일을 ${this_backup_dir} 디렉토리로 가져옵니다.${cReset}"
#-- cmdRun "rsync -avzr --delete --rsh=\"/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco\" --no-o --no-g --delete kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/*${y2m2d2}* ${this_backup_dir}" "${y2m2d2} 파일을 ${this_backup_dir} 디렉토리로 가져옵니다."
#-- cmdRun "rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' --exclude=target/classes kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/*${y2m2d2}* ${this_backup_dir}" "로그인 비밀번호를 입력하세요"
#
cmdRun "ls -l ${this_backup_dir}" "백업 디렉토리입니다."


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
