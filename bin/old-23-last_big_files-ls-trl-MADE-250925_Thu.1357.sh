#!/bin/sh

echo "#-- ls -l | grep \"^d\"" #-- d = 디렉토리만 확인
ls -l | grep "^d"
echo ""

cat <<__EOF__

Windows 에서 다운로드 받은 (~/Downloads) 폴더 이거나, 또는
ubuntu 에서 백업해둔 (~/a*/m*/) 폴더에서 실행해야 합니다.
현재 위치: ---- $(pwd) ----

--------------- (~/Downloads) ----------------- (~/a*/m*/)
Windows의 [d] 다운로드한 폴더, 또는 백업해둔 서버 [s] 폴더
----------^^^-------------------------------------^^^-----

__EOF__
DOWNLOAD_CHAR="d"
SERVER_CHAR="s"
#-- -p: prompt for windows
read -p "#----> Enter '${DOWNLOAD_CHAR}' or '${SERVER_CHAR}': " DOWNLOAD_OR_SERVER
if [ "x${DOWNLOAD_OR_SERVER}" == "x${DOWNLOAD_CHAR}" ]; then
  NAME_LS_L=0${DOWNLOAD_CHAR}-last_big_files-${HOSTNAME}-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-l
  cat <<__EOF__

#-- '${DOWNLOAD_CHAR}' = 다운로드받은 pc의 $(pwd) 에서 리스트 만들기

__EOF__
else
  if [ "x${DOWNLOAD_OR_SERVER}" == "x${SERVER_CHAR}" ]; then
    NAME_LS_L=0${SERVER_CHAR}-last_big_files-${HOSTNAME}-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-l
    cat <<__EOF__

#-- '${SERVER_CHAR}' = 백업해둔 서버의 $(pwd) 에서 리스트 만들기

__EOF__
  else
    cat <<__EOF__
#//////// '${DOWNLOAD_CHAR}' or '${SERVER_CHAR}' please."

__EOF__
    exit -1
  fi
fi
echo "#-- ls -l | grep \"^d\"" #-- d = 디렉토리만 확인
ls -l | grep "^d"
echo ""

LAST_BIG_TEMP="11-last_big_files"
read -p "다운로드받거나 백업해둔 폴더의 이름: [ ${LAST_BIG_TEMP} ]: " last_big_dir
if [ "x${last_big_dir}" = "x" ]; then
  last_big_dir="${LAST_BIG_TEMP}"
fi
#-- if [ ! -d ${last_big_dir} ]; then
#--   echo "#-- mkdir ${last_big_dir}"
#--   mkdir ${last_big_dir}
#--   echo "#-- ${last_big_dir} 폴더를 새로 만들었으므로 파일이 없어서 작업을 끝냅니다."
#--   exit -2
#-- fi

#xxx fn=h_ost-d_own-s_end-${HOSTNAME}-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-l
# echo "#-- XXXXXXXXXXXXXXXX> user_grp=$(ls -l $0 | awk '{print $3" "$4}')"

user_grp=$(ls -l $0 | awk '{print $3" "$4}')
cat >> ${NAME_LS_L} <<__EOF__
#-- $(pwd)  #-- 첫칸이 'o' 로 된것만 전송합니다.
__EOF__

if [ "x${DOWNLOAD_OR_SERVER}" = "x${SERVER_CHAR}" ]; then
  echo >> ${NAME_LS_L} <<__EOF__

${SERVER_CHAR} = 백업해둔 서버의 리스트 만들기 (서버의 ~/a*/m*/ 에서 시작해야 함)

__EOF__
else
  if [ "x${DOWNLOAD_OR_SERVER}" = "x${DOWNLOAD_CHAR}" ]; then
    echo >> ${NAME_LS_L} <<__EOF__

${DOWNLOAD_CHAR} = 다운로드받은 pc의 리스트 만들기 (pc의 ~/Downloads/ 에서 시작해야 함)

__EOF__
  fi
fi

#-- echo "#-- ls -l ${NAME_LS_L} | awk -F\"${user_grp}\" '{print ${{DOWNLOAD_OR_SERVER}}\" \"$2}'"
if [ "x${DOWNLOAD_OR_SERVER}" = "x${SERVER_CHAR}" ]; then
  ls -l ${last_big_dir} | awk -F"${user_grp}" "{print \"${SERVER_CHAR} \"\$2}" >> ${NAME_LS_L}
else
  if [ "x${DOWNLOAD_OR_SERVER}" = "x${DOWNLOAD_CHAR}" ]; then
    ls -l ${last_big_dir} | awk -F"${user_grp}" "{print \"${DOWNLOAD_CHAR} \"\$2}" >> ${NAME_LS_L}
  fi
fi

cat <<__EOF__

#-- cat ${NAME_LS_L}
-------------------------------------------
$(cat ${NAME_LS_L})
-------------------------------------------
__EOF__
