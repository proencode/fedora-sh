#!/bin/bash

# 스크립트 사용법 안내
if [ "$#" -eq 0 ]; then
    echo "사용법: sh refresh_version_date.sh [다운로드한 파일 이름...]"
    echo "예시: sh refresh_version_date.sh CursorUserSetup-x64-1.1.6.exe WinSCP-6.5.1-Setup.exe"
    exit 1
fi

# downloads.html 파일 경로 (스크립트와 같은 디렉토리에 있다고 가정)
HTML_FILE="downloads.html"

# 파일이 존재하는지 확인
if [ ! -f "$HTML_FILE" ]; then
    echo "오류: '$HTML_FILE' 파일을 찾을 수 없습니다. 스크립트와 같은 디렉토리에 있는지 확인하세요."
    exit 1
fi

# 임시 파일 생성
TMP_FILE="${HTML_FILE}.tmp"

# 현재 날짜 및 요일 가져오기 (예: 25-06-28_토)
CURRENT_DATE=$(date +"%y-%m-%d_%a")

# HTML 파일 내용을 읽어와서 변경할 내용을 저장할 변수
UPDATED_HTML_CONTENT=$(cat "$HTML_FILE")

# 각 프로그램 이름에 대한 고유 식별자 및 URL 매핑 (___프로그램명___ 부분)
# 이 부분은 각 URL에 맞게 정확히 설정되어야 합니다.
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
PROGRAM_MAP["msys2"]="___rsync___" # msys2는 rsync 예시이므로 맞춰서 수정

# 입력된 각 파일 이름에 대해 처리
for FILENAME in "$@"; do
    # 파일 이름에서 프로그램 이름 및 버전 추출 시도
    # 이 부분은 실제 파일 이름 형식에 따라 유연하게 조정해야 합니다.
    # 복잡한 정규식 대신, 일반적인 패턴을 찾습니다.

    # Cursor: CursorUserSetup-x64-1.1.6.exe
    if [[ "$FILENAME" =~ CursorUserSetup-x64-([0-9]+\.[0-9]+\.[0-9]+)\.exe ]]; then
        PROG_NAME="cursor"
        VERSION="${BASH_REMATCH[1]}"
    # GIMP: gimp-3.0.4-setup.exe
    elif [[ "$FILENAME" =~ gimp-([0-9]+\.[0-9]+\.[0-9]+)-setup\.exe ]]; then
        PROG_NAME="gimp"
        VERSION="${BASH_REMATCH[1]}"
    # WinSCP: WinSCP-6.5.1-Setup.exe (버전 정보가 파일명 중간에 있을 수 있음)
    elif [[ "$FILENAME" =~ WinSCP-([0-9]+\.[0-9]+\.[0-9]+)-Setup\.exe ]]; then
        PROG_NAME="winscp"
        VERSION="${BASH_REMATCH[1]}"
    # 7-Zip: 7z2409-x64.exe (버전이 다르게 표시될 수 있음)
    elif [[ "$FILENAME" =~ 7z([0-9]+)\.exe ]]; then
        PROG_NAME="7zip"
        VERSION="${BASH_REMATCH[1]}"
        # 7zip 버전 표기법에 따라 2409 -> 24.09 등으로 변환 필요하면 여기에 추가
    # Git: Git-2.45.1-64-bit.exe
    elif [[ "$FILENAME" =~ Git-([0-9]+\.[0-9]+\.[0-9]+)- ]]; then
        PROG_NAME="git-bash"
        VERSION="${BASH_REMATCH[1]}"
    # PuTTY: putty-0.83-installer.msi
    elif [[ "$FILENAME" =~ putty-([0-9]+\.[0-9]+)- ]]; then
        PROG_NAME="putty"
        VERSION="${BASH_REMATCH[1]}"
    # KeePassXC: KeePassXC-2.7.10-Win64.exe
    elif [[ "$FILENAME" =~ KeePassXC-([0-9]+\.[0-9]+\.[0-9]+)- ]]; then
        PROG_NAME="keepassxc"
        VERSION="${BASH_REMATCH[1]}"
    # VirtualBox: VirtualBox-7.0.18-162029-Win.exe (Build 번호까지 포함)
    elif [[ "$FILENAME" =~ VirtualBox-([0-9]+\.[0-9]+\.[0-9]+-[0-9]+)-Win\.exe ]]; then
        PROG_NAME="virtualbox"
        VERSION="${BASH_REMATCH[1]}"
    # MSVC Redist: vc_redist.x64.exe (버전 정보가 파일명에 없을 수 있음. 이 경우 수동 입력 필요)
    # 현재 파일명만으로는 버전 추출이 어려우므로, 이 부분은 유의해야 합니다.
    elif [[ "$FILENAME" =~ vc_redist ]]; then
        PROG_NAME="vc_red"
        # VC Redist는 파일명에서 버전 추출이 어려울 수 있으므로, 수동으로 입력하거나 
        # 사용자가 직접 URL의 버전을 업데이트해야 할 수 있습니다.
        # 여기서는 단순히 파일명에 'vc_redist'가 있으면 해당 링크를 대상으로 설정합니다.
        # 버전 정보는 기존 URL의 것을 그대로 사용하거나, 스크립트 실행 시 수동으로 입력받는 로직 추가 가능.
        # 예시: sh refresh_version_date.sh vc_redist.x64.exe 14.44.35200.0
        if [[ "$#" -ge 2 && "$FILENAME" == "$1" ]]; then # 첫번째 인자가 vc_redist이고 두번째 인자가 버전이라면
             VERSION="$2"
             shift # vc_redist 파일명 처리 후 다음 인자도 파일명으로 인식하도록
        else
            echo "경고: 'vc_redist' 파일은 파일명에서 버전 추출이 어렵습니다. URL을 수동으로 업데이트해야 할 수 있습니다."
            continue # 다음 파일로 넘어감
        fi
    # MSYS2 rsync: rsync-3.4.1-1-x86_64.pkg.tar.zst
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

    # HTML 내용 업데이트
    # sed 명령어로 특정 URL 라인에서 기존 버전/날짜 정보를 찾아 새 정보로 교체
    # 주의: sed는 정규식을 사용하므로 특수 문자 이스케이프에 유의해야 합니다.
    # PROGRAM_MAP의 IDENTIFIER를 사용하여 고유한 매칭 패턴을 만듭니다.
    # 정규식 패턴: (IDENTIFIER)___([^_]+)___([^_]+)"
    # 교체 패턴:   \1${VERSION}___${CURRENT_DATE}\""
    # `|`를 sed 구분자로 사용하여 URL에 `/`가 있어도 문제 없도록 함.
    UPDATED_HTML_CONTENT=$(echo "$UPDATED_HTML_CONTENT" | \
        sed "s|${IDENTIFIER}___[0-9A-Za-z\.\-]+___[0-9\-A-Za-z_가-힣]+|\$IDENTIFIER${VERSION}___${CURRENT_DATE}|g")

    # 여기서 '$IDENTIFIER'가 아니라 실제 IDENTIFIER 변수 값으로 치환되도록 수정
    # 'eval'을 사용하거나, 변수 치환을 먼저 한 뒤 sed에 전달
    # 또는 sed -i 옵션 사용 시 변수를 직접 삽입 가능
    # safer approach for sed:
    OLD_PATTERN="${IDENTIFIER}___[0-9A-Za-z\.\-]+___[0-9\-A-Za-z_가-힣]+"
    NEW_VALUE="${IDENTIFIER}${VERSION}___${CURRENT_DATE}"
    
    # URL 줄을 찾아서 해당 부분만 교체
    # '\|'를 구분자로 사용하고, \n을 포함한 다중 라인 매칭을 위해 -z 옵션과 함께 사용
    UPDATED_HTML_CONTENT=$(echo "$UPDATED_HTML_CONTENT" | sed "s|\\(${IDENTIFIER}\)___[^_]*___[^\\\"]*\"|\\1${VERSION}___${CURRENT_DATE}\"|")

    # VCRedist처럼 view=msvc-170?마=___vc_red___14.44.35200.0___25-06-28_토 처럼 ?마= 로 시작하는 경우 처리
    # 기존 URL에 ?버전= 으로 시작하지 않고 ?마= 로 시작하는 경우를 위한 보정
    # if [[ "$PROG_NAME" == "vc_red" ]]; then
    #     UPDATED_HTML_CONTENT=$(echo "$UPDATED_HTML_CONTENT" | sed "s|?마=\\(${IDENTIFIER}\)___[^_]*___[^\\\"]*\"|?마=\\1${VERSION}___${CURRENT_DATE}\"|")
    # fi

done # for FILENAME in "$@"; do

# 업데이트된 내용을 HTML 파일에 덮어쓰기
echo "$UPDATED_HTML_CONTENT" > "$HTML_FILE"

echo "HTML 파일 '$HTML_FILE'의 버전 정보가 업데이트되었습니다."
