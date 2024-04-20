#!/bin/sh

file=$1
shcmd=""

#-- " " '

for char in "“" "”"
do
	found_char=$(grep ${char} ${file})
	if [ "x" != "x${found_char}" ]; then
		shcmd="${shcmd} ; sed -i 's/${char}/\\\"/g' ${file}"
		#-- ---------------------(_________|^^^^|_)
	fi
done

for char in "’"
do
	found_char=$(grep ${char} ${file})
	if [ "x" != "x${found_char}" ]; then
		shcmd="${shcmd} ; sed -i \"s/${char}/'/g\" ${file}"
		#-- ---------------------(__________|^|__)
	fi
done

if [ "x" != "x${shcmd}" ]; then
	echo "rsync -avzr ${file} md_made_ing/old-files/${file}-$(date +%y%m%d-%H%M)${shcmd} #-- 문자열을 바꿉니다."
fi
