#!/bin/sh

cat <<__EOF__

(~/Downloads) 다운로드받거나 백업해둔 (~/a*/m*/) 폴더에서 실행해야 합니다.

backup_[S]erver's list | [D]ownload pc's list
-------^^^---------------^^^-----------------

__EOF__
SERVER_CHAR="s"
DOWNLOAD_CHAR="d"
read -p "#----> Enter '${SERVER_CHAR}' or '${DOWNLOAD_CHAR}': " SERVER_OR_DOWNLOAD
echo "--- input = ${SERVER_OR_DOWNLOAD}; SERVER_CHAR = ${SERVER_CHAR}; DOWNLOAD_CHAR = ${DOWNLOAD_CHAR};"
if [ "x${SERVER_OR_DOWNLOAD}" == "x${SERVER_CHAR}" ]; then
  NAME_LS_L=11s-last_big_files-${HOSTNAME}-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-l
  cat <<__EOF__

#-- '${SERVER_CHAR}' = 백업해둔 서버의 ~/a*/m*/ 에서 리스트 만들기

__EOF__
else
  if [ "x${SERVER_OR_DOWNLOAD}" == "x${DOWNLOAD_CHAR}" ]; then
    NAME_LS_L=11d-last_big_files-${HOSTNAME}-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-l
    cat <<__EOF__

#-- '${DOWNLOAD_CHAR}' = 다운로드받은 pc의 ~/Downloads/ 에서 리스트 만들기

__EOF__
  else
    cat <<__EOF__
#//////// '${SERVER_CHAR}' or '${DOWNLOAD_CHAR}' please."

__EOF__
    exit -1
  fi
fi
echo "#-- ls -l | grep \"^d\"" #-- d = 디렉토리만 확인
ls -l | grep "^d"
echo ""

BACK_DOWN_DIR="11-last_big_files"
read -p "다운로드받거나 백업해둔 폴더의 이름: [ ${BACK_DOWN_DIR} ]: " dir_name
if [ "x${dir_name}" = "x" ]; then
  dir_name="${BACK_DOWN_DIR}"
fi
#-- if [ ! -d ${dir_name} ]; then
#--   echo "#-- mkdir ${dir_name}"
#--   mkdir ${dir_name}
#--   echo "#-- ${dir_name} 폴더를 새로 만들었으므로 파일이 없어서 작업을 끝냅니다."
#--   exit -2
#-- fi

#xxx fn=h_ost-d_own-s_end-${HOSTNAME}-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-l
# echo "#-- XXXXXXXXXXXXXXXX> user_grp=$(ls -l $0 | awk '{print $3" "$4}')"

user_grp=$(ls -l $0 | awk '{print $3" "$4}')
cat >> ${NAME_LS_L} <<__EOF__
#-- $(pwd)  #-- 첫칸이 'o' 로 된것만 전송합니다.
__EOF__

if [ "x${SERVER_OR_DOWNLOAD}" = "x${SERVER_CHAR}" ]; then
  echo >> ${NAME_LS_L} <<__EOF__

${SERVER_CHAR} = 백업해둔 서버의 리스트 만들기 (서버의 ~/a*/m*/ 에서 시작해야 함)

__EOF__
else
  if [ "x${SERVER_OR_DOWNLOAD}" = "x${DOWNLOAD_CHAR}" ]; then
    echo >> ${NAME_LS_L} <<__EOF__

${DOWNLOAD_CHAR} = 다운로드받은 pc의 리스트 만들기 (pc의 ~/Downloads/ 에서 시작해야 함)

__EOF__
  fi
fi

#-- echo "#-- ls -l ${NAME_LS_L} | awk -F\"${user_grp}\" '{print ${{SERVER_OR_DOWNLOAD}}\" \"$2}'"
if [ "x${SERVER_OR_DOWNLOAD}" = "x${SERVER_CHAR}" ]; then
  ls -l ${dir_name} | awk -F"${user_grp}" '{print "${SERVER_CHAR} "$2}' >> ${NAME_LS_L}
else
  if [ "x${SERVER_OR_DOWNLOAD}" = "x${DOWNLOAD_CHAR}" ]; then
    ls -l 11-last_big_files | awk -F"${user_grp}" '{print "${DOWNLOAD_CHAR} "$2}' >> ${NAME_LS_L}
  fi
fi

cat <<__EOF__

#-- cat ${NAME_LS_L}
-------------------------------------------
__EOF__
cat ${NAME_LS_L}
echo "-------------------------------------------"
