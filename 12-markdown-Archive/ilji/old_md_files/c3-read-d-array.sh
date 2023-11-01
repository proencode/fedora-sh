# JSON 파일을 읽어 들입니다.
echo "(1) ----> json_data=\$(cat d-array.json) # JSON 파일을 읽어 들입니다. c3"
json_data=$(cat d-array.json)

# JSON 데이터를 배열 변수로 변환합니다.
echo "(2) ----> arr=( \$(jq -r '.[]' <<< \"\$json_data\") ) # JSON 데이터를 배열 변수로 변환합니다. c3"
arr=( $(jq -r '.[]' <<< "$json_data") )

# 키-값을 사용하여 배열 변수에 저장된 값을 출력합니다.
echo "(3) ----> echo \"\${arr['an-nyeong']} \${arr['se-sang']}\" # 키-값을 사용하여 배열 변수에 저장된 값을 출력합니다. c3"
echo "${arr['an-nyeong']} ${arr['se-sang']}"
# Hello World
