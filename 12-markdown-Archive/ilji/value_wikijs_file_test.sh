#!/bin/sh

DEF_SH="${HOME}/bin/value_wikijs"
echo "(1) if [ ! -f \"${DEF_SH}*.sh\" ]; then"
if [ ! -f "${DEF_SH}*.sh" ]; then
	#-- a.sh: 행 5번: [: /home/yosj/bin/value_wikijs-230922-120744-new.sh: 이항 연산자가 필요합니다
	#-- 오류가 나므로, ${DEF_SH}*.sh 대신 "${DEF_SH}*.sh" 로 표기해야 함.
	DOCKER_DIR=/home/docker #-- dwjs (2-1) 도커 디렉토리 홈
	DATABASE_NAME=wiki_postgres
	DB_user_NAME=iamwiki #-- dwjs (3-13) 데이터베이스 유저 이름
	NEW_MADE_FILE=${DEF_SH}-$(date +%y%m%d-%H%M%S)-imsi.sh
cat >> ${NEW_MADE_FILE} <<__EOF__
#-- ${NEW_MADE_FILE} --
DOCKER_DIR=${DOCKER_DIR} #-- dwjs (2-1) 도커 디렉토리 홈
DATABASE_NAME=${DATABASE_NAME} #-- dwjs (3-4) 데이터베이스 이름
DB_user_NAME=${DB_user_NAME} #-- dwjs (3-13) 데이터베이스 유저 이름
__EOF__
	echo "(2) sleep 2 #-- 위 ${NEW_MADE_FILE} 파일은 임시이므로, 2초 지연후 LAST_DEFINE_SH 파일 이름을 만든다."
	sleep 2
	LAST_DEFINE_SH=${DEF_SH}-$(date +%y%m%d-%H%M%S).sh
	echo "(3) LAST_DEFINE_SH [ ${LAST_DEFINE_SH} ]"
else
	LAST_DEFINE_SH="$(ls -ltr ${DEF_SH}*.sh | tail -1 | awk '{print $9}')"
	echo "(4) LAST_DEFINE_SH [ ${LAST_DEFINE_SH} ]"
fi

last_file=$(grep DOCKER_DIR ${DEF_SH}*.sh | awk -F"=" '{print $2}' | awk -F"#" '{print $1}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- 앞뒤 공백 제거
$(sh ${last_file})
#-- perl 의 chomp 와 같이 문자열의 앞뒤에 있는 공백만 제거하려면, https://free-jonathan.tistory.com/9
#-- sed -e 's/^ *//g' -e 's/ *$//g'
LAST_DEFINE_SH=$(ls -ltr ${DEF_SH}*.sh | tail -1 | awk '{print $9}' | sed -e 's/^ *//g' -e 's/ *$//g')
echo "(4) LAST_DEFINE_SH [ ${LAST_DEFINE_SH} ]=\$(ls -ltr \${DEF_SH}*.sh | tail -1 | awk '{print \$9}' | sed -e 's/^ *//g' -e 's/ *$//g')"
tempname=$(grep DOCKER_DIR ${LAST_DEFINE_SH} | awk -F"=" '{print $2}' | awk -F"#" '{print $1}')
echo "(5) [ ${tempname} ]=\$(grep DOCKER_DIR \${LAST_DEFINE_SH} [ ${LAST_DEFINE_SH} ] | awk -F\"=\" '{print \$2}')"

NEW_MADE_FILE=${DEF_SH}-$(date +%y%m%d-%H%M%S).sh
cat >> ${NEW_MADE_FILE} <<__EOF__
#-- ${NEW_MADE_FILE} --
DOCKER_DIR=${DOCKER_DIR} #-- dwjs (2-1) 도커 디렉토리 홈
DATABASE_NAME=${DATABASE_NAME} #-- dwjs (3-4) 데이터베이스 이름
DB_user_NAME=${DB_user_NAME} #-- dwjs (3-13) 데이터베이스 유저 이름
LAST_DEFINE_SH="$(ls -ltr ${DEF_SH}*.sh | tail -1 | awk '{print $9}')"
tempname=$(grep DOCKER_DIR ${LAST_DEFINE_SH} | awk -F"=" '{print $2}' | awk -F"#" '{print $1}')
__EOF__
