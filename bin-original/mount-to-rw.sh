#!/bin/sh

source ${HOME}/lib/color_base
zz00log_name="${CMD_DIR}/zz.$(date +"%y%m%d%a%H:%M:%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name} #-- 작업진행 시작
MEMO="r/w 할수 있도록 마운트 하기"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"

cat_and_run "ls -l /media | grep sf_" "출처: https://forums.virtualbox.org/viewtopic.php?t=79965"
echo ""
cat_and_run "sudo grep vbox /etc/group | grep ${USER}"
cat <<__EOF__

----> vbox 그룹에 ${USER} 사용자가 추가돼 있지 않으면,
----> 사용자에게 vbox 그룹을 추가하기 위해, 'y' 를 입력하세요.
__EOF__
read a
if [ "x$a" = "xy" ]; then
	cat_and_run "sudo gpasswd -a ${USER} vboxsf"
	echo ""
	cat_and_run "sudo grep vbox /etc/group | grep ${USER}"
fi

echo ""
cat_and_run "id" "id 명령으로 uid 와 gid 값을 확인합니다."
echo ""
cat_and_run "ls -l /media | grep sf_"

cat <<__EOF__

gid 와 mid 가 모두 1000 이 아니면,
uid 와 gid 를 1000 대신 직접 넣어야 합니다.
__EOF__
cat_and_readY "sudo mount -t vboxsf -o remount,uid=1000,gid=1000,rw wind /media/sf_Downloads" "remount 를 하려면, 'y' 를 입력하세요."

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
rm -f ${zz00log_name} ; zz00log_name="${CMD_DIR}/zz.$(date +"%y%m%d%a%H:%M:%S")..${CMD_NAME}" ; touch ${zz00log_name} #-- 작업 마무리
ls --color ${CMD_DIR}/zz.*
