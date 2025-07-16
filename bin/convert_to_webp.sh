#!/bin/bash

# cwebp 명령의 품질 설정 (0-100)
QUALITY=75

# 이미지 파일 확장자 목록
EXTENSIONS=("jpeg" "jpg" "png" "JPG" "JPEG" "PNG")

# 스크립트 실행 함수
process_images() {
    local dir="$1"
    echo "Processing directory: $dir"

    for ext in "${EXTENSIONS[@]}"; do
        # 현재 디렉토리에서 해당 확장자를 가진 이미지 파일 찾기
        find "$dir" -maxdepth 1 -type f -iname "*.${ext}" | while read -r filepath; do
            filename=$(basename -- "$filepath")
            dirname=$(dirname -- "$filepath")
            base="${filename%.*}" # 확장자를 제외한 파일 이름

            output_filepath="${dirname}/${base}.webp"

            echo "Converting: $filepath to $output_filepath"
            cwebp -q "$QUALITY" "$filepath" -o "$output_filepath"

            if [ $? -eq 0 ]; then
                echo "Successfully converted $filename"
            else
                echo "Failed to convert $filename"
            fi
        done
    done

    # 하위 디렉토리 재귀적으로 처리
    for subdir in "$dir"/*/; do
        if [ -d "$subdir" ]; then
            process_images "$subdir"
        fi
    done
}

# 스크립트 실행 시작
# 현재 디렉토리부터 시작하려면 아래 줄을 주석 해제하고, 특정 디렉토리부터 시작하려면 경로를 지정하세요.
# process_images "." # 현재 디렉토리부터 시작

# 예시: 특정 디렉토리부터 시작하려면 아래와 같이 사용하세요.
# process_images "/home/사용자명/Pictures"
# process_images "/path/to/your/image/folder"

# 사용법 안내
if [ -z "$1" ]; then
    echo "Usage: $0 <start_directory>"
    echo "Example: $0 ."
    echo "Example: $0 /home/user/images"
    exit 1
else
    process_images "$1"
fi

echo "Image conversion complete!"
