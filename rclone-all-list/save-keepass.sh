#!/bin/sh

hhh=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2) #-- 230908

home_dir="${HOME}/wind_bada"
if [ ! -d ${home_dir} ]; then
	mkdir -p ${home_dir}
fi

cloud_BACKUP_name_dir="yswone:backup-keepass"
cloud_name_dir="yswone:keepass"
ym="$(date +%y%m)"
ymd_hm="$(date +%y%m%d-%H%M)"

ym_kdbx="keepass${ym}.kdbx"
d_hm_kdbx="keepass${ymd_hm}.kdbx"

ym_ods="43-keepass${ym}.ods"
d_hm_ods="43-keepass${ymd_hm}.ods"

echo "${bbb}#----> ${ccc}ls -ltr ${home_dir}/keepass*.kdbx${xxx}"
ls -ltr ${home_dir}/keepass*.kdbx
echo "${bbb}#----> ${ccc}ls -ltr 43-${home_dir}/keepass*.ods${xxx}"
ls -ltr ${home_dir}/43-keepass*.ods

if [ ! -f ${home_dir}/${ym_kdbx} ]; then
	#-- ym_1_month_ago="$(date -d '1 month ago' +%y%m)" #-- 1개월 전: https://soft.plusblog.co.kr/97
	ym_1_month_ago=$(date -d "1 month ago" +%y%m) #-- 1개월 전: https://soft.plusblog.co.kr/97
	ym_1mAgo_kdbx="keepass${ym_1_month_ago}.kdbx"
	if [ -f ${home_dir}/${ym_1mAgo_kdbx} ]; then
		echo "${bbb}#----> ${ccc}mv ${home_dir}/${ym_1mAgo_kdbx} ${home_dir}/${ym_kdbx} ${bbb}#-- 파일이름 변경${xxx}"
		mv ${home_dir}/${ym_1mAgo_kdbx} ${home_dir}/${ym_kdbx}
	else
	        cat <<__EOF__
${bbb}
#-- ${home_dir}/${ym_kdbx} 파일이 없습니다.
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
		echo "${bbb}#----> ${ccc}mv ${home_dir}/${ym_1mAgo_ods} ${home_dir}/${ym_ods} ${bbb}#-- 파일이름 변경${xxx}"
		mv ${home_dir}/${ym_1mAgo_ods} ${home_dir}/${ym_ods}
	else
	        cat <<__EOF__
${bbb}
#-- ${home_dir}/${ym_ods} 파일이 없습니다.
#-- ls -ltr ${home_dir}/${xxx}
$(ls -ltr ${home_dir}/)
${bbb}#--${xxx}
__EOF__
	        exit -1
	fi
fi

echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3 ${bbb}#-- 옛 클라우드${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3

echo "${bbb}#----> ${ccc}rclone move ${cloud_name_dir}/${ym}/ ${cloud_BACKUP_name_dir}/${ym}/ ${bbb}#-- 클라우드 옛자료 백업${xxx}"
rclone move ${cloud_name_dir}/${ym}/ ${cloud_BACKUP_name_dir}/${ym}/

echo "${bbb}#----> ${ccc}rclone lsl ${cloud_BACKUP_name_dir}/ | sort -k2 -k3 ${bbb}#-- 백업후 클라우드${xxx}"
rclone lsl ${cloud_BACKUP_name_dir}/ | sort -k2 -k3

#--

echo "${bbb}#----> ${ccc}rclone copy ${home_dir}/${ym_kdbx} ${cloud_name_dir}/ ${bbb}#-- 클라우드로 복사 4-1${xxx}"
rclone copy ${home_dir}/${ym_kdbx} ${cloud_name_dir}/

echo "${bbb}#----> ${ccc}cp ${home_dir}/${ym_kdbx} ${home_dir}/keepass${ymd_hm}.kdbx ${bbb}#-- 로컬에 복사${xxx}"
cp ${home_dir}/${ym_kdbx} ${home_dir}/keepass${ymd_hm}.kdbx

#--

echo "${bbb}#----> ${ccc}rclone copy ${home_dir}/keepass${ymd_hm}.kdbx ${cloud_name_dir}/${ym}/ ${bbb}#-- 클라우드로 복사 4-2${xxx}"
rclone copy ${home_dir}/keepass${ymd_hm}.kdbx ${cloud_name_dir}/${ym}/

echo "${bbb}#----> ${ccc}rm -f ${home_dir}/keepass${ymd_hm}.kdbx ${bbb}#-- 로컬 삭제${xxx}"
rm -f ${home_dir}/keepass${ymd_hm}.kdbx

#--

echo "${bbb}#----> ${ccc}rclone copy ${home_dir}/${ym_ods} ${cloud_name_dir}/ ${bbb}#-- 클라우드로 복사 4-3${xxx}"
rclone copy ${home_dir}/${ym_ods} ${cloud_name_dir}/

echo "${bbb}#----> ${ccc}cp ${home_dir}/${ym_ods} ${home_dir}/${d_hm_ods} ${bbb}#-- 로컬에 복사${xxx}"
cp ${home_dir}/${ym_ods} ${home_dir}/${d_hm_ods}

#--

echo "${bbb}#----> ${ccc}rclone copy ${home_dir}/${d_hm_ods} ${cloud_name_dir}/${ym}/ ${bbb}#-- 클라우드로 복사 4-4${xxx}"
rclone copy ${home_dir}/${d_hm_ods} ${cloud_name_dir}/${ym}/

echo "${bbb}#----> ${ccc}rm -f ${home_dir}/${d_hm_ods} ${bbb}#-- 로컬 삭제${xxx}"
rm -f ${home_dir}/${d_hm_ods}

#--

echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3 ${bbb}#-- 새로운 클라우드${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3 ${bbb}#-- $(date +%y%m%d%a-%H%M) 클라우드${xxx}"
