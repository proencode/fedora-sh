#!/bin/bash

PAGE_URL="https://www.cursor.com/downloads"
HTML=$(curl -s "$PAGE_URL")

# Windows 버전 추출
WIN_VER=$(echo "$HTML" | grep -oE '"windowsX64":\{[^}]+\}' | grep -oE '"version":"[^"]+"' | head -n1 | cut -d':' -f2 | tr -d '"')

# Ubuntu 버전 추출
UBU_VER=$(echo "$HTML" | grep -oE '"ubuntu":\{[^}]+\}' | grep -oE '"version":"[^"]+"' | head -n1 | cut -d':' -f2 | tr -d '"')

echo "=== Cursor 최신 다운로드 버전 ==="
echo "Windows:"
echo "  버전: $WIN_VER"
echo ""
echo "Ubuntu:"
echo "  버전: $UBU_VER"
