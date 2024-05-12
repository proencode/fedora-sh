#!/bin/sh

ago_Ym=$(date -d "31 day ago" +%Y%m)
this_year=$(date +%Y)
temp_dir="calls_sms-$(date +%y%m%d-%H%M%S)"
csym="cs$(date +%y%m)"

echo "#----> yosjgc:calls_sms 의 ${ago_Ym} 데이터를 tpn4mi:calls_sms/ 로 옮깁니다."
echo "#-- mkdir ${temp_dir} ; cd ${temp_dir}"
mkdir ${temp_dir} ; cd ${temp_dir}

echo "#-- time rclone copy yosjgc:calls_sms/ --include \"calls-${ago_Ym}*\" ."
time rclone copy yosjgc:calls_sms/ --include "calls-${ago_Ym}*" .
echo "#-- time rclone copy yosjgc:calls_sms/ --include \"sms-${ago_Ym}*\" ."
time rclone copy yosjgc:calls_sms/ --include "sms-${ago_Ym}*" .
for cs_file in * #-- 위에서 해당폴더로 cd 했으므로 폴더지정제외함. #-- ${temp_dir}/*
do
	echo "#-- 7za a -p ${cs_file}.7z ${cs_file}"
	7za a -p${csym} ${cs_file}.7z ${cs_file}
	echo "#-- time rclone copy ${cs_file}.7z tpn4mi:calls_sms/${this_year}/"
	time rclone copy ${cs_file}.7z tpn4mi:calls_sms/${this_year}/
done
echo "#-- time rclone ls tpn4mi:calls_sms/${this_year}/ | sort -k2"
time rclone ls tpn4mi:calls_sms/${this_year}/ | sort -k2
echo "#-- time rclone ls yosjgc:calls_sms/ | sort -k2"
time rclone ls yosjgc:calls_sms/ | sort -k2
cat <<__EOF__

ls -l
time rclone ls tpn4mi:calls_sms/${this_year}/ | sort -k2
time rclone ls yosjgc:calls_sms/ | sort -k2

time rclone delete yosjgc:calls_sms/ --include "calls-${ago_Ym}*"
time rclone delete yosjgc:calls_sms/ --include "sms-${ago_Ym}*"

time rclone ls tpn4mi:calls_sms/${this_year}/ | sort -k2
time rclone ls yosjgc:calls_sms/ | sort -k2
#-- rm -rf ${temp_dir} out_${temp_dir}
__EOF__
