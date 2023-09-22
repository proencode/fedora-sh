#!/bin/sh

BIN_VALUE="${HOME}/bin/value_wikijs"
#-- if [ -f "~/bin/qqq*" ];then echo "Found"; else echo "Not found"; fi
if [ ! -f "${BIN_VALUE}*.sh" ]; then
	#-- a.sh: 행 5번: [: /home/yosj/bin/value_wikijs-230922-120744-new.sh: 이항 연산자가 필요합니다 #-- 오류가 나므로, ${BIN_VALUE}*.sh 대신 "${BIN_VALUE}*.sh" 로 표기해야 함.
	#-- 최초에 지정해 주는 값.
	DOCKER_DIR=/home/docker #-- dwjs (2-1) 도커 디렉토리 홈
	DATABASE_NAME=wiki_postgres
	DB_user_NAME=iamwiki #-- dwjs (3-13) 데이터베이스 유저 이름
	NEW_MADE_FILE=${BIN_VALUE}-$(date +%y%m%d-%H%M%S)-first.sh
	cat >> ${NEW_MADE_FILE} <<__EOF__
#-- ${NEW_MADE_FILE} --
DOCKER_DIR=${DOCKER_DIR} #-- dwjs (2-1) 도커 디렉토리 홈
DATABASE_NAME=${DATABASE_NAME} #-- dwjs (3-4) 데이터베이스 이름
DB_user_NAME=${DB_user_NAME} #-- dwjs (3-13) 데이터베이스 유저 이름
__EOF__
	echo "(1) sleep 1.1 #-- 위 ${NEW_MADE_FILE} 파일은 임시이므로, 1.1초 지연후 LAST_DEFINE_SH 파일 이름을 만든다."
	sleep 1.1
	#-- 첫 작업이므로 여기에서 선언할 것은 위에것 뿐이다.
else
	LAST_DEFINE_SH="$(ls -ltr ${BIN_VALUE}*.sh | tail -1 | awk '{print $9}')"
	echo "(3) LAST_DEFINE_SH [=${LAST_DEFINE_SH}]"
	$(sh ${LAST_DEFINE_SH}) #-- 여기서 선언을 해서 아래쪽에서 쓸수 있도록 한다.
fi

last_file=$(grep DOCKER_DIR ${BIN_VALUE}*.sh | awk -F"=" '{print $2}' | awk -F"#" '{print $1}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- 앞뒤 공백 제거
echo "(4) last_file [=${last_file}]=\$(grep DOCKER_DIR ${BIN_VALUE}*.sh | awk -F\"=\" '{print \$2}' | awk -F\"#\" '{print \$1}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- 앞뒤 공백 제거"
#-- perl 의 chomp 와 같이 문자열의 앞뒤에 있는 공백만 제거하려면, https://free-jonathan.tistory.com/9
#-- sed -e 's/^ *//g' -e 's/ *$//g'
LAST_DEFINE_SH=$(ls -ltr ${BIN_VALUE}*.sh | tail -1 | awk '{print $9}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- ~/bin/value-*.sh 파일중 최근것.
echo "(5) LAST_DEFINE_SH [=${LAST_DEFINE_SH}]=\$(ls -ltr \${BIN_VALUE}*.sh | tail -1 | awk '{print \$9}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- ~/bin/value-*.sh 파일중 최근것."
tempname=$(grep DOCKER_DIR ${LAST_DEFINE_SH} | awk -F"=" '{print $2}' | awk -F"#" '{print $1}') #-- DOCKER_DIR 의 값을 꺼내서 rempname 에 담는다.
echo "(6) \${tempname} [=${tempname}]=\$(grep DOCKER_DIR \${LAST_DEFINE_SH} [=${LAST_DEFINE_SH}] | awk -F\"=\" '{print \$2}') #-- DOCKER_DIR 의 값을 꺼내서 rempname 에 담는다."

NEW_MADE_FILE=${BIN_VALUE}-$(date +%y%m%d-%H%M%S).sh
cat >> ${NEW_MADE_FILE} <<__EOF__
#-- ${NEW_MADE_FILE} --
DOCKER_DIR=${DOCKER_DIR} #-- dwjs (2-1) 도커 디렉토리 홈
DATABASE_NAME=${DATABASE_NAME} #-- dwjs (3-4) 데이터베이스 이름
DB_user_NAME=${DB_user_NAME} #-- dwjs (3-13) 데이터베이스 유저 이름
__EOF__
echo "(7) more ${BIN_VALUE}*.sh"
cnt=0
ls ${BIN_VALUE}*.sh | while read line
do
	cnt=$(( cnt + 1 ))
	echo "v v v v v v v v v v"
	echo "(8-$cnt) cat $line"
	cat $line
	echo "^ ^ ^ ^ ^ ^ ^ ^ ^ ^"
done
