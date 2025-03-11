#!/bin/bash

# 인자 개수 확인
if [[ $# -ne 3 ]]; then
  echo "사용법: $0 [파일이름] [시작 줄번호] [끝 줄번호]"
  exit 1
fi

file_name="$1"
start_line="$2"
end_line="$3"

# 인자가 숫자인지 확인
if ! [[ "$start_line" =~ ^[0-9]+$ ]] || ! [[ "$end_line" =~ ^[0-9]+$ ]]; then
  echo "오류: 시작 줄 번호와 끝 줄 번호는 숫자여야 합니다."
  exit 1
fi

# 시작 줄 번호가 끝 줄 번호보다 작은지 확인
if [[ "$start_line" -gt "$end_line" ]]; then
  echo "오류: 시작 줄 번호는 끝 줄 번호보다 작거나 같아야 합니다."
  exit 1
fi

if [[ -z "$file_name" ]]; then
  echo "오류: 현재 디렉토리에 ${file_name} 파일이 없습니다."
  exit 1
fi

# 지정된 줄 번호 범위의 내용 추출 및 more 명령으로 출력
sed -n "${start_line},${end_line}p" "${file_name}" | cat
