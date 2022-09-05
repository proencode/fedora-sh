#!/bin/sh

namechange () {
	echo "----> mv \"${1}.7z\" \"${1}-${2}.7z\""
	mv "${1}.7z" "${1}-${2}.7z"
}

namechange  Big_programs-mx1-220905  2m30.924s
namechange  Download-bada-mx1-220905  0m14.008s
namechange  Big_programs-mx3-220905  4m11.982s
namechange  Download-bada-mx3-220905  0m24.873s
namechange  Big_programs-mx5-220905  3m41.003s
namechange  Download-bada-mx5-220905  0m51.817s
namechange  Big_programs-mx7-220905  7m3.329s
namechange  Download-bada-mx7-220905  1m32.249s
namechange  Big_programs-mx9-220905  7m3.157s
namechange  Download-bada-mx9-220905  1m32.886s
namechange  Big_programs-mxNONE-220905  4m0.480s
namechange  Download-bada-mxNONE-220905  0m55.167s
