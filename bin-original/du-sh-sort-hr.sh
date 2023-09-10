#!/bin/sh

hhh=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2) #-- 230908

# cat <<__EOF__
# ${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
# __EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

if [ "x$1" = "x" ]; then
	curr_cnt=15
else
	curr_cnt=$1
fi

echo "----> 표시할 줄수: [${curr_cnt}]"
read cnt ; echo "${uuu}"
if [ "x${cnt}" = "x" ]; then
	cnt=${curr_cnt}
fi
echo "${rrr}[ ${yyy}${cnt} ${rrr}]${xxx}"

if [ "x$2" = "x" ]; then
	curr_dir="$(pwd)"
else
	curr_dir="$2"
fi

echo "----> 조사하는 디렉토리: [${curr_dir}]"
read search_dir ; echo "${uuu}"
if [ "x${search_dir}" = "x" ]; then
	search_dir=${curr_dir}
fi
echo "${rrr}[ ${yyy}${search_dir} ${rrr}]${xxx}"

if [ "x$3" = "x" ]; then
	curr_savelog="$(pwd)/zz00logs"
else
	curr_savelog="$3"
fi

echo "----> 로그 담는 디렉토리: [${curr_savelog}]"
read log_save ; echo "${uuu}"
if [ "x${log_save}" = "x" ]; then
	log_save=${curr_savelog}
fi
echo "${rrr}[ ${yyy}${log_save} ${rrr}]${xxx}"

if [ ! -d "${log_save}" ]; then
	echo "mkdir -p ${log_save} #-- 로그를 담는 디렉토리를 만듭니다."
	mkdir -p ${log_save} #-- 로그를 담는 디렉토리를 만듭니다."
fi

now=$(date +"%H:%M:%S")
dir_name=zz.${log_save}-$(date +"%y%m%d%a-%H%M%S")
du_sh_sort_hr_file=${log_save}/$(echo ${dir_name} | sed 's/\///' | sed 's/\//_/g')-$(date +"%y%m%d%a-%H%M%S")


MEMO="[줄수=${cnt}] [시작위치=${search_dir}] [파일명=${du_sh_sort_hr_file}]"

cat <<__EOF__
${mmm}>>>>>>>>>>${ggg} $0 ${mmm}||| ${ccc}${MEMO} ${mmm}>>>>>>>>>>${bbb}
__EOF__
ls ${log_save}


echo "----> cd ${search_dir} ; sudo du -sh * .??* | sort -hr > ${du_sh_sort_hr_file}"
cd ${search_dir} ; sudo du -sh * .??* | sort -hr > ${du_sh_sort_hr_file}
echo "----> echo -e \"\${xxx}\$(head -\${cnt} \${du_sh_sort_hr_file})"
echo -e "${xxx}$(head -${cnt} ${du_sh_sort_hr_file})"


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${rrr}<<<<<<<<<<${bbb} $0 ${rrr}||| ${mmm}${MEMO} ${rrr}<<<<<<<<<<${xxx}
__EOF__
