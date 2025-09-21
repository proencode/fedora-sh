#!/bin/bash

jpgdir=$(echo "$1" | sed 's/\/$//')
echo "#-- (1) FROM .jpg 디렉토리는?: [ $jpgdir ]"
read from_jpg_dir
if [ "x$from_jpg_dir" = "x" ]; then
  from_jpg_dir="$jpgdir"
fi
if [ ! "$from_jpg_dir" ]; then
  echo "#-- ${from_jpg_dir} 디렉토리가 없습니다."
  exit -2
fi
echo "#-- (1) FROM [ ${from_jpg_dir} ]"

webpdir=$(echo "$2" | sed 's/\/$//')
echo "#-- (2) TO .webp 디렉토리는?: [ $webpdir ]"
read to_webp_dir
if [ "x$to_webp_dir" = "x" ]; then
  to_webp_dir="$webpdir"
fi
if [ ! "$to_webp_dir" ]; then
  echo "#-- ${to_webp_dir} 디렉토리가 없습니다."
  exit -4
fi
echo "#-- (2) TO [ ${to_webp_dir} ]"

# smallwebp 디렉토리가 없으면 생성
mkdir -p $to_webp_dir

# myjpg 디렉토리의 모든 .jpg 파일을 .webp로 변환
for file in ${from_jpg_dir}/*.jpg; do
  filename=$(basename "$file" .jpg)
  cwebp.exe "$file" -o "${to_webp_dir}/${filename}.webp"
done

echo "#-- (3) ls -l ${from_jpg_dir}"
ls -l ${from_jpg_dir}
echo "#-- (4) ls -l ${to_webp_dir}"
ls -l ${to_webp_dir}
