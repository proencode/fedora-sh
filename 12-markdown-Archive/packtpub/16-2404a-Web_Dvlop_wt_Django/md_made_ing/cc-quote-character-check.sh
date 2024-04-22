#!/bin/sh

file=$1
shcmd=""

#-- from_chars="#--from--" #--from--“--”--’--
#-- to_chars="#---to---"   #---to---"--"--'--
from_chars="#--from--"
to_chars="#---to---"

for char in "“" "”"
do
	found_char=$(grep ${char} ${file})
	from_chars="${from_chars}${char}--"
	if [ "x" != "x${found_char}" ]; then
		shcmd="${shcmd} ; sed -i 's/${char}/\\\"/g' ${file}"
		#-- ---------------------(_________|^^^^|_)
		to_chars="${to_chars}\"--"
	else
		to_chars="${to_chars}??-"
	fi
done

for char in "’"
do
	found_char=$(grep ${char} ${file})
	from_chars="${from_chars}${char}--"
	if [ "x" != "x${found_char}" ]; then
		shcmd="${shcmd} ; sed -i \"s/${char}/'/g\" ${file}"
		#-- ---------------------(__________|^|__)
		to_chars="${to_chars}'--"
	else
		to_chars="${to_chars}!!-"
	fi
done

if [ "x" != "x${shcmd}" ]; then
	cat <<__EOF__
#----> 문자열을 바꾸는 스크립트

rsync -avzr ${file} md_made_ing/old-files/${file}-$(date +%y%m%d-%H%M)${shcmd} #-- 문자열을 바꿉니다.

#-- from_chars="#--from--" ${from_chars}
#-- to_chars="#---to---"   ${to_chars}

#<---- 문자열을 바꾸는 스크립트
__EOF__
fi
