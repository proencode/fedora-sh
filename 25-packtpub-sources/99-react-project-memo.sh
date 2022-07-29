#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cCyan}$1 ${cBlue}$2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cCyan}$1 ${cMagenta}$2${cReset}"
}

new_dir=chap01

cat <<__EOF__

(0) npm 에서 필요한 패키지를 설치합니다.
(1) 나중에 이 파일을 애플리케이션의 시작점이 되도록 webpack 을 구성할 예정입니다.

시작 위치 번호 ; 그냥 엔터 => 지우고 새로 시작함
----> press Number:
__EOF__
read START_NUM

if [ "x$START_NUM" = "x" ]; then
	if [ -d ${new_dir} ]; then
		rm -rf ${new_dir}
	fi
fi

mkdir ${new_dir} ; cd ${new_dir}

if [ "x$START_NUM" \< "x0" ]; then
	cat_and_read "npm init -y ; npm install --save-dev webpack webpack-cli" "#-- (0) npm 에서 필요한 패키지를 설치합니다."
fi

if [ "x$START_NUM" \< "x1" ]; then
	cat_and_read "mkdir src/ ; echo \"console.log('Rick and Morty');\" > src/index.js" "#-- (1) 나중에 이 파일을 애플리케이션의 시작점이 되도록 webpack 을 구성할 예정입니다."
fi

if [ "x$START_NUM" \< "x2" ]; then
	sed -n '1,/"scripts": {/p' package.json > xtemp1
	cat > xtemp2 <<__EOF__
     "start": "webpack --mode development",
     "build": "webpack --mode production"
__EOF__
	sed -n '/  },/,$p' package.json > xtemp3
	cat xtemp1 xtemp2 xtemp3 > package.json

	echo "vi package.json   #-- (2) start 와 build 를 추가하도록 수정합니다."
	vi package.json
fi

