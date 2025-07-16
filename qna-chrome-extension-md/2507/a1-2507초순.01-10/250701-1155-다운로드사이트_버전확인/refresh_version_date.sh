#!/bin/bash

# 스크립트 사용법 안내
if [ "$#" -eq 0 ]; then
    echo "사용법: sh refresh_version_date.sh [다운로드한 파일 이름...]"
    echo "예시: sh refresh_version_date.sh CursorUserSetup-x64-1.1.6.exe WinSCP-6.5.2-Setup.exe"
    exit 1
fi

# downloads.html 파일 경로 (스크립트와 같은 디렉토리에 있다고 가정)
HTML_FILE="downloads.html"

# 파일이 존재하는지 확인
if [ ! -f "$HTML_FILE" ]; then
    echo "오류: '$HTML_FILE' 파일을 찾을 수 없습니다. 스크립트와 같은 디렉토리에 있는지 확인하세요."
    exit 1
fi

# 현재 날짜 및 요일 가져오기 (예: 25-07-01_화)
CURRENT_DATE=$(date +"%y-%m-%d_%a")

# 각 프로그램 이름에 대한 고유 식별자 및 URL 매핑 (___프로그램명___ 부분)
declare -A PROGRAM_MAP
PROGRAM_MAP["cursor"]="___cursor___"
PROGRAM_MAP["virtualbox"]="___VirBox___"
PROGRAM_MAP["gimp"]="___gimp___"
PROGRAM_MAP["winscp"]="___winscp___"
PROGRAM_MAP["7zip"]="___7zip___"
PROGRAM_MAP["vc_red"]="___vc_red___"
PROGRAM_MAP["git-bash"]="___git-bash___"
PROGRAM_MAP["keepassxc"]="___keepassxc___"
PROGRAM_MAP["putty"]="___PuTTY___"
PROGRAM_MAP["msys2"]="___msys2___" # msys2는 rsync 예시이므로 맞춰서 수정

# 입력된 각 파일 이름에 대해 처리
for FILENAME in "$@"; do
    PROG_NAME=""
    VERSION=""

    # 파일 이름에서 프로그램 이름 및 버전 추출 시도
    # 각 파일 이름 형식에 맞는 정규식 사용
    if [[ "$FILENAME" =~ CursorUserSetup-x64-([0-9]+\.[0-9]+\.[0-9]+)\.exe ]]; then
        PROG_NAME="cursor"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ gimp-([0-9]+\.[0-9]+\.[0-9]+)-setup\.exe ]]; then
        PROG_NAME="gimp"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ WinSCP-([0-9]+\.[0-9]+\.[0-9]+)-Setup\.exe ]]; then
        PROG_NAME="winscp"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ 7z([0-9]+)\.exe ]]; then
        PROG_NAME="7zip"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ Git-([0-9]+\.[0-9]+\.[0-9]+)- ]]; then
        PROG_NAME="git-bash"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ putty-([0-9]+\.[0-9]+)- ]]; then
        PROG_NAME="putty"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ KeePassXC-([0-9]+\.[0-9]+\.[0-9]+)- ]]; then
        PROG_NAME="keepassxc"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ VirtualBox-([0-9]+\.[0-9]+\.[0-9]+-[0-9]+)-Win\.exe ]]; then
        PROG_NAME="virtualbox"
        VERSION="${BASH_REMATCH[1]}"
    elif [[ "$FILENAME" =~ vc_redist ]]; then
        PROG_NAME="vc_red"
        # vc_redist는 다음 인자로 버전이 제공되었다고 가정
        if [[ "$#" -ge 2 && "$FILENAME" == "$1" ]]; then
             VERSION="$2"
             shift # vc_redist 파일명 처리 후 다음 인자도 파일명으로 인식하도록
        else
            echo "경고: '$FILENAME'에 대한 버전 정보를 추출할 수 없습니다. 'refresh_version_date.sh $FILENAME [버전]' 형식으로 수동으로 버전을 제공하거나 HTML을 직접 업데이트해야 합니다."
            continue # 다음 파일로 넘어감
        fi
    elif [[ "$FILENAME" =~ rsync-([0-9]+\.[0-9]+\.[0-9]+-[0-9]+)- ]]; then
        PROG_NAME="msys2"
        VERSION="${BASH_REMATCH[1]}"
    else
        echo "경고: '$FILENAME'에 대한 프로그램 이름 또는 버전을 추출할 수 없습니다. 스크립트 내의 정규식을 확인하거나 수동으로 업데이트해주세요."
        continue
    fi

    # 프로그램 매핑에서 고유 식별자 가져오기
    IDENTIFIER="${PROGRAM_MAP[$PROG_NAME]}"
    if [ -z "$IDENTIFIER" ]; then
        echo "경고: '$PROG_NAME'에 대한 내부 식별자를 찾을 수 없습니다. 스크립트를 확인해주세요."
        continue
    fi

    echo "업데이트 중: $FILENAME -> 프로그램: $PROG_NAME, 버전: $VERSION, 날짜: $CURRENT_DATE"

    # HTML 파일에서 해당 URL 라인을 직접 수정
    # sed 명령의 정규식을 수정하여 호환성 높임.
    # `[^"]*`는 큰따옴표(“)가 아닌 모든 문자를 의미.
    # 임시 파일로 작성 후 원본으로 이동하는 가장 안전한 방식.
    sed "s|\\(${IDENTIFIER}\\)___[^_]*___[^\\\"]*\"|\\1${VERSION}___${CURRENT_DATE}\"|" "$HTML_FILE" > "$HTML_FILE.tmp" && mv "$HTML_FILE.tmp" "$HTML_FILE"

done # for FILENAME in "$@"; do

echo "HTML 파일 '$HTML_FILE'의 버전 정보가 업데이트되었습니다."
