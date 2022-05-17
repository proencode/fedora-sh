#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0)    # black     COLOR_BLACK     0,0,0
cRed=$(tput bold)$(tput setaf 1)      # red       COLOR_RED       1,0,0
cGreen=$(tput bold)$(tput setaf 2)    # green     COLOR_GREEN     0,1,0
cYellow=$(tput bold)$(tput setaf 3)   # yellow    COLOR_YELLOW    1,1,0
cBlue=$(tput bold)$(tput setaf 4)     # blue      COLOR_BLUE      0,0,1
cMagenta=$(tput bold)$(tput setaf 5)  # magenta   COLOR_MAGENTA   1,0,1
cCyan=$(tput bold)$(tput setaf 6)     # cyan      COLOR_CYAN      0,1,1
cWhite=$(tput bold)$(tput setaf 7)    # white     COLOR_WHITE     1,1,1
cReset=$(tput bold)$(tput sgr0)       # Reset text format to the terminal's default

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"
	echo "$1" | sh
	echo "${cYellow}<${cRed}---- ${cMagenta}$1 $2${cReset}"
}
cat_and_read () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow} - - - press Enter:${cReset}"
	read a ; echo "$(tput cuu 2)"
	echo "$1" | sh
	echo "${cYellow}<${cRed}---- ${cBlue}- - - press Enter:${cMagenta}$1 $2${cReset}"
}
# - - -

MEMO="kaosco 데이터 백업"

cat <<__EOF__

${cMagenta}$0 ${cYellow} ${MEMO} ${cReset}
출처: yosjeon@gmail.com

연결이 되지 않으면 .ssh.config 파일을 다음과 같이 만든다.
Host kaos.kr
	KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
	# KexAlgorithms +diffie-hellman-group1-sha1
	## PubkeyAcceptedKeyTypes=ssh-rsa
Host www.kaos.kr
	KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
	# KexAlgorithms +diffie-hellman-group1-sha1
	## PubkeyAcceptedKeyTypes=ssh-rsa

${cYellow}그냥 엔터${cReset} ...... 진행후 엔터를 누르라고 나온다. (no)
${cYellow}30s${cReset} ...... 30초동안 기다리고 다음으로 넘어간다. (yes)
${cYellow}1m${cReset} ...... 1분동안 기다리고 다음으로 넘어간다.

sleep 0.1 # ...... 0.1초 쉬기
sleep 1h 30m 30s # ...... 1시간 30분 30초동안 쉬기
sleep 1.5h # ...... 1.5시간 동안 쉬기
출처:http://bahndal.egloos.com/486688 --- [bash: sleep] 1초 미만으로 쉬기

${cYellow}-----> press Enter:${cReset}
__EOF__
read a

SYNCANDSLEEP="no"
if [ "x$a" != "x" ]; then
	SYNCANDSLEEP="yes"
	SLEEPTIME=$a
fi

cat <<__EOF__

rclone 작업후 폴더 전체를 압축 하기전에 'y' 를 눌러야 허면, 'y' 를 누르시고,
그냥 계속하려면, 그냥 Enter 를 누르세요.

${cYellow}-----> press Enter:${cReset}
__EOF__
read zip_y

if [ "x${zip_y}" == "xy" ]; then
	echo "${cYellow}---->${cReset} 압축하기 전에 Enter 를 눌러야 합니다."
else
	echo "${cYellow}---->${cReset} 작업이 끝까지 주욱 진행됩니다."
fi

cat <<__EOF__

${cYellow}-----> press Enter:${cReset}
__EOF__
read a
# - - -

COL_CNT=0

for from_dir in "/var/kaosorder-backup*" "/var/base*" "/var/scandir*" "/var/caddir*" "/var/emaildir*" "1-server*" "Dropbox*" "bin*" "kaos.kr*" "project*" "/p"
do
	# play -q ~/bin/1-bin-scripts/freesound/212541__misstickle__indian-bell-chime.wav & #---- 띠잉~
	# play -q ~/bin/1-bin-scripts/freesound/339816__inspectorj__hand-bells-f-single.wav & #---- 뗑-~
	# play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- 데에엥~~
	# play -q ~/bin/1-bin-scripts/freesound/411459__inspectorj__castanets-multi-a-h1.wav & #---- 캐스터네츠~
	# play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- 교회 뎅-
	# play -q ~/bin/1-bin-scripts/freesound/91926__tim-kahn__ding.wav & #---- 딩~
	COL_CNT=$((COL_CNT + 1))
	if [[ "$COL_CNT" -le 4 || "$COL_CNT" -ge 11 ]]; then
		play -q ~/bin/1-bin-scripts/freesound/91926__tim-kahn__ding.wav & #---- 딩~
	else
	if [[ "$COL_CNT" -eq 5 || "$COL_CNT" -eq 10 ]]; then
		play -q ~/bin/1-bin-scripts/freesound/212541__misstickle__indian-bell-chime.wav & #---- 띠잉~
	else
	if [[ "$COL_CNT" -gt 5 && "$COL_CNT" -lt 10 ]]; then
		play -q ~/bin/1-bin-scripts/freesound/339816__inspectorj__hand-bells-f-single.wav & #---- 뗑-~
	fi
	fi
	fi

	# 비밀번호를 입력해야 하므로 독립 쉘로 띄운다.
#--	cat_and_run "$(cat <<__EOF__
#--time rsync -rltgoDvz --no-o --no-g --delete kaosco@www.kaos.kr:${from_dir} .
#--__EOF__
#--)"
	cat <<__EOF__
time rsync -avzr --rsh="/usr/bin/sshpass -f /home/yos/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${from_dir} .
__EOF__
	time rsync -avzr --rsh="sshpass -f /home/yos/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${from_dir} .

	if [ "x${SYNCANDSLEEP}" = "xno" ]; then
		cat_and_run "date ; sync ; date" "${COL_CNT}"
		play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- 교회 뎅-
		echo "-----> press Enter:"
		read a
	else
		cat_and_run "date ; sync ; sleep ${SLEEPTIME} ; date" "${SLEEPTIME} 만큼 대기" "${COL_CNT}"
		play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- 교회 뎅-
	fi
done
ymd=$(date +"%y%m%d")

play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- 데에엥~~

cat <<__EOF__

play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav &
	cat_and_read "ls -laR . > ../${ymd}-kaosco-backup.ls-laR"
	play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav &
	date ; sync ; date
play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav &
	cat_and_read "time 7za a ~/${ymd}-kaosco-backup.7z ../kaosco-backup > ../${ymd}-kaosco-backup.zip.time"
	play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav &
	date ; sync ; date
play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav &
	cat_and_read "time cp ~/${ymd}-kaosco-backup.7z ../ > ../${ymd}-kaosco-backup.cp.time"
	play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav &
	date ; sync ; date
	play -q ~/bin/1-bin-scripts/freesound/411459__inspectorj__castanets-multi-a-h1.wav &

__EOF__

if [ "x${zip_y}" == "xy" ]; then
	cat_and_read "ls -laR . > ../${ymd}-kaosco-backup.ls-laR"
else
	cat_and_run "ls -laR . > ../${ymd}-kaosco-backup.ls-laR"
fi
play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- 교회 뎅-
cat_and_run "date ; sync ; date" "${cBlue}딩~${cReset}"

play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- 데에엥~~
if [ "x${zip_y}" == "xy" ]; then
	cat_and_read "time 7za a ~/${ymd}-kaosco-backup.7z ../kaosco-backup > ../${ymd}-kaosco-backup.zip.time"
else
	cat_and_run "time 7za a ~/${ymd}-kaosco-backup.7z ../kaosco-backup > ../${ymd}-kaosco-backup.zip.time"
fi
play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- 교회 뎅-
cat_and_run "date ; sync ; date" "${cBlue}딩~${cReset}"

play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- 데에엥~~
if [ "x${zip_y}" == "xy" ]; then
	cat_and_read "time cp ~/${ymd}-kaosco-backup.7z ../ > ../${ymd}-kaosco-backup.cp.time"
else
	cat_and_run "time cp ~/${ymd}-kaosco-backup.7z ../ > ../${ymd}-kaosco-backup.cp.time"
fi
play -q ~/bin/1-bin-scripts/freesound/411459__inspectorj__castanets-multi-a-h1.wav & #---- 캐스터네츠~
