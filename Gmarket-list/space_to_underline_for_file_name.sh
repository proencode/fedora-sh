#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 

if [ "x$1" = "x" ]; then
	cat <<__EOF__

${cYellow}----> ${cMagenta}바꾸려는 파일 이름을 같은줄에 써야 합니다.${cReset}

${cYellow}----> ${cReset}sh $0 ${cYellow}original File Name.txt${cReset}

__EOF__
	exit -1
fi

original_file_name=$1

#-- " str_01 " == 빈칸을 밑줄로.
str_01=$(echo ${original_file_name} | sed 's/ /_/g')

#-- " STR_02 " == 대문자를 소문자로.
# https://varie.tistory.com/entry/Bash%EC%89%98%EC%97%90%EC%84%9C-%ED%8C%8C%EC%9D%BC%EB%AA%85-%EC%9D%BC%EA%B4%84-%EB%8C%80%EC%86%8C%EB%AC%B8%EC%9E%90-%EB%B3%80%ED%99%98
STR_02=$(echo ${str_01,,})
#-- 소문자를 대문자로 바꿀때는: STR_02=$(echo ${str_01^^})
#-- bash3.x 인 경우: STR_02=$(echo ${str_01} | tr '[A-Z]' '[a-z]')

#-- "str_03 " == 특수문자 삭제하거나 변경
str_03=$(echo ${STR_02} | sed 's/(//g' | sed 's/)//g' | sed 's/;//g' | sed 's/<//g' | sed 's/>//g' | sed 's/[//g' | sed 's/]//g')
cat <<__EOF__

${cBlue}${original_file_name} ${cYellow}---->

${cRed}${str_03}

__EOF__
