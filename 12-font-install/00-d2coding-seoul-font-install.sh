#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}


# ---

MEMO="한글 폰트파일 설치"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

org_dir=$(pwd) #-- 현재의 폴더
font_dir=/usr/share/fonts #-- 폰트 폴더

if [ -f ${org_dir}/Font-D2-KoPub-jeju-nanum-seoul.7z ]; then
	cat_and_run "ls ${font_dir}" "폰트 등록전의 폴더"
	cat_and_run "cd ${font_dir} ; sudo 7za x ${org_dir}/Font-D2-KoPub-jeju-nanum-seoul.7z" "폰트 설치"
	cat_and_run "ls ${font_dir}" "폰트 등록한 다음의 폴더"
else
	echo "${cRed}!!!! ${cGreen}----> ${cCyan}${org_dir}/Font-D2-KoPub-jeju-nanum-seoul.7z 폰트 파일이 없습니다.${cReset}"
fi

echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
