#1/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | sh
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdYrun () {
        echo "${yyy}#-- ${ccc}$1 ${yyy}#-- 실행하려면, 'y' + Enter: ${bbb}$2${xxx}"
	read a
	if [[ "x$a" == "xy" ]]; then
		echo "$1" | sh
        	echo "${bbb}#// $1 #-- $2${xxx}"
	else
		echo "${bbb}#// ${rrr}$1 ${bbb}#-- 'y' 아니라서 실행하지 않음.${xxx}"
	fi
}

cat <<__EOF__
0 ..... 00-bada
1 ..... 01-last_big_files
2 ..... 02-more_300M_files
#---> Enter: [ 0, 1, 2 ]
__EOF__
read a
if [[ "x$a" -lt "x1" || "x$a" -gt "x3" ]]; then
	echo "#-- Enter 0, 1, 2, please."
	exit -1
fi
if [[ "x$a" == "x0" ]]; then
	dir_name="00-bada"
	seq_dir_name="0a-${dir_name}" #-- 0a-00-bada
else
	if [ "x$a" == "x1" ]; then
		dir_name="01-last_big_files"
		seq_dir_name="0b-${dir_name}"
	else
		if [[ "x$a" == "x2" ]]; then
			dir_name="02-more_300M_files"
			seq_dir_name="0c-${dir_name}"
		#-- else #-- 위에서 걸렀음.
		fi
	fi
fi

trash_dir="trash-dir"
if [[ ! -d ${trash_dir} ]]; then
	cmdrun "mkdir ${trash_dir}" "(0) 지난번 파일들을 옮겨둘 폴더를 만듭니다."
fi

cmdrun "ls -l ${seq_dir_name}*[zl]; mv ${seq_dir_name}*[zl] ${trash_dir}/" "(1) 지난번 파일들을 ${trash_dir} 폴더로 옮깁니다."

seq_dir_ymdhm_7z="${seq_dir_name}-$(LC_TIME=C date +%y%m%d_%a.%H%M).7z"
cmdYrun "time 7za a -mx=9 -p ${seq_dir_ymdhm_7z} ${dir_name}/" "(2) ${dir_name} 폴더를 압축합니다."

#-- 이름순
cmdrun "ls -l ${dir_name}/ | awk 'NR > 1 { file_type = substr(\$1, 1, 1); printf \"%s %12s %5s %2s %5s %s \", file_type, \$5, \$6, \$7, \$8, \$9; printf \"\\n\" }' > ${seq_dir_ymdhm_7z}.ls-l" "(4-1) ${seq_dir_ymdhm_7z}.ls-l 목록을 만듭니다."

#-- 기타 = 시간순
cmdrun "ls -trl ${dir_name}/ | awk 'NR > 1 { file_type = substr(\$1, 1, 1); printf \"%s %12s %5s %2s %5s %s \", file_type, \$5, \$6, \$7, \$8, \$9; printf \"\\n\" }' > ${seq_dir_ymdhm_7z}.ls-trl" "(4-2) ${seq_dir_ymdhm_7z}.ls-trl 목록을 만듭니다."

cmdrun "ls -l ${trash_dir}/" "(5) 정리할 지난번 파일들 입니다."
cmdrun "ls -l ${seq_dir_name}*[zl]" "(6) 새로 만든 파일들 입니다."
