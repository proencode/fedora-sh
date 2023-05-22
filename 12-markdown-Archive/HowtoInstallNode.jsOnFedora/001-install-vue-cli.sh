#!/bin/sh

source ${HOME}/lib/color_base #-- (0) 화면에 색상표시
zz00log_name="${CMD_DIR}/zz.$(date +"%y%m%d%a%H:%M:%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name} #-- 작업진행 시작
MEMO="Vue CLI 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"


cat_and_run "#-- npm install -g @vue/cli --loglevel verbose" "(0) vue cli 설치 (느린 장비에서 진행 확인하려는 경우)"
cat_and_run "npm install -g @vue/cli" "(1) vue cli 설치"
npm install -g @vue/cli ; echo "#-- (1) vue cli 설치"
cat_and_run "vue --version" "(2) 버전 확인"
vue --version ; echo "#-- (2) 버전 확인"
cat <<__EOF__

${cGreen}----> ${cMagenta}위 작업에서 오류가 나는 경우는, 최신의 .bashrc 를 읽어들이지 않은 경우이므로,

${cYellow}source ~/.bashrc ${cMagenta}#-- 명령을 실행해야 합니다.${cReset}

__EOF__


rm -f ${zz00log_name} ; zz00log_name="${CMD_DIR}/zz.$(date +"%y%m%d%a%H:%M:%S")..${CMD_NAME}" ; touch ${zz00log_name} #-- 작업 마무리
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
