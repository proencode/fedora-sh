#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="Grails 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

java_1="8.0.292.hs-adpt"
groovy_1="1.6.9"
grails_1="1.3.9"
gradle_1="3.5.1"

java_2="8.0.292.hs-adpt"
groovy_2="2.5.14"
grails_2="2.5.6"
grails_2="2.4.5"
gradle_2="3.5.1"

java_3="8.0.292.hs-adpt"
groovy_3="2.5.14"
grails_3="3.3.14"
gradle_3="3.5.1"

java_4="8.0.292.hs-adpt"
groovy_4="2.5.14"
grails_4="4.0.11"
gradle_4="5.6.4"

echo "${cCyan}#----> java" ; java -version | grep version
echo "${cGreen}#----> groovy" ; groovy -version | grep Version
echo "${cYellow}#----> gradle" ; gradle -version | grep Gradle
echo "${cMagenta}#----> grails" ; grails -version | grep ersion

cat <<__EOF__
${cCyan}#----> sdk 를 설치하려면 실행해 주세요.${cReset}
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
${cBlue}#<---- sdk 를 설치하려면 실행해 주세요.${cReset}

${cYellow}git config --global user.name "yosjeon at $(uname -n)"${cReset}
${cYellow}git config --global user.email "yosjeon@gmail.com"${cReset}
${cYellow}git config --global alias.ll "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ----> 한줄로 로그보기${cReset}
${cYellow}git config --global --list${cReset}

  1  .... grails ${grails_1}
${cRed}[${cYellow} 2 ${cRed}]${cReset}.... grails ${grails_2}
  3  .... grails ${grails_3}
  4  .... grails ${grails_4}

----> 버전 선택: (1...4)  ${cRed}[${cYellow} 2 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"

if [ "x$a" = "x1" ]; then
	java=${java_1}
	groovy=${groovy_1}
	grails=${grails_1}
	gradle=${gradle_1}
else
if [ "x$a" = "x3" ]; then
	java=${java_3}
	groovy=${groovy_3}
	grails=${grails_3}
	gradle=${gradle_3}
else
if [ "x$a" = "x4" ]; then
	java=${java_4}
	groovy=${groovy_4}
	grails=${grails_4}
	gradle=${gradle_4}
else
	#--- 나머지 경우 전부,
	java=${java_2}
	groovy=${groovy_2}
	grails=${grails_2}
	gradle=${gradle_2}
fi
fi
fi
echo "${cRed}[${cYellow} ${grails} ${cRed}] -OK-${cReset}"

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}

cat <<__EOF__
${cCyan}#----> grails ${grails} 를 설치하려면 실행해 주세요.${cReset}
sdk i java ${java} ; sdk i groovy ${groovy} ; sdk i gradle ${gradle} ; sdk i grails ${grails}
sdk u java ${java} ; sdk u groovy ${groovy} ; sdk u gradle ${gradle} ; sdk u grails ${grails}
sdk d java ${java} ; sdk d groovy ${groovy} ; sdk d gradle ${gradle} ; sdk d grails ${grails}
java -version | grep version ; groovy -version | grep Version ; gradle -version | grep Gradle ; grails -version | grep ersion
touch "${logs_folder}/zz.\$(date +"%y%m%d-%H%M%S")..${CMD_NAME}_grails_${grails}"
ls --color ${CMD_DIR} ; echo "#----> ls --color ${logs_folder}" ; ls --color ${logs_folder}
${cMagenta}#<---- grails ${grails} 를 설치하려면 실행해 주세요.${cReset}
__EOF__

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
