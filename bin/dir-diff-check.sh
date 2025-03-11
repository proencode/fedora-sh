#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | sh
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdend () {
        echo "${bbb}#--///-- ${mmm}$1${xxx}"
}
cmdreada_s () { #-- cmdreada_s "(1) INPUT: port no" "(입력시 표시 안됨)"
        echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
        read -s reada_s
}
cmdreada () { #-- cmdreada "(2) INPUT: domain name" "호스트 주소 입력"
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"
        read reada
}

if [[ "x$1" = "x" || "x$1" = "x" ]]; then
	echo "$0 [폴더-1: $1] [폴더-2: $2] #-- 비교할 폴더를 지정해야 합니다."
	exit -1
fi
if [[ ! -d "$2" || ! -d "$2" ]]; then
	echo "$0 [폴더-1: $1] [폴더-2: $2] #-- 해당 폴더 이름이 없습니다."
	exit -2
fi
# 비교할 두 디렉토리 경로를 설정합니다.
dir_a=$(echo "$1" | sed 's/\/$//')
dir_b=$(echo "$2" | sed 's/\/$//')

# 파일 정보를 저장할 연관 배열을 선언합니다.
declare -A files

# 디렉토리 A의 파일 정보를 메모리에 저장합니다.
for file_a in "$dir_a"/*; do
  file_name=$(basename "$file_a")
  files["$file_name"]+="a"
done

# 디렉토리 B의 파일 정보를 메모리에 저장합니다.
for file_b in "$dir_b"/*; do
  file_name=$(basename "$file_b")
  files["$file_name"]+="b"
done

# 메모리에 저장된 파일 정보를 순회하며 비교합니다.
for file_name in "${!files[@]}"; do
  file_a="$dir_a/$file_name"
  file_b="$dir_b/$file_name"

  if [[ "${files[$file_name]}" == "ab" || "${files[$file_name]}" == "ba" ]]; then
    # 두 디렉토리에 모두 존재하는 파일은 diff 명령어로 비교합니다.
    echo "${yyy}#-- ${ccc}diff $file_a $file_b${xxx}"
    diff "$file_a" "$file_b"
    echo "${bbb}#// diff $file_a $file_b${xxx}"
  elif [[ "${files[$file_name]}" == "a" ]]; then
    # 디렉토리 A에만 존재하는 파일은 메시지를 출력합니다.
    echo "${bbb}#-- ${ggg}${dir_a}/${file_name} ${mmm}OK, ${rrr}${dir_b}/ ${mmm}NOT FOUND.${xxx}"
  elif [[ "${files[$file_name]}" == "b" ]]; then
    # 디렉토리 B에만 존재하는 파일은 메시지를 출력합니다.
    echo "${bbb}#-- ${rrr}${dir_a}/ ${mmm}NOT FOUND, ${ggg}${dir_b}/${file_name} ${mmm}OK.${xxx}"
  fi
done
