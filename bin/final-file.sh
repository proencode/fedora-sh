#!/bin/bash

# 인자가 하나도 없으면 사용법을 출력
if [ -z "$1" ]; then
  echo "사용법: $0 <파일 패턴 또는 디렉토리/파일 패턴>"
  echo "예시: $0 mydir/wanted_file-*"
  echo "예시: $0 *.log"
  exit 1
fi

# ls -tr 로 파일을 정렬하고 head -n 1 로 가장 최근 파일 하나만 가져옴
# 에러 발생 시 (파일이 없거나 권한 문제 등) 빈 문자열을 출력할 수 있음
ls -tr "$1" 2>/dev/null | head -n 1
