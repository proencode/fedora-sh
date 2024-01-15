#!/bin/sh

day_ago=""
echo "----> [Enter] 또는 0=오늘, 1=어제, 2=그제, ..."
read a
if [ "x$a" = "x" ] || [ $a -lt 1 ]; then
	grep_date=$(date +%y%m%d)
	echo "$(date +%y%m%d%a)"
else
	b="${a} day ago"
	if [ $a -lt 31 ]; then
		grep_date=$(date -d "${a} day ago" +%y%m%d)
		echo "$(date -d "${a} day ago" +%y%m%d%a)"
	else
		grep_date=$(date -d "31 day ago" +%y%m%d)
		echo "$(date -d "31 day ago" +%y%m%d%a)"
	fi
fi

for base in cadbase emailbase georaebase scanbase
do
	echo "----> rclone lsl kaosngc:kaosdb/$(date +%Y)/${base}/$(date +%m)/ | grep --color \" ${grep_date}-\""
	rclone lsl kaosngc:kaosdb/$(date +%Y)/${base}/$(date +%m)/ | grep --color " ${grep_date}-"
done

for base in  kaosorder2
do
	echo "----> rclone lsl kaosngc:kaosdb/$(date +%Y)/${base}/$(date +%m)/ | grep --color \"_${grep_date}\-\""
	rclone lsl kaosngc:kaosdb/$(date +%Y)/${base}/$(date +%m)/ | grep --color "_${grep_date}-"
done
