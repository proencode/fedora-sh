#!/bin/bash

read_n_echo () {
	k_e=$1
	read_file=$2
	cn=10000
	while read line
	do
		cn=$((cn - 1))
		spcline="${line}          "
		reqmmddyyyy=${spcline:0:10}
		if [[ "x$line" != "xShare This:" ]] && [[ "x$line" != "x이 공유:" ]] && [[
			"x$line" != "xOPEN NOW" ]] && [[ "x$line" != "x지금 열다" ]] && [[
			"x$line" != "xDZone" ]] && [[ "x$line" != "xD존" ]] && [[
			$reqmmddyyyy != "Requested " ]]; then
			if [[ "$line" =~ "일에 요청됨" ]]; then
				#-- 2023년 8월 31일에 요청됨
				yy=$(echo "$line" | awk -F "년 " '{print $1}')
				mm=$(echo "$line" | awk -F "년 " '{print $2}' | awk -F "월 " '{print $1}')
				dd=$(echo "$line" | awk -F "월 " '{print $2}' | awk -F "일에" '{print $1}')
				y2=${yy:(-2)}
				m1="0${mm}" ; m2=${m1:(-2)}
				d1="0${dd}" ; d2=${d1:(-2)}
				echo "24:::$cn:${k_e}=== ${y2}${m2}${d2}-"
			else
				if [ "${k_e}" == "e" ]; then
					if [ "x${line}" != "x" ]; then
						line2str=$(echo ${line} | sed 's/ /_/g' | sed 's/:/-/g' | sed 's/;/./g' | sed 's/,/./g' | sed 's/- /-/g' | sed 's/“//g' | sed 's/”//g' | sed 's/(/./g' | sed 's/)/./g' | sed 's/</./g' | sed 's/>/./g' | sed 's/\[/./g' | sed 's/\]/./g' | sed 's/\//./g' | sed 's/+/./g')
						echo "29:::$cn:d${k_e}=== $line2str"
					fi
				fi
				echo "32:::$cn:${k_e}=== $line"
			fi
		fi
	done < $read_file
}

#>>> kor

if [ "x$1" != "x" ]; then
	file1="$1"
else
	file1="kor-tradepub"
fi

if [ -f ${file1} ]; then
	cat <<__EOF__

#-- \$1='$file1'

__EOF__
	read_n_echo "k" $file1
else
	cat <<__EOF__

#-- \$1='$file1' NOT FOUND.

__EOF__
fi

#<<< kor

#>>> eng

if [ "x$2" != "x" ]; then
	file2="$2"
else
	file2="eng-tradepub"
fi

if [ -f ${file2} ]; then
	cat <<__EOF__

#-- \$2='$file2'

__EOF__
	read_n_echo "e" $file2
else
	cat <<__EOF__

#-- \$2='$file2' NOT FOUND.

__EOF__
fi

#<<< eng

cat <<__EOF__

#-- $ bash $0 $1 $2

__EOF__
