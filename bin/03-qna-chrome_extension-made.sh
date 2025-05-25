#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
    echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | sh
    echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdend () {
    echo "${bbb}#--///-- ${mmm}$1${xxx}"
}
cmdreada_s () { #-- cmdreada_s "(1) INPUT: port no" "(입력시 표시 안됨)"
    echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
    read -s reada_s
}
cmdreada () { #-- cmdreada "(2) INPUT: domain name" "호스트 주소 입력"
    echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"
    read reada
}

date_ymd=$(date +%y%m%d) #-- 250524
date_a=$(date +%a) #-- 토
date_HM=$(date +%H%M) #-- 1533

date_dHM="${date_ymd:4:2}.${date_HM}" #-- 24.1533
date_ymdHM="${date_ymd}.${date_HM}" #-- 250524.1533
date_mark="${date_ymd}(${date_a}) ${date_HM}" #-- 250524(토) 1533
my_id="gemini"
#------^^^^^^
cmdreada "(1) INPUT: 일련번호 앞의 접두어" "그냥 Enter 면, ${rrr}[ ${xxx}${my_id} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${my_id}
fi
my_id=${reada}
echo "${ccc}#-- ${rrr}[ ${xxx}${my_id} ${rrr}]${xxx}"

id_mark="${my_id}${date_dHM}"
qna_chrome_extension_DIR="last-${date_ymd}-${date_HM}"
md_dir="md-${date_ymd}-${date_HM}-chrome-extension"

echo "${yyy}#-- ${ccc}새 폴더를 ${xxx}$(pwd) ${bbb}아래에 만듭니다.${xxx}"
cmdreada "(2a) INPUT: 새 폴더 이름 입력" "그냥 Enter 하면: ${yyy}[ ${bbb}${qna_chrome_extension_DIR} ${yyy} ]"
if [ "x$reada" != "x" ]; then
    qna_chrome_extension_DIR="${reada}"
fi
if [ ! -d ${qna_chrome_extension_DIR} ]; then
	cmdrun "mkdir -p ${qna_chrome_extension_DIR}; ls -l ${qna_chrome_extension_DIR}" "(2b) 폴더를 새로 만듭니다."
fi
echo "${ccc}#-- ${rrr}[ ${xxx}${qna_chrome_extension_DIR} ${rrr}]${xxx}"

echo "${yyy}#-- ${ccc}cd ${qna_chrome_extension_DIR} ${mmm}#-- ${bbb}(3) qna- 폴더로 갑니다.${xxx}"
cd "${qna_chrome_extension_DIR}" #-- cmdrun 으로 실행시 처리 안됨.
echo "${bbb}#// cd ${qna_chrome_extension_DIR} #-- (3) qna- 폴더로 갑니다.${xxx}"

###

backup_chrome_extension_md_DIR="backup-chrome-extension-md"
if [ ! -d ${backup_chrome_extension_md_DIR} ]; then
	cmdrun "mkdir -p ${backup_chrome_extension_md_DIR}" "(4a) .md 와 완성된 chrome-extension 을 보관하는 폴더를 만듭니다."
else
	cmdrun "ls -l ${backup_chrome_extension_md_DIR}" "(4b) .md 와 완성된 chrome-extension 을 보관하는 폴더내역 입니다."
fi

echo "${mmm}#-- ${bbb}(6) 03- 스크립트를 이곳으로 복사하는 작업을 취소합니다.${xxx}"
#-- cmdrun "rsync -avzr ~/bin/03-qna-chrome_extension-made.sh ." "(6) 스크립트를 이곳으로 복사합니다."

begin_no=100
cmdreada "INPUT: QA노트 시작 번호 (3자리 수)" "(7) 그냥 Enter 면, ${rrr}[ ${xxx}${begin_no} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${begin_no}
fi
begin_no=${reada}

end_no=109
cmdreada "INPUT: QA노트 끝 번호 (3자리 수)" "(8) 그냥 Enter 면, ${rrr}[ ${xxx}${end_no} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${end_no}
fi
end_no=${reada}

file_name="app-${date_ymd}-${date_HM}-99-작업이름.md"
#- if [ -f ${file_name} ]; then
#- 	cmdrun "mv ${file_name} ${file_name}-$(date +%y%m%d%a-%H%M%S)" "이전의 파일 이름을 바꿉니다."
#- fi


chrome_extension_DIR="chrome-${date_ymd}-${date_HM}-${begin_no:1}"
if [ ! -d ${chrome_extension_DIR} ]; then
	cmdrun "mkdir -p ${chrome_extension_DIR}" "(5a) 크롬확장 폴더를 만듭니다."
fi

cat >> ${file_name} <<__EOF__

### ${date_mark} 질문과 답변 (qna)

__EOF__

for (( i=$begin_no; i<=end_no; i++ ))
do
    cat >> ${file_name} <<__EOF__
🔥
### 🔥 ${id_mark}-${i:1}.
mkdir chrome-${date_ymd}-${date_HM}-${i:1}

### 🔋 ${date_dHM}-${i:1}. 


__EOF__
done

begin_no=$((begin_no + 10))
end_no=$((end_no + 10))
cat >> ${file_name} <<__EOF__
begin_no=${begin_no}; echo ""; echo "### ${date_mark} 질문과 답변 (qna)"; echo ""; for (( i=begin_no; i<=end_no; i++ )); do echo "🔥"; echo "### 🔥 ${id_mark}-\${i:1}."; echo "mkdir chrome-${date_ymd}-${date_HM}-\${i:1}"; echo ""; echo "### 🔋 ${date_dHM}-\${i:1}."; echo ""; echo ""; done
__EOF__

cmdrun "cat ${file_name}" "(9) 만든 내용 확인"

echo ""
echo "${yyy}cd ${qna_chrome_extension_DIR}; vi ${file_name}    ${bbb}#--///-- qna-파일에 입력하기.${xxx}"
echo ""
