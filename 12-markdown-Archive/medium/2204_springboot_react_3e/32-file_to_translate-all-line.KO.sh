#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
	else
		echo "${cGreen}----> ${cRed}press ${cCyan}y${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
	fi
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
# echo "${cCyan}----> ${cRed}
# ${cReset}"
# echo "${cBlue}<---- ${cMagenta}
# ${cReset}"
MEMO="Language Translator Using Google API in Python"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
# logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
# log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


cat <<__EOF__
210924 Language Translator Using Google API in Python
https://www.geeksforgeeks.org/language-translator-using-google-api-in-python/

Step-by-step – Python 3 PIP Fedora 35 Installation Guide
October 5, 2021 | By the+gnu+linux+evangelist | Filed in: Tutorial.
https://tutorialforlinux.com/2021/10/05/step-by-step-python-3-pip-fedora-35-installation-guide/
__EOF__

if [ "x$1" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(마침표 위치에서 줄을 바꾸려는 md 파일)${cBlue}을 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} [md 파일 이름]${cReset}"
	exit 1
fi
if [ ! -f "$1" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 마침표 위치에서 줄을 바꾸려는 ${cCyan}($1)${cBlue} md 파일이 없습니다.${cReset}"
	echo "----> ${cYellow}${0} [md 파일 이름]${cReset}"
	exit 1
fi


org_dir_name="$1" #-- 원본 파일 폴더/이름

qq=${org_dir_name:0:1}
# echo "qq ${qq};"
if [ "x${qq}" != "x." ]; then
	if [ "x${qq}" != "x/" ]; then
		org_dir_name="./${org_dir_name}"
	fi
fi

org_name=$(basename "${org_dir_name}") # 백업파일 이름만 꺼냄
org_dir=${org_dir_name%/"$org_name"} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
en2ko_file="ko.${org_name}" #-- 최종 번역 파일

cat <<__EOF__

${cCyan}           \$1= ${cYellow}${1} ${cCyan};
${cCyan} org_dir_name= ${cYellow}${org_dir_name} ${cCyan}; #-- 원본 파일 폴더/이름
${cCyan}     org_name= ${cYellow}${org_name} ${cCyan}; #-- 백업파일 이름만 꺼냄
${cCyan}      org_dir= ${cYellow}${org_dir} ${cCyan}; #-- 백업파일 이름을 빼고 나머지 디렉토리만 담음
${cCyan}   en2ko_file= ${cYellow}${en2ko_file} ${cCyan}; #-- 최종 번역 파일

${cGreen}----> ${cCyan}Press Enter${cReset}:
__EOF__
read a

cat_and_readY "sudo dnf -y install python3-pip" "#----> (1) pip 설치"
cat_and_readY "pip install googletrans==4.0.0-rc1" "#----> (2) 번역 라이브러리 설치 출처: https://blockdmask.tistory.com/540 [개발자 지망생"

temp_dot_divide="temp_dot-$(date +'%y%m%d-%H%M%S')"
cat_and_run "cat \"${org_dir_name}\" | sed -e s'/\.$/\.\n/g' | sed -e s'/\. /\.\n/g' > \"${temp_dot_divide}\"" "마침표 (.) 기준으로 줄을 분리합니다."

# xxx period_file="period...${org_name}...md" #-- 원본의 마침표에서 다음줄로 넘어가도록 수정한 파일
# xxx cat_and_run "cat ${org_dir_name} | sed -e s'/\. /\.\n/g' | sed -e s'/\.$/\.\n/g' > ${period_file}" "마침표 (.) 기준으로 줄을 분리합니다."
# xxx cat_and_run "cat ${org_dir_name} | sed -e s'/\. /\.\n/g' > ${period_file}" "마침표 (.) 기준으로 줄을 분리합니다."

python_name=99-trans-text.py
echo "#----> (3) ${python_name} 소스 파일을 만듭니다."

fromColor="${cRed}from${cGreen}" ; toColor="${cRed}to  ${cYellow}" #-- 화면으로 보기 위한것임.
fromColor="from" ; toColor="to  "
fromColor="" ; toColor=""

cat > ${python_name} <<__EOF__
# def read_txt (filename, sep='') :
# 출처: https://data-make.tistory.com/109 [Data Makes Our Future]

import googletrans
translator = googletrans.Translator()

filename="${temp_dot_divide}"

def read_txt (filename):
	# print (f"filename = {filename}")
	str = ''
	file = open (filename,'r')
	# print (f"str = file.readlines ()")
	str = file.readlines ()

	for aline_en in str :
		if len(aline_en) < 2:
			print (f"${fromColor}{aline_en}${toColor}")
			print (f"")
		else:
			aline_ko=translator.translate (aline_en, dest='ko')
			print (f"${fromColor}{aline_en}${toColor}{aline_ko.text}")
			print (f"")

	file.close()

read_txt (filename)
__EOF__

temp_trans="temp_trans-$(date +'%y%m%d-%H%M%S')"
cat_and_run "python ${python_name} > ${temp_trans}" "#----> (4) 번역"

cat_and_run "cat header-mark-file ${temp_trans} > \"${en2ko_file}\"" "#----> (5) 최종 번역파일 작성"
cat_and_run "rm -rf ${temp_dot_divide} ${temp_trans} ${python_name}" "#----> (6) 임시파일 삭제"


# ----
# rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
# cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
