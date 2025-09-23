#1/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | sh
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdYrun () {
        echo "${yyy}#-- ${ccc}$1 ${yyy}#-- 실행하려면, 'y' + Enter: ${bbb}$2${xxx}"
	read a
	if [ "x$a" == "xy" ]; then
		echo "$1" | sh
        	echo "${bbb}#// $1 #-- $2${xxx}"
	else
		echo "${bbb}#// ${rrr}$1 ${bbb}#-- 'y' 아니라서 실행하지 않음.${xxx}"
	fi
}

trash_dir="trash-dir"
if [ ! -d ${trash_dir} ]; then
	cmdrun "mkdir ${trash_dir}" "(0) 지난번 파일들을 옮겨둘 폴더를 만듭니다."
fi

dir_name="00-bada"
seq_dir_name="0a-${dir_name}" #-- 0a-00-bada
cmdrun "ls -l ${seq_dir_name}*[zl]; mv ${seq_dir_name}*[zl] ${trash_dir}" "(1) 지난번 파일들을 ${trash_dir} 폴더로 옮깁니다."

seq_dir_ymdhm_7z="${seq_dir_name}-$(LC_TIME=C date +%y%m%d_%a.%H%M).7z"
cmdYrun "7za a -mx=9 -p ${seq_dir_ymdhm_7z} ${dir_name}/" "(2) ${dir_name} 폴더를 압축합니다."

cmdrun "ls -trl ${dir_name}/ | awk 'NR > 1 { file_type = substr(\$1, 1, 1); printf \"%s %11s %5s %2s %5s %s \", file_type, \$5, \$6, \$7, \$8, \$9; printf \"\\n\" }' > ${seq_dir_ymdhm_7z}.ls-trl" "(3) ${seq_dir_ymdhm_7z}.ls-trl 목록을 만듭니다."

cmdrun "ls -l ${seq_dir_name}*[zl]" "(4) 새로 만든 파일들 입니다."
