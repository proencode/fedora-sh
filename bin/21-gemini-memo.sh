#!/bin/sh

date_ymd=$(date +%y%m%d) #-- 250524
date_a=$(date +%a) #-- 토
date_HM=$(date +%H%M) #-- 1533
date_mdHM="${date_ymd:2:4}.${date_HM}" #-- 0524.1533
date_dHM="${date_ymd:4:2}.${date_HM}" #-- 24.1533

pressEnter="geminicli"
cat <<__EOF__

(1) AI 이름: [${pressEnter}]
__EOF__
read support_ai
if [ "x${support_ai}" = "x" ]; then
	support_ai="${pressEnter}"
fi

pressEnter=100
cat <<__EOF__

(2) 시작 일련번호: [${pressEnter}]
__EOF__
read begin_no
if [ "x${begin_no}" = "x" ]; then
	begin_no="${pressEnter}"
fi
end_no=$((begin_no + 10))

pressEnter="html로 달력만들기"
cat <<__EOF__

(3) 용도 설명: [${pressEnter}]
____.____+____.____+
__EOF__
read use_for
if [ "x${use_for}" = "x" ]; then
	use_for="${pressEnter}"
fi
use_for_underline=$(echo ${use_for} | sed 's/ /_/g')

app_99_md_file_name="${support_ai}${date_mdHM}-99-${use_for_underline}.md"

for (( i=${begin_no}; i<=${end_no}; i++ ))
do
    cat >> ${app_99_md_file_name} <<__EOF__
🔥
### 🔥 (${use_for}) ${support_ai}${date_mdHM}-${i:1}.
🔋
### 🔋 ${support_ai}${date_mdHM}-${i:1}. 

__EOF__
done
echo "#---- cat ${app_99_md_file_name} ----"
cat ${app_99_md_file_name}
echo "#//// cat ${app_99_md_file_name} ////"
