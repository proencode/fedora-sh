#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

if [ "x${img_type}" = "x" ]; then
	img_type="webp"
fi
cat <<__EOF__

🖍️  ${bbb}이미지 타입 ('${ccc}webp${bbb}' '${ccc}jpg${bbb}' 등) 을 지정하세요. ${mmm}[ ${rrr}그냥 엔터 = ${yyy}${img_type} ${mmm}]${xxx}
__EOF__
read a ; if [ "x$a" != "x" ]; then img_type=$a ; fi
echo "${mmm}[ 이미지 타입 = ${yyy}.${img_type} ${mmm}]${xxx}"

md_dir=""
if [ "x$1" != "x" ]; then
	md_dir="$1/"
fi
echo "${rrr}ls ${yyy}${md_dir}${xxx}"
ls ${md_dir}
qqq=""
until [ "x$qqq" = "xxx" ]
do
	cat <<__EOF__

🖍️  ${bbb}이미지 이름을 지정하세요. ${bbb}끝내려면, ${rrr}[ ${yyy}xx ${rrr}] ${bbb} 즉, '${ccc}x 두개${bbb}' 를 입력하세요.${xxx}
__EOF__
	read a ; echo ""
	if [ "x$a" != "x" ] && [ "x$a" != "xxx" ]; then
		c=${#a} #-- 문자열의 길이
		img_name=$(echo ${a,,} | sed 's/:/-/g' | sed 's/- /-/g' | sed 's/ /_/g' | sed 's/;//g').${img_type}

		head_name=$(echo ${img_name} | awk -F"-" '{print $1}')
		check_name=$(echo ${img_name} | awk -F"-" '{print $2}' | awk -F".${img_type}" '{print $1}')
		set -f
		words=(${check_name//_/ }) #-- 단어로 분리하기 위해 _ 를 공백으로 바꾼다.
		y_n="y"
		for cnt in "${!words[@]}"
		do
			ww=${words[cnt]}
			if [ "x${words[cnt+1]}" != "x" ]; then ww="${ww}_${words[cnt+1]}"; else y_n="n"; fi
			if [ "x${words[cnt+2]}" != "x" ]; then ww="${ww}_${words[cnt+2]}"; else y_n="n"; fi
			if [ "x${y_n}" = "xy" ]; then
				if [ -f ${md_dir}${ww} ]; then echo "file found"; fi
				echo "${bbb}[$cnt]${xxx} ls -l ${md_dir} | grep --color ${mmm}${ww}${xxx}"
				ls -l ${md_dir} | grep --color ${ww}
		       	fi
		done
		find_file=$(ls -l ${md_dir} | grep --color ${head_name}-${words[0]})
		if [ "x${find_file}" != "x" ]; then
			echo "${mmm}#--------------------------------------------${xxx}"
			ls -l ${md_dir} | grep --color ${head_name}-${words[0]}
		fi

		cat <<__EOF__

${mmm}![ ${ccc}${a} ${mmm}](${yyy}${img_name}${mmm})${xxx}
__EOF__
	fi
done
