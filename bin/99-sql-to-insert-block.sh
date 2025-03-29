#!/bin/bash

echo "#------------- big to cut made ------------"

input_file="big25-kaosorder2_250325-201001.sql" # 입력 SQL 파일 이름
output_file="cut25-kaosorder2_250325-201001.sql" # 출력 파일 이름

awk '/INSERT INTO/ {flag=1} flag; /;/ {flag=0}' "$input_file" > "$output_file"

#--

input_file="big28-kaosorder2_250328-201001.sql" # 입력 SQL 파일 이름
output_file="cut28-kaosorder2_250328-201001.sql" # 출력 파일 이름

awk '/INSERT INTO/ {flag=1} flag; /;/ {flag=0}' "$input_file" > "$output_file"

echo "#============= big to cut made ============"
echo "#------------- cut to divide-comma made ------------"

input_file="cut25-kaosorder2_250325-201001.sql" # 입력 SQL 파일 이름
output_file="divide25-kaosorder2_250325-201001.sql" # 출력 파일 이름

## awk '{gsub(/\),\(/, "),\\n("); print}' "$input_file" > "$output_file"
sed 's/),(/),\n(/g' "$input_file" > "$output_file"

#--

input_file="cut28-kaosorder2_250328-201001.sql" # 입력 SQL 파일 이름
output_file="divide28-kaosorder2_250328-201001.sql" # 출력 파일 이름

## awk '{gsub(/\),\(/, "),\\n("); print}' "$input_file" > "$output_file"
sed 's/),(/),\n(/g' "$input_file" > "$output_file"

echo "#============= cut to divide=comma made ============"
echo "#------------- divide to head-tail made ------------"

input_file="divide25-kaosorder2_250325-201001.sql" # 입력 파일 이름
output_file="headtail25-kaosorder2_250325-201001.sql" # 출력 파일 이름

awk '
  /^INSERT INTO/ {
    table_name = $3;
    gsub(/`/, "", table_name); # 테이블 이름에서 ` 문자 제거
    gsub(/\(/, "", table_name); # 테이블 이름에서 ( 문자 제거
    prefix = table_name "---";
  }
  {
    print prefix $0 "---25";
  }
' "$input_file" > "$output_file"

#--

input_file="divide28-kaosorder2_250328-201001.sql" # 입력 파일 이름
output_file="headtail28-kaosorder2_250328-201001.sql" # 출력 파일 이름

awk '
  /^INSERT INTO/ {
    table_name = $3;
    gsub(/`/, "", table_name); # 테이블 이름에서 ` 문자 제거
    gsub(/\(/, "", table_name); # 테이블 이름에서 ( 문자 제거
    prefix = table_name "---";
  }
  {
    print prefix $0 "---28";
  }
' "$input_file" > "$output_file"

echo "#============= divide to head=tail made ============"
echo "#------------- head-tail to merge-sort made ------------"

input1_file="headtail25-kaosorder2_250325-201001.sql" # 입력 파일 이름
input2_file="headtail28-kaosorder2_250328-201001.sql" # 입력 파일 이름
output_file="merge-sort-kaosorder2_$(date +%y%m%d-%H%M).sql" # 출력 파일 이름

cat ${input1_file} ${input2_file} | sort > ${output_file}

ls -l

echo "#============= head=tail to merge=sort made ============"
