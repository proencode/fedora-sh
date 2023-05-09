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

space_to_underline=$(echo ${original_file_name} | sed 's/ /_/g') #-- 빈칸을 밑줄로.

# https://varie.tistory.com/entry/Bash%EC%89%98%EC%97%90%EC%84%9C-%ED%8C%8C%EC%9D%BC%EB%AA%85-%EC%9D%BC%EA%B4%84-%EB%8C%80%EC%86%8C%EB%AC%B8%EC%9E%90-%EB%B3%80%ED%99%98
uppercase_to_lowercase=$(echo ${space_to_underline,,}) #-- 소문자>대문자의 경우: lowercase_to_uppercase=$(echo ${space_to_underline^^})
#-- bash3.x 인 경우: uppercase_to_lowercase=$(echo ${space_to_underline} | tr '[A-Z]' '[a-z]')

uppercase_to_lowercase=$(echo ${space_to_underline,,}) #-- 소문자>대문자의 경우: lowercase_to_uppercase=$(echo ${space_to_underline^^})
excluding_special_characters=$(echo ${original_file_name} | sed 's/(//g' | sed 's/)//g') #-- 괄호 삭제
cat <<__EOF__

${cBlue}${original_file_name} ${cYellow}---->

${cRed}${no_parenthesis}

__EOF__
