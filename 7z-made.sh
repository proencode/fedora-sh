#!/bin/sh

for fn in $(ls)
do
	echo "----> 7za a -mx=9 \"${fn}.7z\" \"${fn}\""
	7za a -mx=9 "${fn}.7z" "${fn}"
	echo "----> ls -alR \"${fn}\" > \"${fn}.ls-alR\""
	ls -alR "${fn}" > "${fn}.ls-alR"
done
