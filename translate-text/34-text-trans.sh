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
# echo "${cCyan}----> ${cRed}
# ${cReset}"
# echo "${cBlue}<---- ${cMagenta}
# ${cReset}"
MEMO="Language Translator Using Google API in Python"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
# logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
# log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


cat <<__EOF__
210924 Language Translator Using Google API in Python
https://www.geeksforgeeks.org/language-translator-using-google-api-in-python/

Step-by-step – Python 3 PIP Fedora 35 Installation Guide
October 5, 2021 | By the+gnu+linux+evangelist | Filed in: Tutorial.
https://tutorialforlinux.com/2021/10/05/step-by-step-python-3-pip-fedora-35-installation-guide/
__EOF__

cat_and_run "sudo dnf -y install python3-pip" "pip 설치"
cat_and_run "pip install googletrans==4.0.0-rc1" "번역 라이브러리 설치 출처: https://blockdmask.tistory.com/540 [개발자 지망생"

py_name=05-trans-text.py
echo "----> ${py_name} 소스 파일을 만듭니다."

fromColor="${cRed}from${cGreen}"
toColor="${cRed}to  ${cYellow}"

cat > ${py_name} <<__EOF__
# 출처: https://blockdmask.tistory.com/540 [개발자 지망생]
import googletrans
translator = googletrans.Translator()

orgen="This book is designed to develop both server and client for an application."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="We have used the Kotlin language for both the server and client sides."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="In this book, Spring will be the server-side application, and Android the client-side application."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="Our primary focus is on those areas that will be able to help a developer develop a secure application with the latest architecture."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="This book describes the basics of Kotlin and Spring, which will be of benefit if you are unfamiliar with these platforms."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="We also designed the chapters for implementing security and database in a project."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="This book delves into the use of Retrofit for handling HTTP requests and SQLite Room for storing data in an Android device."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="You will also be able to find a way of how to develop a robust, reactive project."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
orgen="Then, you will learn how to test a project using JUnit and Espresso for developing a less bug-prone and stable project."
strko=translator.translate(orgen, dest='ko')
print(f"${fromColor} {orgen}")
print(f"${toColor} {strko.text}")
print(f"${cCyan}----> ok${cReset}")
__EOF__

cat_and_run "python ${py_name}" "번역 테스트"

# translation = translator.translate("This book is designed to develop both server and client for an application. We have used the Kotlin language for both the server and client sides. In this book, Spring will be the server-side application, and Android the client-side application. Our primary focus is on those areas that will be able to help a developer develop a secure application with the latest architecture. This book describes the basics of Kotlin and Spring, which will be of benefit if you are unfamiliar with these platforms. We also designed the chapters for implementing security and database in a project. This book delves into the use of Retrofit for handling HTTP requests and SQLite Room for storing data in an Android device. You will also be able to find a way of how to develop a robust, reactive project. Then, you will learn how to test a project using JUnit and Espresso for developing a less bug-prone and stable project.")

# ----
# rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
# cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
