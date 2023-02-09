#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
title_begin () {
	echo "${cCyan}----> ${cRed}$1${cReset}"
}
title_end () {
	echo "${cBlue}<---- ${cMagenta}$1${cReset}"
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="한글 폰트파일 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

title_begin "임시로 쓸 폴더 확인"
temp_folder=$1
if [ "x${temp_folder}" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}저장하기 위해 ${cYellow}/media/sf_Downloads/ 등 ${cBlue}폴더 이름을 지정해야 합니다.${cReset}"
	echo "${cRed}----> ${cYellow}${0} ${cRed}[ ${cReset}임시파일을 저장할 폴더이름 ${cCyan}ex) ${cYellow}~/00-mega-yssc/Downloads ${cRed}]${cReset}"
	rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}__TEMP_FOLDER_PLEASE" ; touch ${log_name}
	cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 0
fi
if [ ! -d "${temp_folder}" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 저장하기 위한 ${cCyan}( ${cYellow}${temp_folder} ${cCyan})${cBlue} 폴더가 없습니다.${cReset}"
	echo "${cRed}----> ${cYellow}${0} ${cRed}[ ${cReset}임시파일을 저장할 폴더이름 ${cCyan}ex) ${cYellow}~/00-mega-yssc/Downloads ${cRed}]${cReset}"
	rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}__TEMP_FOLDER_${temp_folder}_NOT_FOUND" ; touch ${log_name}
	cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 0
fi
FONT_DIR=/usr/share/fonts #-- 폰트 폴더
TEMPfontDIR="${temp_folder}/temp_fonts"
WGET="wget --no-check-certificate --content-disposition"
cat_and_run "rm -rf ${TEMPfontDIR} ; mkdir ${TEMPfontDIR}" "임시로 쓰는 폴더를 새로 만듭니다."
title_end "임시로 쓸 폴더 확인"


title_begin "압축한 파일을 찾아서 폰트 설치"
font_zip_file=$(pwd)/${CMD_DIR}/init_files/Font-D2-KoPub-jeju-nanum-seoul.7z
if [ -f ${font_zip_file} ]; then
	cat_and_run "ls ${FONT_DIR}" "폰트 등록전의 폴더 내용"
	cat_and_run "cd ${FONT_DIR} ; sudo 7za -y x ${font_zip_file}" "폰트 설치"
	cat_and_run "ls ${FONT_DIR}" "폰트 등록후의 폴더 내용"
	title_end "압축한 파일을 찾아서 폰트 설치"
	# ----
	rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
	cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 0
else
	echo "!!!! ${cRed}----> ${cBlue}압축한 파일이 없습니다.${cReset}"
fi
title_end "압축한 파일을 찾아서 폰트 설치"


title_begin "D2Coding 폰트 설치"
FONT_HOST="https://github.com/naver/d2codingfont/releases/download/VER1.3.2"
FONT_NAME="D2Coding-Ver1.3.2-20180524.zip"
LOCAL_DIR="${FONT_DIR}/D2Coding"

cat_and_run "cd ${TEMPfontDIR} ; ${WGET} ${FONT_HOST}/${FONT_NAME}" "폰트 내려받기"
cat_and_run "sudo rm -rf ${LOCAL_DIR}*" "기존 폴더 삭제"
cat_and_run "cd ${TEMPfontDIR} ; 7za x ${FONT_NAME}" "폰트 압축해제"
cat_and_run "cd ${TEMPfontDIR} ; sudo chown -R root:root D2Coding ; sudo mv D2Coding ${FONT_DIR}/ ; sudo chmod 755 -R ${LOCAL_DIR} ; sudo chmod 644 ${LOCAL_DIR}/*" "폰트 설치"
cat_and_run "cd ${LOCAL_DIR} ; sudo mv D2Coding-Ver1.3.2-20180524.ttc D2Coding.ttc ; sudo mv D2Coding-Ver1.3.2-20180524.ttf D2Coding.ttf ; sudo mv D2CodingBold-Ver1.3.2-20180524.ttf D2CodingBold.ttf" "폰트 파일이름을 수정합니다."
title_end "D2Coding 폰트 설치"


title_begin "seoul 폰트 설치"
cat_and_run "sudo rm -rf ${TEMPfontDIR} ; mkdir ${TEMPfontDIR}" "임시폴더 다시만들고,"
FONT_HOST="https://www.seoul.go.kr/upload/seoul/font"
FONT_NAME="seoul_font.zip" #-- 파일을 한글코드로 된 폴더에 담아서 압축했기 때문에, 풀면 fedora35 에서 깨진 글자로 나온다.
LOCAL_DIR="${FONT_DIR}/seoul"

cat_and_run "cd ${TEMPfontDIR} ; ${WGET} ${FONT_HOST}/${FONT_NAME}" "폰트 내려받기"
cat_and_run "sudo rm -rf ${LOCAL_DIR} ; sudo mkdir ${LOCAL_DIR}" "폴더 만들기"
cat_and_run "cd ${TEMPfontDIR} ; ls -l ; 7za x ${FONT_NAME}" "폰트 압축해제"
cat_and_run "cd ${TEMPfontDIR} ; sudo mv */Seoul*.ttf ${LOCAL_DIR}/ ; sudo chmod 644 ${LOCAL_DIR}/*" "폰트 설치"
title_end "seoul 폰트 설치"


title_begin "폰트 설치 확인"
cat_and_run "ls -ltr --color ${FONT_DIR}" "시간역순 font 디렉토리"
cat_and_run "ls --color ${FONT_DIR}/D2Coding*" "d2coding 설치 확인"
cat_and_run "ls --color ${FONT_DIR}/seoul*" "seoul 설치 확인"
cat_and_run "sudo rm -rf ${TEMPfontDIR}" "임시폴더 삭제"
title_end "폰트 설치 확인"


# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
