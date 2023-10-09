#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

if [ "x${img_type}" = "x" ]; then
	img_type="webp"
fi
cat <<__EOF__

🖍️  ${bbb}이미지 타입 ('${ccc}webp${bbb}' '${ccc}jpg${bbb}' 등) 을 지정하세요. ${mmm}[ ${bbb}그냥 엔터 = ${yyy}${img_type} ${mmm}]${xxx}
__EOF__
read a ;
if [ "x$a" != "x" ]; then
	img_type=$a
fi
echo "" ; echo "${uuu}   ${rrr}[ ${bbb}이미지 타입 = ${ccc}.${img_type} ${rrr}]${xxx}"

md_dir=""
if [ "x$1" != "x" ]; then
	md_dir="$1/"
fi
echo "${bbb}ls ${md_dir}${xxx}"

arg2_fig=""
if [ "x$2" != "x" ]; then
	arg2_fig="$2"
fi

ls ${md_dir}
typing_fig_name=""
until [ "x$typing_fig_name" = "xxx" ]
do
	cat <<__EOF__

🖍️  ${bbb}이미지 이름을 지정하세요. ${bbb}끝내려면, ${rrr}[ ${yyy}xx ${rrr}] ${bbb} 즉, '${ccc}x 두개${bbb}' 를 입력하세요.${xxx}
__EOF__
	if [ "x$arg2_fig" != "x" ]; then
		echo "   ${mmm}[ ${bbb}그냥 엔터 = ${yyy}${arg2_fig} ${mmm}]${xxx}";
	fi
	read typing_fig_name
	if [ "x$typing_fig_name" = "x" ] && [ "x$arg2_fig" != "x" ]; then
		typing_fig_name="${arg2_fig}"
	fi
	echo "" ; echo "${uuu}   ${rrr}[ ${ccc}${typing_fig_name} ${rrr}]${xxx}"
	arg2_fig="" #-- 처음 한번만 사용한다.
	if [ "x$typing_fig_name" != "x" ] && [ "x$typing_fig_name" != "xxx" ]; then
		c=${#typing_fig_name} #-- 문자열의 길이
		img_name=$(echo ${typing_fig_name,,} | sed 's/:/-/g' | sed 's/- /-/g' | sed 's/ /_/g' | sed 's/;//g').${img_type}
		echo "${mmm}![ ${ccc}${typing_fig_name} ${mmm}](${yyy}${img_name}${mmm})${xxx}"

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
				echo "${mmm}![ ${ccc}${typing_fig_name} ${mmm}](${yyy}${head_name}-${ww}.${img_type}${mmm})${xxx}"
				x=$(ls -l ${md_dir} | grep ${ww})
				if [ "x$x" != "x" ]; then
					#echo "${bbb}[$cnt]${xxx} ls -l ${md_dir} | grep --color ${ww}"
					ls -l ${md_dir} | grep --color ${ww}
				fi
		       	fi
		done
#		find_file=$(ls -l ${md_dir} | grep --color ${head_name}-${words[0]})
#		if [ "x${find_file}" != "x" ]; then
#			echo "${mmm}#--------------------------------------------${xxx}"
#			ls -l ${md_dir} | grep --color ${head_name}-${words[0]}
#		fi
#
#		cat <<__EOF__
#
#__EOF__
	fi
done
