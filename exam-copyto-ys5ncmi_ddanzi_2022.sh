#!/bin/sh

FILE_NAME=('221110-09:33:54볼빨간40춘기-문소개웬 트윗.webp'
'221110-12:32:57뉘집개가왈왈거리냐-올해 가을사진 중 최고네요.jpg'
'221110-13:00:57Bishop-전용기 MBC 탑승불허에 외신기자 저는 MBC와 함께 합니다.webp'
'221110-13:23:44보노보노🐙-[단독] 구조 당국 영안실 섭외 수차례 요구…용산구 무대응.webp'
'221111-12:00:08Arbat_St.-내일 결전지, 삼각지 지도 안내입니다.webp'
)

for name in "${FILE_NAME[@]}"
do
	echo "----> rclone copy \"${name}\" ys5ncmi:ddanzi-날짜별-사진갈무리/2022-11/"
	rclone copy "${name}" ys5ncmi:ddanzi-날짜별-사진갈무리/2022-11/
done
