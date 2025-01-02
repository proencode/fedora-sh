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

for i in {11..199}
do
	ping -c 1 ${this_ip}.${i}  | grep "시간=" &
	ping -c 1 ${this_ip}.${i}  | grep "time=" &
done
echo "----> press Enter:"
read a
