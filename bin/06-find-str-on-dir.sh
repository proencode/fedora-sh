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

default_dir="./"
if [ "x$1" != "x" ]; then
	default_dir="$1"
fi
cmdreada "(1) INPUT: 찾기 시작하는 폴더" "${rrr}[ ${yyy}${default_dir} ${rrr}]${xxx}"
if [ "x${reada}" = "x" ]; then
	reada="${default_dir}"
fi
default_dir="${reada}"

find_str="찾으려는 문자열을 입력하세요"
if [ "x$2" != "x" ]; then
	find_str="$2"
fi
cmdreada "(2) INPUT: 찾으려는 문자열" "${rrr}[ ${yyy}${find_str} ${rrr}]${xxx}"
if [ "x${reada}" = "x" ]; then
	reada="${find_str}"
fi
find_str="${reada}"

cmdrun "find ${default_dir} -type f -exec awk '/${find_str}/ {print FILENAME \":${rrr}\" NR \"${xxx}:\" \$0}' {} \;" 

cmdend "지정한 디렉토리에서 문자열 찾기"
#--
#--
#--
#-- ssh yosj@gg; ssh proenpi@pi; ssh yosj@yow; ssh orangepi@opw; ssh orangepi@myw; ssh yosj@nlw; ssh yosj@mnw;
