#!/bin/bash

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
	echo "${yyy}#-- ${bbb}$1 #-- $2${xxx}"
}
cmdcont () {
	echo -e "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2\n#--${mmm}Enter ${ggg}to continue${xxx}:"
	read a ; echo "${uuu}"; echo "$1" | bash
	echo "${yyy}#-- ${bbb}$1 #-- $2${xxx}"
}
ALL_INSTALL="n"
cmdyes () {
	echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | bash ; echo "${yyy}#-- ${bbb}$1 #-- $2${xxx}"
	else
		echo "${yyy}#-- ${rrr}press ${ccc}'${yyy}y${ccc}'${rrr} or Enter${xxx}:"
		read a; echo "${uuu}"
		if [ "x$a" = "xy" ]; then
			echo "${rrr}-OK-${xxx}"; echo "$1" | bash
		else
			echo "${rrr}[ ${bbb}$1 ${rrr}] ${mmm}<.... 명령을 실행하지 않습니다.${xxx}"
		fi
	fi
}
wavbox=(NONE play-1-pbong.wav play-2-castanets.wav play-3-ddenng.wav play-4-tiiill.wav play-5-gguuuung.wav play-6-ddeeeng.wav)
wavhan=(0=none 1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회_뎅-)
bin_fs="${HOME}/bin/freesound"
if [ ! -d ${bin_fs} ]; then
	echo "${rrr}#-- ${ccc}${bin_fs} ${mmm}디렉토리가 없습니다.${xxx}"
	play -q ${bin_fs}/${wavbox[ 3 ]} -t alsa & #-- 3=뗅-
	#-- -t alsa 출처: https://github.com/floere/playa/issues/6
	exit -1
fi

#----

echo "${lll}BLACK//// ${rrr}RED//// ${ggg}GREEN//// ${yyy}RED//// ${bbb}BLUE//// ${mmm}MAGENTA//// ${ccc}CYAN//// ${www}WHITE//// ${xxx}XXX////"

#----

play -q ${bin_fs}/${wavbox[ 2 ]} -t alsa & #-- 2=캐스터네츠~
