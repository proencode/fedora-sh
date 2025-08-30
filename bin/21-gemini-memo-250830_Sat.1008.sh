#!/bin/sh

date_ymd=$(date +%y%m%d) #-- 250524
date_a=$(date +%a) #-- 토
date_HM=$(date +%H%M) #-- 1533
date_mdHM="${date_ymd:2:4}.${date_HM}" #-- 0524.1533
date_dHM="${date_ymd:4:2}.${date_HM}" #-- 24.1533

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
use_for_underline=$(echo ${use_for} | sed 's/ /_/g')

ai_mdHM="${support_ai}${date_mdHM}"
dir_name="${ai_mdHM}-${use_for_underline}"

mkdir ${dir_name}
cd ${dir_name}
thisdir=$(pwd)

mdirm="${ai_mdHM}-99-${use_for_underline}.md"

cat >> ${mdirm} <<__EOF__

cd ${thisdir}; head -10 ${mdirm}

#---

end_no=${end_no} ; begin_no=\$((end_no + 1)); end_no=\$((end_no + 10));mdirm="${mdirm}"; for (( i=\${begin_no}; i<=\${end_no}; i++ )); do echo "🔥" >> \${mdirm}; echo "### 🔥 ( ${use_for} ) ${ai_mdHM}-\${i:1}." >> \${mdirm}; echo "🔋" >> \${mdirm}; echo "### 🔋 ${ai_mdHM}-\${i:1}. " >> \${mdirm}; echo "" >> \${mdirm}; done

#--- ${use_for}


__EOF__

for (( i=${begin_no}; i<=${end_no}; i++ ))
do
    cat >> ${mdirm} <<__EOF__
🔥
### 🔥 ( ${use_for} ) ${ai_mdHM}-${i:1}.
🔋
### 🔋 ${ai_mdHM}-${i:1}. 

__EOF__
done

cat <<__EOF__

cd ${thisdir}; head -10 ${mdirm}

__EOF__
