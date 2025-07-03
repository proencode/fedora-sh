#!/bin/bash

# Cursor 다운로드 페이지에서 HTML 가져오기
PAGE_URL="https://www.cursor.so/downloads"
PAGE_URL="https://www.cursor.com/downloads"
HTML=$(curl -s "$PAGE_URL")
cat <<__EOF__

#---- \${HTML}
${HTML}
#//// \${HTML}
__EOF__
# Windows용 다운로드 링크 및 버전 추출
WIN_LINE=$(echo "$HTML" | grep -iE 'windows.*\.exe' | head -n 1)
cat <<__EOF__

#---- WIN_LINE=\$(echo "\$HTML" | grep -iE 'windows.*\.exe' | head -n 1)

WIN_LINE=\$(echo "----

$HTML

////" | grep -iE 'windows.*\.exe' | head -n 1)

#//// WIN_LINE=\$(echo "\$HTML" | grep -iE 'windows.*\.exe' | head -n 1)

#---- \${WIN_LINE}
${WIN_LINE}
#//// \${WIN_LINE}
__EOF__
WIN_URL=$(echo "$WIN_LINE" | grep -oE 'https://[^\"]+\.exe')
cat <<__EOF__

#---- \${WIN_URL}
${WIN_URL}
#//// \${WIN_URL}
__EOF__
WIN_VER=$(echo "$WIN_URL" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
cat <<__EOF__

#---- \${WIN_VER}
${WIN_VER}
#//// \${WIN_VER}
__EOF__

# Ubuntu용 다운로드 링크 및 버전 추출
UBU_LINE=$(echo "$HTML" | grep -iE 'ubuntu.*\.deb' | head -n 1)
cat <<__EOF__

#---- \${UBU_LINE}
${UBU_LINE}
#//// \${UBU_LINE}
__EOF__
UBU_URL=$(echo "$UBU_LINE" | grep -oE 'https://[^\"]+\.deb')
cat <<__EOF__

#---- \${UBU_URL}
${UBU_URL}
#//// \${UBU_URL}
__EOF__
UBU_VER=$(echo "$UBU_URL" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
cat <<__EOF__

#---- \${UBU_VER}
${UBU_VER}
#//// \${UBU_VER}
__EOF__

echo "=== Cursor 최신 다운로드 버전 ==="
echo "Windows:"
echo "  버전: $WIN_VER"
echo "  다운로드: $WIN_URL"
echo ""
echo "Ubuntu:"
echo "  버전: $UBU_VER"
echo "  다운로드: $UBU_URL"
