#!/bin/sh

for fn in "$(rclone ls yosjgc: | grep " -1 " | awk -F" -1 " '{print "yosjgc:"$2}')"
do
	echo "----> ${fn}"
done

echo "----> press Enter:"
read a

for fn in *
do
	new_fn=$(echo ${fn} | sed 's/\[//g' | sed 's/\]//g' | sed 's/(//g' | sed 's/)//g' | sed 's/,/./g' | sed 's/／/-/g' | sed 's/ - /-/g' | sed 's/ /_/g')
	if [ "x$fn" = "x$new_fn" ]; then
		cat <<__EOF__

#-- ---- ---- ----
$(ls -l ${new_fn})
__EOF__
	else
		cat <<__EOF__

#-- ---- ---- ----
$(ls -l "${fn}")

__EOF__
		cat <<__EOF__
mv "${fn}" ${new_fn}
----> press Enter: ['n' = 이름을 바꾸지 않음]
__EOF__
		read a
		if [ "x$a" != "xn" ]; then
			mv "${fn}" ${new_fn}
			ls -l ${new_fn}
		fi
	fi
done
