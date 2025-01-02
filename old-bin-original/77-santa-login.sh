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

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/$(date +%Y)/$(date +%m)/ /var/base_db/kaosorder2/$(date +%Y)/$(date +%m)/

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/$(date +"%Y/%m")/$(date -d '1 day ago' +%d) /var/base_db/kaosorder2/$(date +"%Y/%m")/*$(date -d '1 day ago' +%y%m%d)* #-- 어제자 데이터

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/$(date +"%Y/%m")/$(date +%d) /var/base_db/kaosorder2/$(date +"%Y/%m")/*$(date +%y%m)* #-- 오늘자 데이터

# rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' ./   xxx    kaosco@kaos.kr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ #-- 서버로 보낼때

# rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' --exclude=target/classes kaosco@kaos.kr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ ./ XXX #-- 받을때

for cegs_base in cadbase emailbase georaebase scanbase
do
    y4=$(date +%Y);m2=$(date +%m);echo "----> 받을때: rsync -avzr -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' kaosco@kaos.kr:/var/base/${cegs_base}/${y4}/${m2}/ /var/base/${cegs_base}/${y4}/${m2}/"
    y4=$(date +%Y);m2=$(date +%m);rsync -avzr -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' kaosco@kaos.kr:/var/base/${cegs_base}/${y4}/${m2}/ /var/base/${cegs_base}/${y4}/${m2}/
done

y4=$(date +%Y);m2=$(date +%m);echo "----> 받을때: rsync -avzr -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/ /var/base_db/kaosorder2/${y4}/${m2}/"
y4=$(date +%Y);m2=$(date +%m);rsync -avzr -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/ /var/base_db/kaosorder2/${y4}/${m2}/

__EOF__
