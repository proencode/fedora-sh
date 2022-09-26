#!/bin/sh

source ${HOME}/lib/color_base #-- (0) 화면에 색상표시
MEMO="설정 없이 Cue CLI 실행"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"

cat_and_run "mkdir noConfig ; cd noConfig" "(1) Vue CLI with no configuration"
mkdir noConfig ; cd noConfig
cat_and_run "code ." "(2) start VS Code"

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
