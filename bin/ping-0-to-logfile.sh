#!/bin/sh

ifconfig | grep -B1 tm

this_ip="192.168.219"
cat <<__EOF__

----> your ip: [Enter then ${this_ip}]
__EOF__
read a
if [ "x$a" != "x" ]; then
	this_ip=${a}
fi

log_file="zz_ping_list_$(date +'%y%m%d%a-%H%M%S')"
echo "$(date +'%y%m%d%a-%H%M%S')" > ${log_file}

cat <<__EOF__
grep "시간=" ${log_file}; grep "time=" ${log_file} #-- 확인 스크립트.
__EOF__

for i in {11..199}
do
	ping -c 1 ${this_ip}.${i} >> ${log_file}
done
grep "시간=" ${log_file}
grep "time=" ${log_file}
