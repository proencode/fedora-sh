#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {


MEMO="backup wikijsdb to sql.7z"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


dir_for_backup="$1"
if [ "x${dir_for_backup}" = "x" ]; then
	rm -f ${zz00log_name}
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(백업파일을 저장할 폴더)${cBlue}를 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} ${cCyan}[ ${cYellow}백업파일을 저장할 폴더이름${cCyan} ] 을 입력하세요.${cReset}"
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 1
fi
if [ ! -d "${dir_for_backup}" ]; then
	rm -f ${zz00log_name}
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 백업파일을 저장할 ${cCyan}(${dir_for_backup})${cBlue} 폴더가 없습니다.${cReset}"
	echo "----> ${cYellow}${0} ${cCyan}[ ${cYellow}백업파일을 저장할 폴더이름${cCyan} ] 을 입력하세요.${cReset}"
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 1
fi

cat_and_read "ls -lh ${dir_for_backup}" "(1) 백업파일을 저장할 폴더가 맞으면 [ 엔터 ] 를 눌러서 넘어가세요."

cat_and_run "sudo docker ps -a ; sudo docker stop wikijs" "(2) 위키 도커 중단"

sql_7z="wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"

cat <<__EOF__

${cGreen}----> ${cYellow}sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${sql_7z} -p ${cCyan}#-- (3) 데이터 백업하기${cReset}

${cRed}----> ${cYellow}비밀번호${cRed}를 입력하세요.${cReset}

__EOF__
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${sql_7z} -p

cat_and_run "sudo docker start wikijs ; sudo docker ps -a" "(4) 위키 도커 다시 시작"


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
