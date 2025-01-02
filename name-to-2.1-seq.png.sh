#!/bin/sh

PartSec="2.1"
echo "#-- Enter 'Part-Sect': [ ${PartSec} ]"
read a
if [ "x$a" != "x" ]; then
	PartSec=$a
fi

SeqNumber=1000
echo "#-- Enter 'Start Seq number': [ ${SeqNumber} ]"
read a
if [ "x$a" != "x" ]; then
	SeqNumber=$a
fi

ImgFileType="png"
echo "#-- Enter 'image File Type': [ ${ImgFileType} ]"
read a
if [ "x$a" != "x" ]; then
	ImgFileType=$a
fi

rename_sh_name="rename-PartSec-SeqNumber-to-original-$(date +%y%m%d-%H%M).sh"

echo "#-- 현재 폴더에 있는 모든 파일들을 ${PartSec}-${SeqNumber:1}.png 으로 바꾸는 bash 스크립트"
ls -r *.${ImgFileType} | while read line
do
        SeqNumber=$(( $SeqNumber + 1 ))
        echo "#-- mv \"${line}\" ${PartSec}-${SeqNumber:1}.${ImgFileType}"
        mv "${line}" ${PartSec}-${SeqNumber:1}.${ImgFileType}
	echo "mv ${PartSec}-${SeqNumber:1}.${ImgFileType} \"${line}\"" >> ${rename_sh_name}
done

echo "#-- 원래의 이름으로 바꾸려면: bash ${rename_sh_name}"
