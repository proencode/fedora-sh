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

cd ~/
main_dir="chrome-extension"
if [ ! -d ${main_dir} ]; then
	cmdrun "mkdir ${main_dir}" "(1) 폴더를 만듭니다."
fi
cd ${main_dir}

begin_no=101
cmdreada "INPUT: QA노트 시작 번호 (3자리 수)" "(2) 그냥 Enter 면, ${rrr}[ ${xxx}${begin_no} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${begin_no}
fi
begin_no=${reada}

end_no=110
cmdreada "INPUT: QA노트 끝 번호 (3자리 수)" "(3) 그냥 Enter 면, ${rrr}[ ${xxx}${end_no} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${end_no}
fi
end_no=${reada}

file_name="qna-chrome-$(date +%y%m%d-%H%M).md"
date_mark=$(date "+%y%m%d(%a) %H%M")
a_mark="$(date +%d%H%M)"
id_mark="gemini${a_mark}"
#--------^^^^^^

cat >> ${file_name} <<__EOF__

- ${date_mark} 질문 모음 (qq)

## 🔥 ${id_mark}-${begin_no:1}.
__EOF__
start_no=$((begin_no + 1))
for (( i=start_no; i<=end_no; i++ ))
do
    cat >> ${file_name} <<__EOF__
### 🔥 ${id_mark}-${i:1}.
__EOF__
done

cat >> ${file_name} <<__EOF__

- ${date_mark} 질문과 답변 (qna)

## 🔥 ${id_mark}-${begin_no:1}.
### 🔋 ${a_mark}-${begin_no:1}.
__EOF__
start_no=$((begin_no + 1))
for (( i=start_no; i<=end_no; i++ ))
do
    cat >> ${file_name} <<__EOF__
### 🔥 ${id_mark}-${i:1}.
### 🔋 ${a_mark}-${i:1}.
__EOF__
done
cmdrun "cat ${file_name}"
echo ""
echo "${yyy}cd ~/; vi ${main_dir}/${file_name}    ${bbb}#--///--${xxx}"
echo ""
