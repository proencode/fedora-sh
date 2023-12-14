#!/bin/sh

# ls -l 명령어로 파일 정보 가져오기, awk를 사용하여 파일 크기 추출
file_sizes=$(ls -l | awk '{sum += $5} END {print sum}')

# 결과 출력
totsiz=$(printf "%'.d\n" $file_sizes) #-- 천 (1000) 의 자리마다 콤마를 넣어 표시한다.
echo "파일 크기 합계: $totsiz 바이트"
