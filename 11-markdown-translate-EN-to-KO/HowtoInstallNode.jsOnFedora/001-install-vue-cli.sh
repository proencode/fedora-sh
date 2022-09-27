#!/bin/sh

source ${HOME}/lib/color_base #-- (0) 화면에 색상표시
MEMO="Vue CLI 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"

cat_and_run "#-- npm install -g @vue/cli --loglevel verbose" "(0) vue cli 설치 (느린 장비에서 진행 확인하려는 경우)"
# source ~/.bashrc
cat_and_run "npm install -g @vue/cli" "(1) vue cli 설치"
npm install -g @vue/cli ; echo "#-- (1) vue cli 설치"
cat_and_run "vue --version" "(2) 버전 확인"
vue --version ; echo "#-- (2) 버전 확인"

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
