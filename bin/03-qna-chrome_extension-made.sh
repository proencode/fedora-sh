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

date_ymd=$(date +%y%m%d)
date_HM=$(date +%H%M)
date_dHM=$(date +%d%H%M)
date_a=$(date +%a)

cd ~/
qna_chrome_extension_DIR="qna-chrome-extension" #-- -${date_ymd}-${date_HM}"
if [ ! -d ${qna_chrome_extension_DIR} ]; then
	mkdir -p ${qna_chrome_extension_DIR}
fi

cd ~/${qna_chrome_extension_DIR}

old_chrome_extension_md_DIR="old-chrome-extension-md"
if [ ! -d ${old_chrome_extension_md_DIR} ]; then
	cmdrun "mkdir -p ${old_chrome_extension_md_DIR}" "(2) .md 와 완성된 chrome-extension 을 보관하는 폴더를 만듭니다."
else
	cmdrun "ls -l ${old_chrome_extension_md_DIR}" "(2) .md 와 완성된 chrome-extension 을 보관하는 폴더내역 입니다."
fi

ymdHM_chrome_extension_DIR="${date_ymd}-${date_HM}-chrome-extension"
if [ ! -d ${ymdHM_chrome_extension_DIR} ]; then
	cmdrun "mkdir -p ${ymdHM_chrome_extension_DIR}" "(1) 크롬확장 폴더를 만듭니다."
else
	cmdrun "ls -l ${ymdHM_chrome_extension_DIR}" "(1) 크롬확장 폴더내역 입니다."
fi

rsync -avzr ~/bin/03-qna-chrome_extension-made.sh .

begin_no=100
cmdreada "INPUT: QA노트 시작 번호 (3자리 수)" "(3) 그냥 Enter 면, ${rrr}[ ${xxx}${begin_no} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${begin_no}
fi
begin_no=${reada}

end_no=109
cmdreada "INPUT: QA노트 끝 번호 (3자리 수)" "(4) 그냥 Enter 면, ${rrr}[ ${xxx}${end_no} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${end_no}
fi
end_no=${reada}

file_name="${date_ymd}-${date_HM}-qna-chrome.md"
date_mark="${date_ymd}(${date_a}) ${date_HM}"
my_id="gem"
#------^^^^^^
cmdreada "INPUT: 일련번호 앞의 접두어" "(5) 그냥 Enter 면, ${rrr}[ ${xxx}${my_id} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${my_id}
fi
my_id=${reada}

id_mark="${my_id}${date_dHM}"

cat >> ${file_name} <<__EOF__

## ${date_mark} 질문과 답변 (qna)

## 🔥 ${id_mark}-${begin_no:1}.
### 🔋 ${date_dHM}-${begin_no:1}.

__EOF__
start_no=$((begin_no + 1))
for (( i=start_no; i<=end_no; i++ ))
do
    cat >> ${file_name} <<__EOF__
### 🔥 ${id_mark}-${i:1}.
### 🔋 ${date_dHM}-${i:1}.

__EOF__
done
cat >> ${file_name} <<__EOF__

### 🔥 ${id_mark}-${begin_no:1}a.
### 🔋 ${date_dHM}-${begin_no:1}a.

start_no=$(( end_no + 1 )); lines=10; echo ""; for (( i=start_no; i<=\$(( \$start_no + \$lines - 1 )); i++ )); do echo "### 🔥 ${id_mark}-\${i:1}."; echo "### 🔋 ${date_dHM}-\${i:1}."; echo ""; done; echo ""; echo "### 🔥 ${id_mark}-\${start_no:1}a."; echo "### 🔋 ${date_dHM}-\${start_no:1}a.";
__EOF__

cmdrun "cat ${file_name}" "(7) 만든 내용 확인"

echo ""
echo "${yyy}cd ~/${qna_chrome_extension_DIR}; vi ${file_name}    ${bbb}#--///-- qna-파일에 입력하기.${xxx}"
echo ""
