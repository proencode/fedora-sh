#!/bin/bash

# Windows용 Cursor 다운로드 URL
WIN_URL="https://downloads.cursor.com/production/979ba33804ac150108481c14e0b5cb970bda3266/win32/x64/user-setup/CursorUserSetup-x64-1.1.3.exe"

# 파일명에서 버전 추출 (예: CursorUserSetup-x64-1.1.3.exe → 1.1.3)
WIN_VER=$(echo "$WIN_URL" | grep -oE 'CursorUserSetup-x64-[0-9]+\.[0-9]+\.[0-9]+\.exe' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')

echo "=== Cursor 최신 다운로드 버전 (Windows) ==="
echo "버전: $WIN_VER"
echo "다운로드: $WIN_URL"
