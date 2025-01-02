#!/bin/sh

y4=$(date +%Y)
y2=${y4:2:2}
m2=$(date +%m)

echo "----> 당월의 서버 확인: ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/${y4}/${m2}/ /var/base_db/kaosorder2/${y4}/${m2}/"
ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/${y4}/${m2}/ /var/base_db/kaosorder2/${y4}/${m2}/

echo "----> 당월의 백업 디렉토리 확인: ls -l /opt/backup/kaosdb/${y4}/*/${m2}/"
ls -l /opt/backup/kaosdb/${y4}/*/${m2}/

for cegs_base in cadbase emailbase georaebase scanbase
do
	echo "----> 클라우드 백업: rclone ls kaosngc:kaosdb/${y4}/${cegs_base}/${m2}"
	rclone ls kaosngc:kaosdb/${y4}/${cegs_base}/${m2}
done
echo "----> 클라우드 백업: rclone ls kaosngc:kaosdb/${y4}/kaosorder2/${m2}"
rclone ls kaosngc:kaosdb/${y4}/kaosorder2/${m2}
