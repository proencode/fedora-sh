#!/bin/sh

date_ymd=$(date +%y%m%d) #-- 250524
date_a=$(LC_TIME=C date +%a) #-- Sat
date_HM=$(date +%H%M) #-- 1533
ymd_mdHM="${date_ymd:2:4}.${date_HM}" #-- 0524.1533
ymd_dHM="${date_ymd:4:2}.${date_HM}" #-- 24.1533

pressEnter=100
cat <<__EOF__

(1) 시작 일련번호: [${pressEnter}]
__EOF__
read begin_no
if [ "x${begin_no}" = "x" ]; then
	begin_no="${pressEnter}"
fi
end_no=$((begin_no + 10))

pressEnter="geminicli"
cat <<__EOF__

(2) AI 이름: [${pressEnter}]
__EOF__
read support_ai
if [ "x${support_ai}" = "x" ]; then
	support_ai="${pressEnter}"
fi

pressEnter="html로 달력만들기"
cat <<__EOF__

(3) 용도 설명: [${pressEnter}]
____.____+____.____+
__EOF__
read use_for
if [ "x${use_for}" = "x" ]; then
	use_for="${pressEnter}"
fi
use_by_underline=$(echo ${use_for} | sed 's/ /_/g')
ai_mdHM="${support_ai}${ymd_mdHM}"

backup_dir="backup-${ai_mdHM}"
mkdir ../${backup_dir}

dir_name="${ai_mdHM}-${use_by_underline}"
mkdir ${dir_name}
cd ${dir_name}
thisdir=$(pwd)

mdirm="../last-${ai_mdHM}-99-${use_by_underline}.md"

cat >> ${mdirm} <<__EOF__

cd ${thisdir}; head -10 ${mdirm}

#---

end_no=${end_no} ; begin_no=\$((end_no + 1)); end_no=\$((end_no + 10));mdirm="${mdirm}"; for (( i=\${begin_no}; i<=\${end_no}; i++ )); do echo "🔥" >> \${mdirm}; echo "### 🔥 ( ${use_for} ) ${ai_mdHM}-\${i:1}." >> \${mdirm}; echo ""; echo "🔋" >> \${mdirm}; echo "### 🔋 ${ai_mdHM}-\${i:1}. " >> \${mdirm}; echo "" >> \${mdirm}; done

#--- ${use_for}


__EOF__

for (( i=${begin_no}; i<=${end_no}; i++ ))
do
    cat >> ${mdirm} <<__EOF__
🔥
### 🔥 ( ${use_for} )
### 다음줄의 줄 번호를 아래 :13,. w ${i:1}a- 부분의 시작번호로 지정하고, 이 줄을 지운다.
${ai_mdHM}-${i:1}.


# echo " :  13,. w ${i:1}a-${ai_mdHM}.txt   파일의 내용을 읽고 지시에 따라줘.   "
# echo " : rsync -avzr ../${dir_name}/ ../../${backup_dir}/${i:1}-${dir_name}/   만들어진 txt 를 로컬로 복사.   "
__EOF__
    cat >> ${mdirm} <<__EOF__

🔋
### 🔋 ${ai_mdHM}-${i:1}. 

__EOF__
done

cat <<__EOF__

cd ${thisdir}; head -10 ${mdirm}

__EOF__
