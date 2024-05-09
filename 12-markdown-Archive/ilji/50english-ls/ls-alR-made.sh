#/bin/sh

for zipfile in 0-49part.zip 50-99part.zip ENES-all.zip ENKO-all.zip mp3Directcut134.zip
do
	echo "#-- mkdir ${zipfile} ; cd ${zipfile}"
	mkdir ${zipfile} ; cd ${zipfile}
	echo "#-- 7za x ../../${zipfile} ; cd ../"
	7za x ../../${zipfile} ; cd ../
	echo "#-- ls -alR . > ../${zipfile}.ls-alR"
	ls -alR . > ../${zipfile}.ls-alR
	echo "#-- ls .."
	ls ..
	echo "#-- ls -l"
	ls -l
	echo "#----> rm -rf ${zipfile} #-- press Enter:" ; read a
	rm -rf ${zipfile}
done

#-- for rarfile in 기본문장.part1.rar 기본문장.part2.rar 기본문장.part3.rar 기본문장.part4.rar 기본문장.part5.rar 회화.part1.rar 회화.part3.rar 회화.part4.rar 회화.part5.rar
for rarfile in 기본문장.part1.rar 회화.part1.rar
do
	echo "#-- mkdir ${rarfile} ; cd ${rarfile}"
	mkdir ${rarfile} ; cd ${rarfile}
	echo "#-- unrar x ../../${rarfile} ; cd ../"
	unrar x ../../${rarfile} ; cd ../
	echo "#-- ls -alR . > ../${rarfile}.ls-alR"
	ls -alR . > ../${rarfile}.ls-alR
	echo "#-- ls .."
	ls ..
	echo "#-- ls -l"
	ls -l
	echo "#----> rm -rf ${rarfile} #-- press Enter:" ; read a
	rm -rf ${rarfile}
done
