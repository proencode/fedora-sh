#!/bin/sh

file=$1
#-- “”
char1="“"
char2="”"
found=0

found_char=$(grep $char1 $file)
if [ "x" != "x${found_char}" ]; then
	found=1
fi
echo "1) found=${found};"
found_char=$(grep $char2 $file)
if [ "x" != "x${found_char}" ]; then
	found=$((${found} + 1))
fi
echo "2) found=${found};"

if [ ${found} > 0 ]; then
	echo "cp ${file} ${file}-$(date +%y%m%d-%H%M) ; sed -i 's/${char1}/\"/g' ${file} ; sed -i 's/${char2}/\"/g' ${file} #-- 명령으로 --${char}-- 문자열을 바꾸세요."
fi
