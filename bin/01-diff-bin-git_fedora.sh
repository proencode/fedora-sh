#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdend () {
        echo "${bbb}#--///-- ${mmm}$1${xxx}"
}

			
temp_file="temp-$(date +%y%m%d-%H%M%S)"
from_dir="git-projects/fedora-sh/bin"
to_dir="bin"

cmdrun "cd ~/git-projects/fedora-sh/; git status ; git pull; git ll -1; cd -" "최근의 bin 가져오기"
echo "${yyy}#-- ${ccc}Press Enter${bbb}: (변경 사항이 있으면, 여기서 중단하고 마무리 해 줘야 합니다.)${xxx}"
read a
echo "${bbb}#// Press Enter: (변경 사항이 있으면, 여기서 중단하고 마무리 해 줘야 합니다.)${xxx}"

ls -p ~/${to_dir}/ | grep -v '/$' | while read each_file_name #-- 파일 이름만 한개씩 가져오기
do
	name_str=$(echo ${each_file_name} | sed 's/ /\\ /g')
	if [ ! -f ~/${from_dir}/${name_str} ]; then
        echo "${ggg}#-- ${ggg}~/${from_dir}/${name_str} ${ggm}#-- ${mmm}파일이 없음${xxx}"
	else
		diff ~/${from_dir}/${name_str} ~/${to_dir}/${name_str} > ${temp_file}
		if [ "x$(du ${temp_file} | awk '{print $1}')" == "x0" ]; then
   	     echo "${ggg}#-- ${ggg}${name_str} ${ggg}#-- ${ggg}일치함${xxx}"
		else
			cmdrun "diff ~/${from_dir}/${name_str} ~/${to_dir}/${name_str}; ls -l ~/${from_dir}/${name_str} ~/${to_dir}/${name_str}" "${name_str} 비교"
		fi
	fi
done
cmdrun "rm -f ${temp_file}" "임시파일 삭제"
cmdend "${0}"
#--
#--
#--
