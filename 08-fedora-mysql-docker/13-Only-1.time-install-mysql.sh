#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="(13) MySQL 도커와 연결하기 전에, 먼저 로컬에 mysql 을 설치합니다."
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdRun "rpm -qa | grep mysql | sort"
cmdRun "rpm -qa | grep mariadb | sort"

# cmdRun "sudo dnf -y install community-mysql-common community-mysql mariadb-config"
cmdRun "sudo dnf -y install community-mysql-common community-mysql mariadb-common"

cmdRun "rpm -qa | grep mysql | sort"
cmdRun "rpm -qa | grep mariadb | sort"

cmdRun "sudo systemctl enable docker"
cmdRun "sudo systemctl start docker"


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
