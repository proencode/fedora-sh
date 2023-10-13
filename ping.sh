#!/bin/sh

log_file="zz_ping_list_$(date +'%y%m%d%a-%H%M%S')
echo "$(date +'%y%m%d%a-%H%M%S')" > ${log_file}

for i in {11..199}
do
	ping -c 1 192.168.219.${i} >> ${log_file}
done
grep "시간=" ${log_file}
