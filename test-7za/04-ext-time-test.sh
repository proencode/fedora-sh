#!/bin/sh

ext7zprog () {
	mkdir tstdir
	echo "----> cd tstdir ; time 7za x -ptest ../${1} ; cd ../"
	cd tstdir ; time 7za x -ptest ../${1} ; cd ../
	rm -rf tstdir
}

ext7zprog Big_programs-mx1-220905-2m30.924s.7z
ext7zprog Big_programs-mx3-220905-4m11.982s.7z
ext7zprog Big_programs-mx5-220905-3m41.003s.7z
ext7zprog Big_programs-mx7-220905-7m3.329s.7z
ext7zprog Big_programs-mx9-220905-7m3.157s.7z
ext7zprog Big_programs-mxNONE-220905-4m0.480s.7z
ext7zprog Download-bada-mx1-220905-0m14.008s.7z
ext7zprog Download-bada-mx3-220905-0m24.873s.7z
ext7zprog Download-bada-mx5-220905-0m51.817s.7z
ext7zprog Download-bada-mx7-220905-1m32.249s.7z
ext7zprog Download-bada-mx9-220905-1m32.886s.7z
ext7zprog Download-bada-mxNONE-220905-0m55.167s.7z
