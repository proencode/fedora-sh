# 배열 변수를 생성합니다.
declare -a arr

# 배열 변수에 키-값을 지정합니다.
arr['an-nyeong'] = "Hello"
arr['se-sang'] = "World"

# 배열 변수를 JSON으로 저장합니다.
json_data=$(echo "${arr[@]}" | jq -c)

# JSON 파일에 저장합니다.
echo "$json_data" > d-array.json

# JSON 파일을 읽어 들입니다.
json_data=$(cat d-array.json)

# JSON 데이터를 배열 변수로 변환합니다.
arr=( $(jq -r '.[]' <<< "$json_data") )

# 키-값을 사용하여 배열 변수에 저장된 값을 출력합니다.
echo "${arr['an-nyeong']} ${arr['se-sang']}"
# Hello World
