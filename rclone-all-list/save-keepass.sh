#!/bin/sh

source ~/bin/cmdbox

home_dir="${HOME}/wind_bada"
if [ ! -d ${home_dir} ]; then
	cmdrun "mkdir -p ${home_dir}" "0. 새로운 디렉토리"
fi

cloud_BACKUP_name_dir="yswone:backup-keepass"
cloud_name_dir="yswone:keepass"
ym="$(date +%y%m)"
ymd_hm="$(date +%y%m%d-%H%M)"

ym_kdbx="keepass${ym}.kdbx"
d_hm_kdbx="keepass${ymd_hm}.kdbx"

ym_ods="43-keepass${ym}.ods"
d_hm_ods="43-keepass${ymd_hm}.ods"

cmdrun "ls -ltr ${home_dir}/keepass*.kdbx" "1. .kdbx 확인"
cmdrun "ls -ltr ${home_dir}/43-keepass*.ods" "2. .ods 확인"

if [ ! -f ${home_dir}/${ym_kdbx} ]; then
	#-- ym_1_month_ago="$(date -d '1 month ago' +%y%m)" #-- 1개월 전: https://soft.plusblog.co.kr/97
	ym_1_month_ago=$(date -d "1 month ago" +%y%m) #-- 1개월 전: https://soft.plusblog.co.kr/97
	ym_1mAgo_kdbx="keepass${ym_1_month_ago}.kdbx"
	if [ -f ${home_dir}/${ym_1mAgo_kdbx} ]; then
		cmdrun "mv ${home_dir}/${ym_1mAgo_kdbx} ${home_dir}/${ym_kdbx}" "2.1 이번달로 .kdbx 이름변경"
	else
	        cat <<__EOF__
${bbb}
#-- 2.2 ${home_dir}/${ym_kdbx} 파일이 없습니다.
#-- ls -ltr ${home_dir}/
$(ls -ltr ${home_dir}/)
#--${xxx}
__EOF__
	        exit -1
	fi
fi
if [ ! -f ${home_dir}/${ym_ods} ]; then
	ym_1_month_ago=$(date -d "1 month ago" +%y%m) #-- 1개월 전: https://soft.plusblog.co.kr/97
	ym_1mAgo_ods="43-keepass${ym_1_month_ago}.ods"
	if [ -f ${home_dir}/${ym_1mAgo_ods} ]; then
		cmdrun "mv ${home_dir}/${ym_1mAgo_ods} ${home_dir}/${ym_ods}" "2.3 이번달로 .ods 변경"
	else
	        cat <<__EOF__
${bbb}
#-- 2.4 ${home_dir}/${ym_ods} 파일이 없습니다.
#-- ls -ltr ${home_dir}/${xxx}
$(ls -ltr ${home_dir}/)
${bbb}#--${xxx}
__EOF__
	        exit -1
	fi
fi

cmdrun "rclone lsl ${cloud_name_dir}/ | sort -k2 -k3" "3. 옛 클라우드 확인"

cmdrun "rclone moveto ${cloud_name_dir}/${ym}/ ${cloud_BACKUP_name_dir}/${ym}/" "4. 클라우드 옛 자료 이동"

cmdrun "rclone lsl ${cloud_BACKUP_name_dir}/ | sort -k2 -k3" "5. 이동후 클라우드"
#--
cmdrun "rclone copy ${home_dir}/${ym_kdbx} ${cloud_name_dir}/" "6. ym 을 클라우드로 복사"

cmdrun "cp ${home_dir}/${ym_kdbx} ${home_dir}/${d_hm_kdbx}" "7. 로컬에 ymd_hm 으로 복사"

cmdrun "rclone copy ${home_dir}/${d_hm_kdbx} ${cloud_name_dir}/${ym}/" "8. ymd_hm 을 클라우드로 복사"

cmdrun "rm -f ${home_dir}/${d_hm_kdbx}" "9. ymd_hm 을 로컬에서 삭제"
#--
cmdrun "rclone copy ${home_dir}/${ym_ods} ${cloud_name_dir}/" "10. ym.ods 를 클라우드로 복사"

cmdrun "cp ${home_dir}/${ym_ods} ${home_dir}/${d_hm_ods}" "11. 로컬에 ymd_hm.ods 로 복사"

cmdrun "rclone copy ${home_dir}/${d_hm_ods} ${cloud_name_dir}/${ym}/" "12. ymd_hm.ods 를 클라우드로 복사"

cmdrun "rm -f ${home_dir}/${d_hm_ods}" "13. ymd_hm.ods 를 로컬에서 삭제"
#--
cmdrun "rclone lsl ${cloud_name_dir}/ | sort -k2 -k3" "14. 새로운 클라우드 $(date +%y%m%d%a-%H%M)"
