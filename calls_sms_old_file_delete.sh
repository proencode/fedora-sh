#!/bin/sh

bashrun () {
	runstr="$1"
	echo "${runstr}"
	#-- echo "==== if [ \"\${runstr:0:1}\" != \"#\" ]; then"
	#-- echo "++++ if [ \"${runstr:0:1}\" != \"#\" ]; then"
	if [ "${runstr:0:1}" != "#" ]; then
		echo "rclone delete ${runstr}"
		rclone delete ${runstr}
	fi
}

bashrun "#----> delete ysw10mi:"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230410144637.xml-230609금1254.7z"
bashrun "# 30170 tpn4mi:calls_sms/2023/calls-20230410144637.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230416001810.xml-230609금1254.7z"
bashrun "# 30298 tpn4mi:calls_sms/2023/calls-20230416001810.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230423011118.xml-230609금1254.7z"
bashrun "# 30346 tpn4mi:calls_sms/2023/calls-20230423011118.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230430013914.xml-230609금1254.7z"
bashrun "# 30490 tpn4mi:calls_sms/2023/calls-20230430013914.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230507010106.xml-230609금1254.7z"
bashrun "# 30666 tpn4mi:calls_sms/2023/calls-20230507010106.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230514034903.xml-230609금1254.7z"
bashrun "# 30746 tpn4mi:calls_sms/2023/calls-20230514034903.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230521012853.xml-230609금1254.7z"
bashrun "# 30842 tpn4mi:calls_sms/2023/calls-20230521012853.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230522150751.xml-230609금1254.7z"
bashrun "# 30890 tpn4mi:calls_sms/2023/calls-20230522150751.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230528001754.xml-230609금1254.7z"
bashrun "# 31082 tpn4mi:calls_sms/2023/calls-20230528001754.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230604004915.xml-230609금1254.7z"
bashrun "# 31306 tpn4mi:calls_sms/2023/calls-20230604004915.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/calls-20230609122934.xml-230609금1254.7z"
bashrun "# 31370 tpn4mi:calls_sms/2023/calls-20230609122934.xml.7z"
bashrun "#----> delete tpn3mi:"
bashrun               "tpn3mi:calls_sms/calls-20230730001754.xml.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20230730001754.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20230827003339.xml.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20230827003339.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20230910023532.xml.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20230910023532.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20230917001733.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20230917001733.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20230924013536.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20230924013536.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231001005454.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231001005454.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231008004008.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231008004008.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231015004818.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231015004818.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231022020909.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231022020909.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231029025221.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231029025221.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231105001723.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231105001723.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231112001724.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231112001724.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231119002013.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231119002013.xml.7z"
bashrun               "tpn3mi:calls_sms/calls-20231126010740.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231126010740.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20231126010740.xml"
bashrun "#----> delete yosjgc:"
bashrun               "yosjgc:calls_sms/calls-20231203013604.xml"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231203013604.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20231210013501.xml"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231210013501.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20231217005431.xml"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231217005431.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20231224010553.xml"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231224010553.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20231231004138.xml"
bashrun "#------- tpn4mi:calls_sms/2023/calls-20231231004138.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20240107021506.xml"
bashrun "#------- tpn4mi:calls_sms/2024/calls-20240107021506.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20240114025856.xml"
bashrun "#------- tpn4mi:calls_sms/2024/calls-20240114025856.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20240121032343.xml"
bashrun "#------- tpn4mi:calls_sms/2024/calls-20240121032343.xml.7z"
bashrun               "yosjgc:calls_sms/calls-20240128012440.xml"
bashrun "#------- tpn4mi:calls_sms/2024/calls-20240128012440.xml.7z"
bashrun "#----> delete ysw10mi:"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230507010106.xml-230609금1254.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230507010106.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230514034903.xml-230609금1257.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230514034903.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230521012853.xml-230609금1259.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230521012853.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230522150751.xml-230609금1302.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230522150751.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230528001754.xml-230609금1305.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230528001754.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230604004915.xml-230609금1308.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230604004915.xml.7z"
bashrun "ysw10mi:from_yosjgc/calls_sms/sms-20230609122934.xml-230609금1310.7z"
bashrun "#------ tpn4mi:calls_sms/2023/sms-20230609122934.xml.7z"
bashrun "#----> delete tpn3mi:"
bashrun              "tpn3mi:calls_sms/sms-20230730001754.xml.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20230730001754.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20230827003339.xml.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20230827003339.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20230910023532.xml.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20230910023532.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20230917001733.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20230917001733.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20230924013536.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20230924013536.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231001005454.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231001005454.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231008004008.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231008004008.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231015004818.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231015004818.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231022020909.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231022020909.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231029025221.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231029025221.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231105001723.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231105001723.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231112001724.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231112001724.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231119002013.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231119002013.xml.7z"
bashrun               "tpn3mi:calls_sms/sms-20231126010740.xml-98.7z"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231126010740.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20231126010740.xml.7z"
bashrun "#----> delete yosjgc:"
bashrun               "yosjgc:calls_sms/sms-20231203013604.xml"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231203013604.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20231210013501.xml"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231210013501.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20231217005431.xml"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231217005431.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20231224010553.xml"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231224010553.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20231231004138.xml"
bashrun "#------- tpn4mi:calls_sms/2023/sms-20231231004138.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20240107021506.xml"
bashrun "#------- tpn4mi:calls_sms/2024/sms-20240107021506.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20240114025856.xml"
bashrun "#------- tpn4mi:calls_sms/2024/sms-20240114025856.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20240121032343.xml"
bashrun "#------- tpn4mi:calls_sms/2024/sms-20240121032343.xml.7z"
bashrun               "yosjgc:calls_sms/sms-20240128012440.xml"
bashrun "#------- tpn4mi:calls_sms/2024/sms-20240128012440.xml.7z"
