#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="flutter 설치를 위한 작업들 진행"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdRun "rpm -qa | grep java | sort | grep java" "(1) 설치돼 있는java 확인"
cmdYenter "sudo dnf install -y java-17-openjdk-devel" "(2) java 17 설치"
cmdRun "sudo dnf -y install snapd" "(3) snapd 설치"
cmdRun "sudo ln -s /var/lib/snapd/snap /snap" "(4) /snap 으로 소프트링크 지정"
cmdCont "sudo snap install hello-world" "(5) 잠시 기다린 후, snap 확인을 위해 hello-world 를 시험설치"
cat <<__EOF__
${cCyan}
(6) ${cMagenta}터미널을 따로 열어서${cCyan}, 아래의 둘중 하나를 실행해서 android-studio 룰 설치해야 합니다.

	1) snap 으로 android-studio 를 설치하고 실행하는 경우: 속도가 느리지만 업그레이드가 편함.
${cYellow}
	time sudo snap install android-studio --classic ; android-studio
${cCyan}
또는,
	2) https://developer.android.com/studio 에서 다운로드 받고 실행하는 경우: 홈에서 다운로드 받은 파일을 지정함.
${cYellow}
	tar xf ${cMagenta}~/wind_bada/Downloads/android-studio-2022.1.1.19-linux.tar.gz ; android-studio
${cCyan}
----> android-studio 초기작업이 ${cMagenta}끝난 뒤에, ${cYellow}새로운 터미널에서 ${cCyan}다음의 세 작업을 실행해 주세요.
${cBlue}
	echo "";echo "#-- (7) flutter 설치";echo "#-- sudo snap install flutter --classic";echo ""
${cYellow}sudo snap install flutter --classic ${cBlue};echo "";echo "#-- (7) flutter 설치";echo ""
	echo "";echo "#-- (8) flutter 의 sdk path 확인하거나 다운로드 하기";echo "#-- flutter sdk-path";echo ""
${cYellow}flutter sdk-path ${cBlue};echo "";echo "#-- (8) flutter 의 sdk path 확인하거나 다운로드 하기";echo ""
	echo "";echo "#-- (9) flutter 정상작동 확인";echo "#-- flutter doctor";echo ""
${cYellow}flutter doctor ${cBlue};echo "";echo "#-- (9) flutter 정상작동 확인";echo ""
${cReset}
__EOF__


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
