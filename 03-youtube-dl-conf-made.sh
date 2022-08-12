#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}#-- $2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 #-- $2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}#-- $2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 #-- $2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}#-- $2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- ${cBlue}$1 #-- $2${cReset}"
	else
		echo "${cGreen}----> ${cRed}press ${cCyan}y${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 #-- $2${cReset}"
	fi
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
#--xx-- zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#--xx-- zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
MEMO="youtuble_dl 유튜브 다운로드를 위한 초기화 작업"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"



if [ "x$(grep Fedora /etc/os-release)" != "x" ]; then
	cat <<__EOF__

${cCyan}#----> 1. For Fedora:
${cGreen}# $(grep Fedora /etc/os-release)
${cCyan}#--------> 1-1 rpmfusion-nonfree-release 설치가 되지 않았으면,
${cGreen}# $(rpm -q rpmfusion-nonfree-release)
${cCyan}#--------> 1-2 다음을 실행해야 합니다.${cReset}
__EOF__
	cat_and_run "sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" "RPM-fusion 리파지토리 구성작업."
	cat <<__EOF__
${cCyan}#--------> 1-3 그리고 나서, youtube-dl 이 설치되지 않았으면,
${cGreen}# $(rpm -q youtube-dl)
${cCyan}#--------> 1-4 다음을 실행해야 합니다.${cReset}
__EOF__
	cat_and_run "sudo dnf -y install youtube-dl libid3tag libmad opusfile sox ffmpeg ffmpeg-devel vlc" "youtube-dl 설치"
	#| q1=$(rpm -q rpmfusion-nonfree-release)
	#| if [ "x$q1" = "x" ]; then
	#| 	cat_and_run "sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" "RPMfusion 리파지토리 구성"
	#| fi
	#| q2=$(rpm -q youtube-dl)
	#| if [ "x$q2" = "x" ]; then
	#| 	cat_and_run "sudo dnf install youtube-dl libid3tag libmad opusfile sox ffmpeg ffmpeg-devel vlc" "youtube-dl 설치"
	#| fi
fi
if [ "x$(grep Ubuntu /etc/os-release)" != "x" ]; then
	cat <<__EOF__
${cCyan}#----> 2. For Ubuntu
${cGreen}# $(grep Ubuntu /etc/os-release)
${cCyan}#--------> 2-1 다음을 실행해야 합니다.${cReset}
__EOF__
	cat_and_run "sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl" "youtube-dl 설치"
	cat_and_run "sudo chmod a+rx /usr/local/bin/youtube-dl" "youtube-dl 을 실행파일로 지정"
	#| cat_and_run "sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl" "youtube-dl 설치"
	#| cat_and_run "sudo chmod a+rx /usr/local/bin/youtube-dl" "youtube-dl 을 실행파일로 지정"
fi


video_DEFAULT="https://youtu.be/1MLnP0OiEkw"
video_url=$1
if [ "x${video_url}" = "x" ]; then
	video_url=${video_DEFAULT}
fi

cat <<__EOF__

----> youtube URL 을 입력하세요. ${cRed}[ ${cYellow} ${video_url} ${cRed}]${cReset}
__EOF__
read a
if [ "x${a}" != "x" ]; then
	video_url=$a
fi


ko_title_DEFAULT="fpeGimp01-김프 초보자가 알아야 할 10 가지"
ko_title=$2
if [ "x${ko_title}" = "x" ]; then
	ko_title="${ko_title_DEFAULT}"
fi

cat <<__EOF__
${cRed}[ ${cYellow}${video_url} ${cRed}]${cReset}

----> 파일 앞부분에 쓸 한글제목을 입력하세요. ${cRed}[ ${cYellow}${ko_title} ${cRed}]${cReset}
__EOF__
read a
if [ "x${a}" != "x" ]; then
	ko_title=$a
fi


download_dir_DEFAULT=${HOME}/bada/Downloads
download_dir=$3
if [ "x${download_dir}" = "x" ]; then
	download_dir=${download_dir_DEFAULT}
fi
if [ ! -d ${download_dir} ]; then
	download_dir=""
fi

cat <<__EOF__
${cRed}[ ${cYellow}${ko_title} ${cRed}]${cReset}

----> 다운로드 폴더를 입력하세요. ${cRed}[ ${cYellow}${download_dir} ${cRed}]${cReset}
__EOF__
read a
if [ "x${a}" != "x" ]; then
	download_dir=$a
fi
if [ "x${download_dir}" = "x" ]; then
	echo "!!!! ${download_dir} 폴더가 없습니다."
	exit -1
fi
if [ ! -d ${download_dir} ]; then
	cat_and_run "mkdir -p ${download_dir}"
fi


ytb_conf_dir=${HOME}/.config/youtube-dl
if [ ! -d ${ytb_conf_dir} ]; then
	cat_and_run "mkdir ${ytb_conf_dir}"
fi
ytb_conf=${ytb_conf_dir}/config

if [ ! -f ${ytb_conf} ]; then
	cat > ${ytb_conf} <<__EOF__
--format '299+140/298+140/137+140/mp4[height<=?4096]+m4a/bestvideo[height<=?4096]+bestaudio/best'
--sub-format 'vtt/ass/srt/best'
--write-sub
--write-auto-sub
--embed-subs
--sub-lang 'en,ko'
--output ${download_dir}/%(title)s-%(id)s.%(ext)s
__EOF__
	cat_and_run "cat ${ytb_conf}"
fi


cat <<__EOF__

# https://ytdl-org.github.io/youtube-dl/download.html

$0 $1 (${video_url})

0... 어떤 자막이 있는지 확인하기
1... 자막 만 다운로드 하기
2... 1.5M .44  .mp3
3...  37M .6   .webm
4...  18M .3   .mp4
5...  31M .34  .flv
6... 8.6M .409 .ogg
7...  31M .192 .mkv
8...  24M .108 .avi

----> [1...8]:
__EOF__
read a ; echo "${cUp}"

ext_name=""
OPTVAL=""
if [ "x${a}" = "x0" ]; then
	OPTVAL="--list-subs"
else
if [ "x${a}" = "x1" ]; then
	OPTVAL="--all-subs --skip-download"
else
if [ "x${a}" = "x2" ]; then
	OPTVAL="-x --audio-format mp3"
else
if [ "x${a}" = "x3" ]; then
	OPTVAL=""
else
if [ "x${a}" = "x4" ]; then
	ext_name="mp4"
	OPTVAL="-f mp4"
else
if [ "x${a}" = "x5" ]; then
	ext_name="flv"
	OPTVAL="-f flv"
else
if [ "x${a}" = "x6" ]; then
	ext_name="ogg"
	OPTVAL="-f ogg"
else
if [ "x${a}" = "x7" ]; then
	ext_name="mkv"
	OPTVAL="-f mkv"
else
if [ "x${a}" = "x8" ]; then
	ext_name="avi"
	OPTVAL="-f avi"
fi
fi
fi
fi
fi
fi
fi
fi
fi
echo "${cRed}[ ${cReset}${a} ${cRed}] ${cYellow}${OPTVAL}${cReset}"

cat_and_run "youtube-dl ${OPTVAL} ${video_url}"
cat_and_run "ls -lh ${download_dir}"
cat_and_run "ls ${download_dir}/*${ext_name}"
cat <<__EOF__

----> 지금 다운로드한 파일이름을 입력하세요. (.${ext_name} 포함)
__EOF__
read down_file

org_name="${ko_title}-${down_file}"
new_title=$(echo "${org_name}" | sed 's/ //g')

echo "#----> mv \"${download_dir}/${down_file}\" \"${download_dir}/${new_title}\" #-- ${video_url}"
cat_and_run "mv \"${download_dir}/${down_file}\" ${download_dir}/${org_name}" "${video_url}"

#--xx-- rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#--xx-- cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
