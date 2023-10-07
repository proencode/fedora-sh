#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

if [ "x${imgtype}" = "x" ]; then
	imgtype="webp"
fi
echo "🖍️  ${bbb}이미지 타입 ('${ccc}webp${bbb}' '${ccc}jpg${bbb}' 등) 을 지정하세요. ${mmm}[ ${rrr}그냥 엔터 = ${yyy}${imgtype} ${mmm}]${xxx}"
read a ; if [ "x$a" != "x" ]; then imgtype=$a ; fi
echo "${mmm}[ 이미지 타입 = ${yyy}.${imgtype} ${mmm}]${xxx}"

qqq=""
until [ "x$qqq" = "xxx" ]
do
	cat <<__EOF__

🖍️  ${bbb}이미지 이름을 지정하세요. ${bbb}끝내려면, ${rrr}[ ${yyy}xx ${rrr}] ${bbb} 즉, '${ccc}x 두개${bbb}' 를 입력하세요.${xxx}
__EOF__
	read a
	if [ "x$a" != "x" ] && [ "x$a" != "xxx" ]; then
		echo ""
		echo "${mmm}![ ${ccc}${a} ${mmm}](${yyy}$(echo ${a,,} | sed 's/ /_/g' | sed 's/://g').${imgtype}${mmm})${xxx}"
		echo ""
	fi
done
