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

use_for="1주 달력"
#--------^^^^^^^^
cmdreada "(1) INPUT: 용도 간단 설명" "그냥 Enter 면, ${rrr}[ ${xxx}${use_for} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${use_for}
fi
use_for=${reada}
use_for_underline=$(echo ${use_for} | sed 's/ /_/g')
echo "${ccc}#-- ${rrr}[ ${xxx}${use_for} ${bbb}| ${ccc}${use_for_underline} ${rrr}]${xxx}"

support_ai="gemini"
#-----------^^^^^^
cmdreada "(2) INPUT: 일련번호 앞의 접두어" "그냥 Enter 면, ${rrr}[ ${xxx}${support_ai} ${rrr}]"
if [ "x${reada}" = "x" ]; then
    reada=${support_ai}
fi
support_ai=${reada}
echo "${ccc}#-- ${rrr}[ ${xxx}${support_ai} ${rrr}]${xxx}"

supportAI_dHM="${support_ai}${date_dHM}"
last_ymd_HM="last-${date_ymd}-${date_HM}-${use_for_underline}"

echo "${yyy}#-- ${ccc}새 폴더를 ${xxx}$(pwd) ${bbb}아래에 만듭니다.${xxx}"
cmdreada "(2a) INPUT: 새 폴더 이름 입력" "그냥 Enter 하면: ${yyy}[ ${bbb}${last_ymd_HM} ${yyy} ]"
if [ "x$reada" != "x" ]; then
    last_ymd_HM="${reada}"
fi
if [ ! -d ${last_ymd_HM} ]; then
	cmdrun "mkdir -p ${last_ymd_HM}; ls -l ${last_ymd_HM}" "(2b) last_ 폴더를 새로 만듭니다."
fi
echo "${ccc}#-- ${rrr}[ ${xxx}${last_ymd_HM} ${rrr}]${xxx}"

echo "${yyy}#-- ${ccc}cd ${last_ymd_HM} ${mmm}#-- ${bbb}(3) last- 폴더로 갑니다.${xxx}"
cd "${last_ymd_HM}" #-- cmdrun 으로 실행시 처리 안됨.
echo "${bbb}#// cd ${last_ymd_HM} #-- (3) last- 폴더로 갑니다.${xxx}"

###

backup_md_dir="backup-chrome-extension-md"
if [ ! -d ${backup_md_dir} ]; then
	cmdrun "mkdir -p ${backup_md_dir}" "(4a) .md 와 완성된 chrome-extension 을 보관하는 폴더를 만듭니다."
else
	cmdrun "ls -l ${backup_md_dir}" "(4b) .md 와 완성된 chrome-extension 을 보관하는 폴더내역 입니다."
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

file_name="app-${date_ymd}-${date_HM}-99-${use_for_underline}.md"
#- if [ -f ${file_name} ]; then
#- 	cmdrun "mv ${file_name} ${file_name}-$(date +%y%m%d%a-%H%M%S)" "이전의 파일 이름을 바꿉니다."
#- fi


#-- 브라우저는 이 폴더를 쓰고, 오류가 없으면 -00, -01 ... 로 바꿔서 보관한다.
chrome_extension_DIR="${supportAI_dHM}-99"
if [ ! -d ${chrome_extension_DIR} ]; then
	cmdrun "mkdir -p ${chrome_extension_DIR}" "(5a) 크롬확장 폴더를 만듭니다."
fi
cmdrun "mkdir a1-${date_ymd:2:4}초순.01-10 a2-${date_ymd:2:4}중순.11-20 a3-${date_ymd:2:4}하순.21-31" "(5b) 10일단위 백업 폴더를 만듭니다."

cat >> ${file_name} <<__EOF__

### ${date_mark} 질문과 답변 (qna)

__EOF__

for (( i=$begin_no; i<=end_no; i++ ))
do
    cat >> ${file_name} <<__EOF__
🔥
### 🔥 (${use_for}) ${supportAI_dHM}-${i:1}.

### 🔋 ${date_dHM}-${i:1}. 



__EOF__
done

begin_no=$((begin_no + 10))
end_no=$((end_no + 10))
cat >> ${file_name} <<__EOF__
begin_no=${begin_no}; end_no=${end_no}; echo ""; echo "### ${date_mark} 질문과 답변 (qna)"; echo ""; for (( i=begin_no; i<=end_no; i++ )); do echo "🔥"; echo "### 🔥 (${use_for}) ${supportAI_dHM}-\${i:1}."; echo ""; echo "### 🔋 ${date_dHM}-\${i:1}."; echo ""; echo ""; done
__EOF__

cmdrun "cat ${file_name}" "(9) 만든 내용 확인"

cat > 02-saveto-number.sh <<__EOF__
#!/bin/sh

cc="(${use_for}) ${supportAI_dHM}" #-- "cusr12.1039"

echo "#-- sh 02-saveto-number.sh (\${1})"
echo "#-- "
if [[ "x\${1}" < "x00" || "x\${1}" > "x99" ]]; then
        echo "#-- sh 02-saveto-number.sh 00"
        echo "#-- "
        echo "#-- 입력값은 "00" ~ "99" 사이의 값이라야 합니다."
else
        a="000\${1}" #-- \${a: -2} == 뒤에서 2개를 꺼낸다.
        dd="\${cc}-\${a: -2}"
        if [ -d \${dd} ]; then
                echo "#-- \${dd} 폴더가 있어서 백업할 수 없습니다."
        else
                echo "#-- rsync -avzr \${cc}-99/ \${cc}-\${a: -2}/"
                rsync -avzr \${cc}-99/ \${cc}-\${a: -2}/
                echo "#-- ls -l --color"
                ls -l --color
        fi
fi
__EOF__

cat > 01-server_last_COPYTO_here.sh <<__EOF__
#!/bin/sh

cc="(${use_for}) ${supportAI_dHM}" #-- "cusr12.1039"

yymm="$(date +%y%m)" #-- 2506
cd ~/Downloads; mkdir ${yymm}; cd ${yymm}

echo "#-- rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*/${yymm}/last* . #-- ${yymm}/last 를 이곳으로 가져옵니다."
echo "#-- press 'y':"
read a
if [ "x$a" != "xy" ]; then
	echo "#-- 'y' 가 아니므로 가져오기를 중단합니다."
	exit -1
fi
rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*/${yymm}/last* .
echo "#-- rsync -avzr -e 'ssh -p 5822' proenpi@pi:g*/f*/q*/${yymm}/last* ."
__EOF__

cat <<__EOF__

${yyy}cd ${last_ymd_HM}; vi ${file_name}    ${bbb}#--///-- qna-파일에 입력하기.${xxx}

sh saveto-number.sh 33    #-- ${cc}-99 를 ${cc}-33 으로 바꾸고,
#-- ${cc}-99 를 새로 만듭니다.
__EOF__

cmdrun "ls -1" "(10) 소스를 -00 등올 바꾸고, -99 를 새로 만드는 명령을 파일로 표시했습니다."
