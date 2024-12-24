#!/bin/sh

cat <<__EOF__

bbop edit2022 에디터 MVGQHT6HGBvKZYEA3Q 대지대지
git config --global credential.helper store #-- 토큰의 유효기간동안 비번없이 진행한다.
ghp_oHVLCLWM8l9Dt0vM5a5VcYrBw1dIvO3Uhl 대소쿠리

# /usr/bin/mysqldump kaosorder2 -u \${tanon} -p\${modav} -h \$(hostname) | /usr/bin/7za a -p\${solti}\$(date +"%Y%m") -si kaosorder2_\$(date +"%y%m%d-%H%M%S").sql.7z

tanon="qr"
modav="q1"
solti="q2"
ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr

yy="$(date +%Y)";mm="$(date +%m)"; ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 root@kaos.kr ls "/v*/b*/c*/\${yy}/\${mm}/ /v*/b*/e*/\${yy}/\${mm}/ /v*/b*/g*/\${yy}/\${mm}/ /v*/b*/s*/\${yy}/\${mm}/ /v*/b*/k*2/\${yy}/\${mm}/"; echo "#-- (1) 당월 데이터 일자"

yy="$(date +%Y)";mm="$(date +%m)"; ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 root@kaos.kr ls -lh /v*/b*/c*/${yy}/${mm}/20 /v*/b*/e*/${yy}/${mm}/20 /v*/b*/g*/${yy}/${mm}/06 /v*/b*/s*/${yy}/${mm}/24 /v*/b*/k*2/${yy}/${mm}/*${y2}${mm}[2]* ; echo "#-- (2) 지정일의 데이터 목록"

# rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' ./   xxx    kaosco@kaos.kr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ #-- 서버로 보낼때

# rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' --exclude=target/classes kaosco@kaos.kr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ ./ XXX #-- 받을때

__EOF__
