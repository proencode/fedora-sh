#!/bin/bash

mkdir -p cursor-download/old-files

echo "=== [이전] cursor-download/old-files/ ==="
ls -lh cursor-download/old-files/* 2>/dev/null
echo "=== [현재] cursor-download/ ==="
ls -lh cursor-download/*.{exe,dmg,deb} 2>/dev/null

page=$(curl -s https://www.cursor.com/downloads)
cat <<__EOF__
#--- $ { p a g e }
(((${page})))
#--- $ { p a g e }
__EOF__
win_url=$(echo "$page" | grep -oP 'https://[^\"]+windows[^\"]+\\.exe' | head -n1)
cat <<__EOF__
win_url=\$(echo "\$page" | grep -oP 'https://[^\"]+windows[^\"]+\\.exe' | head -n1)
win_url=((($win_url)))
win_url=\$(echo "\$page" | grep -oP 'https://[^\"]+windows[^\"]+\\.exe' | head -n1)
__EOF__

mac_url=$(echo "$page" | grep -oP 'https://[^\"]+mac[^\"]+\\.dmg' | head -n1)
linux_url=$(echo "$page" | grep -oP 'https://[^\"]+linux[^\"]+\\.deb' | head -n1)

echo "다운로드할 OS를 선택하세요:"
echo "1. Windows ($win_url)"
echo "2. macOS   ($mac_url)"
echo "3. Linux   ($linux_url)"
echo "0. 종료"
read -p "번호 입력: " num

case "$num" in
  1) url="$win_url";;
  2) url="$mac_url";;
  3) url="$linux_url";;
  0) echo "종료"; exit 0;;
  *) echo "잘못된 입력"; exit 1;;
esac

echo "#---- curl -L url=\"$url\" -o \"cursor-download/filename=$filename\""
filename=$(basename "$url")
curl -L "$url" -o "cursor-download/$filename"

# 최신 파일만 남기고 나머지는 old-files로 이동
latest_file="cursor-download/$filename"
for f in cursor-download/*.{exe,dmg,deb}; do
  [ "$f" = "$latest_file" ] && continue
  [ -f "$f" ] && mv "$f" cursor-download/old-files/
done

echo "=== [최신] cursor-download/ ==="
ls -lh cursor-download/*.{exe,dmg,deb} 2>/dev/null
echo "=== [이전] cursor-download/old-files/ ==="
ls -lh cursor-download/old-files/* 2>/dev/null
