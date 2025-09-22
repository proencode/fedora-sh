#1/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | sh
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdreada_s () { #-- cmdreada_s "(1) INPUT: port no" "(입력시 표시 안됨)"
        echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
        read -s reada_s
}
cmdreada () { #-- cmdreada "(2) INPUT: domain name" "호스트 주소 입력"
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"
        read reada
}

build_ymdaHM="0a-00-bada-$(LC_TIME=C date +%y%m%d_%a.%H%M).7z"
cmdrun "7za a -mx=9 -p ${build_ymdaHM} 00-bada/" "(2-1) ${build_ymdaHM} 압축파일 만들기"
cmdrun "ls -l 00-bada/ | awk 'NR > 1 { file_type = substr(\$1, 1, 1) ;  printf \"%s %11s %5s %2s %5s %s \", file_type, \$5, \$6, \$7, \$8, \$9 ;   printf \"\\n\" }' > ${build_ymdaHM}.ls-l" "(2-2) ${build_ymdaHM}.ls-l 목록 만들기"
