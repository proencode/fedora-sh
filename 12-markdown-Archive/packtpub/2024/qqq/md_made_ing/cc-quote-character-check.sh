#!/bin/sh

script_made () {
	from_file=$1
	from_views=$2
	to_views=$3
	from_char=$4
	to_char=$5

	from_views="${from_views}${from_char}//"
	grep_found=$(grep ${from_char} ${from_file}) #-- 찾는 문자가 파일에 있나?
	if [ "x" != "x${grep_found}" ]; then
		if [ "${to_char}" == "'" ]; then
			#-- sed "..."
			shcmd="${shcmd} ; sed -i \"s/${from_char}/${to_char}/g\" ${from_file}"
		else
			#-- sed '...'
			shcmd="${shcmd} ; sed -i 's/${from_char}/${to_char}/g' ${from_file}"
		fi
		to_views="${to_views}${to_char}//"
	else
		to_views="${to_views}??-"
		echo "#----> ${from_char} 문자가 사용되지 않았습니다."
	fi
}

FILE=$1 #-- 문자 변경할 파일.
shcmd="" #-- 문자 변경하는 셀 스크립트.

from_views="#--from--//" #--from--//“//”//’//
to_views="#---to---//"   #---to---//"//"//'//

script_made ${FILE} ${from_views} ${to_views} "“" '"'
script_made ${FILE} ${from_views} ${to_views} "”" '"'
script_made ${FILE} ${from_views} ${to_views} "’" "'"

if [ "x" != "x${shcmd}" ]; then
	old_dir="old_files"
	cat <<__EOF__
#----> 문자열을 바꾸는 스크립트

if [ ! -d ${old_dir} ]; then mkdir ${old_dir} ; fi ; rsync -avzr ${FILE} ${old_dir}/${FILE}-$(date +%y%m%d-%H%M)${shcmd} #-- 문자 변경 스크립트.

from_views="#--from--//" ${from_views}
to_views="#---to---//"   ${to_views}

#<---- 문자열을 바꾸는 스크립트
__EOF__
fi
