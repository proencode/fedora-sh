#!/bin/bash

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}# ----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | sh
	echo "${bbb}# <~~~~ $1 #-- $2${xxx}"
}
cmdreada_s () {
	echo "${yyy}# ----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
	read -s read_s
	if [ "x$read_s" = "x" ]; then
		exit -1
	fi
}

wavbox=(NONE play-1-pbong.wav play-2-castanets.wav play-3-ddenng.wav play-4-tiiill.wav play-5-gguuuung.wav play-6-ddeeeng.wav)
wavhan=(0=none 1=딩~ 2=캐스터네츠~ 3=뗑- 4=띠일~ 5=데에엥~~ 6=교회_뎅-)
bin_fs="${HOME}/bin/freesound"
ding_val=$1; if [[ "x${ding_val}" < "x1" || "x${ding_val}" > "x6" ]]; then ding_val="4" ; fi
#-- play -q ${bin_fs}/${wavbox[$ding_val]} &
#-- echo "play -q ${wavhan[$ding_val]}"
#-- cmdreada_s "(1) INPUT: port no" "(서버 포트번호 입력시 숫자 표시 안됨)"

cat <<__EOF__

bbop edit2022 에디터 MVGQHT6HGBvKZYEA3Q 대지대지
git config --global credential.helper store #-- 토큰의 유효기간동안 비번없이 진행한다.
ghp_oHVLCLWM8l9Dt0vM5a5VcYrBw1dIvO3Uhl 대소쿠리

# /usr/bin/mysqldump kaosorder2 -u \${tanon} -p\${modav} -h \$(hostname) | /usr/bin/7za a -p\${solti}\$(date +"%Y%m") -si kaosorder2_\$(date +"%y%m%d-%H%M%S").sql.7z

tanon="qr"
modav="q1"
solti="q2"
ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 root@kaos.kr ls "/v*/b*/c*/$(date +"%Y/%m")/ /v*/b*/e*/$(date +"%Y/%m")/ /v*/b*/g*/$(date +"%Y/%m")/ /v*/b*/s*/$(date +"%Y/%m")/ /v*/b*/k*2/$(date +"%Y/%m")/"; echo "#-- (1) 당월 데이터 일자"

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 root@kaos.kr ls -lh /v*/b*/c*/$(date +"%Y/%m")/20 /v*/b*/e*/$(date +"%Y/%m")/20 /v*/b*/g*/$(date +"%Y/%m")/06 /v*/b*/s*/$(date +"%Y/%m")/24 /v*/b*/k*2/$(date +"%Y/%m")/*$(date +"%y%m")[2]* ; echo "#-- (2) 지정일의 데이터 목록"

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/$(date +"%Y/%m")/$(date -d '1 day ago' +%d) /var/base_db/kaosorder2/$(date +"%Y/%m")/*$(date -d '1 day ago' +%y%m%d)* ; echo "#-- (3) 어제자 데이터"

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/$(date +"%Y/%m")/$(date +%d) /var/base_db/kaosorder2/$(date +"%Y/%m")/*$(date +%y%m%d)* ; echo "#-- (4) 오늘자 데이터"

rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' ./   xxx    kaosco@kaos.kr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ ; echo "#-- (5) 서버로 보낼때"

rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' --exclude=target/classes kaosco@kaos.kr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ ./ XXX ; echo "#-- (6) 받을때"

__EOF__
