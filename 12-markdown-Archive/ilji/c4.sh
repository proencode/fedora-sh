# 설정 정보를 파일에 저장합니다.
echo "key1 aaaaaa" > d-settings.txt
echo "port2 bbbb_8080" >> d-settings.txt

# 설정 정보를 읽어들입니다.
while read key value; do
	echo "(1) key=$key: value=$value"
	echo "(2) \$( \${key}=\"\${value}\" )"
	cmd1="${key}=\"${value}\""
	echo "(3) \$( ${cmd1} )"
	$( ${cmd1} )
	echo "(4) key=${key}"
done < d-settings.txt
