#!/bin/sh
#
for fn in "170522 쌍용동해 올바로 준비건" "170523 포천시 한국타이어건" 180727-소형수거시클레임-4277-임동 "2018년도 성실신고" copy-2007년도 copy-2009년도 copy-2010년도 copy-2011년도 copy-2012년도 copy-2013년도 copy-2014년도 copy-2015년도 copy-2016년도 copy-2017년도 copy-2018년도 copy-2019년도 기타자료 신청서및안내문 "행선지별 접수문서 모음"
do
	echo "----> 7za a -mx=9 \"${fn}.7z\" \"${fn}\""
	7za a -mx=9 "${fn}.7z" "${fn}"
	# echo "----> ls -alR \"${fn}\" > \"${fn}.ls-alR\""
	# ls -alR "${fn}" > "${fn}.ls-alR"
done
