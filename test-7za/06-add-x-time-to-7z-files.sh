#!/bin/sh

add_ext_time () {
	echo "----> mv $1.7z \"${1}-${2}.7z\""
	mv $1.7z "${1}-${2}.7z"
}

cat <<__EOF__
16:10:29 월 2022-09-05 yos@yscart ~/Test-Vdi/test-7za
test-7za $ ll
합계 11907452
-rw-r--r-- 1 yos vboxsf       1191  9월  5일 14:27 01-zip-time-test.sh
-rw-r--r-- 1 yos yos          6002  9월  5일 15:11 02-7za-a-220905.log
-rw-r--r-- 1 yos yos           678  9월  5일 15:31 03-add-a-time-to-7z-files.sh
-rw-r--r-- 1 yos yos           740  9월  5일 15:45 04-ext-time-test.sh
-rw-r--r-- 1 yos yos          9267  9월  5일 15:51 05-7za-x-220905.log
-rw-r--r-- 1 yos yos           819  9월  5일 16:10 06-add-x-time-to-7z-files.sh
-rw-r--r-- 1 yos yos    1871409103  9월  5일 14:39 Big_programs-mx1-220905-2m30.924s-0m17.438s.7z
-rw-r--r-- 1 yos yos    1870522781  9월  5일 14:43 Big_programs-mx3-220905-4m11.982s-0m34.033s.7z
-rw-r--r-- 1 yos yos    1869309003  9월  5일 14:48 Big_programs-mx5-220905-3m41.003s-0m48.730s.7z
-rw-r--r-- 1 yos yos    1864768554  9월  5일 14:55 Big_programs-mx7-220905-7m3.329s-0m35.152s.7z
-rw-r--r-- 1 yos yos    1864761180  9월  5일 15:04 Big_programs-mx9-220905-7m3.157s-0m26.152s.7z
-rw-r--r-- 1 yos yos    1869309003  9월  5일 15:10 Big_programs-mxNONE-220905-4m0.480s-0m30.053s.7z
-rw-r--r-- 1 yos yos     180903360  9월  5일 14:39 Download-bada-mx1-220905-0m14.008s-0m14.223s.7z
-rw-r--r-- 1 yos yos     174204380  9월  5일 14:44 Download-bada-mx3-220905-0m24.873s-0m5.516s.7z
-rw-r--r-- 1 yos yos     159793244  9월  5일 14:48 Download-bada-mx5-220905-0m51.817s-0m6.159s.7z
-rw-r--r-- 1 yos yos     154199629  9월  5일 14:57 Download-bada-mx7-220905-1m32.249s-0m4.655s.7z
-rw-r--r-- 1 yos yos     154195871  9월  5일 15:06 Download-bada-mx9-220905-1m32.886s-0m4.609s.7z
-rw-r--r-- 1 yos yos     159793245  9월  5일 15:11 Download-bada-mxNONE-220905-0m55.167s-0m4.896s.7z
drwxrwx--- 1 yos vboxsf         40  9월  5일 13:29 Linux-programs
drwxrwx--- 1 yos vboxsf        688  9월  5일 13:29 Windows-programs
drwxrwx--- 1 yos vboxsf        244  9월  5일 13:30 bada
16:10:31 월 2022-09-05 yos@yscart ~/Test-Vdi/test-7za
test-7za $
__EOF__

# exit 1

add_ext_time  Big_programs-mx1-220905-2m30.924s  0m17.438s
add_ext_time  Big_programs-mx3-220905-4m11.982s  0m34.033s
add_ext_time  Big_programs-mx5-220905-3m41.003s  0m48.730s
add_ext_time  Big_programs-mx7-220905-7m3.329s  0m35.152s
add_ext_time  Big_programs-mx9-220905-7m3.157s  0m26.152s
add_ext_time  Big_programs-mxNONE-220905-4m0.480s  0m30.053s
add_ext_time  Download-bada-mx1-220905-0m14.008s  0m14.223s
add_ext_time  Download-bada-mx3-220905-0m24.873s  0m5.516s
add_ext_time  Download-bada-mx5-220905-0m51.817s  0m6.159s
add_ext_time  Download-bada-mx7-220905-1m32.249s  0m4.655s
add_ext_time  Download-bada-mx9-220905-1m32.886s  0m4.609s
add_ext_time  Download-bada-mxNONE-220905-0m55.167s  0m4.896s
