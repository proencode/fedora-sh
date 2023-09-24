# 배열 변수를 생성합니다.
declare -a arr

# 배열 변수에 키-값을 지정합니다.
arr['an-nyeong'] = "Hello"
arr['se-sang'] = "World"
echo "(1) ----> arr['se-sang'] = \"World\" # 배열 변수에 키-값을 지정합니다. c2"

# 배열 변수를 JSON으로 저장합니다.
echo "(2) ----> json_data=\$(echo \"\${arr[@]}\" | jq -c) # 배열 변수를 JSON으로 저장합니다. c2"
json_data=$(echo "${arr[@]}" | jq -c)

# JSON 파일에 저장합니다.
echo "(3) ----> echo \"\$json_data\" > d-array.json # JSON 파일에 저장합니다. c2"
echo "$json_data" > d-array.json
