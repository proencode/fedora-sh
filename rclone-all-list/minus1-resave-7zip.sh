#!/bin/sh

echo "----> rclone ls yosjgc: | grep ' -1 ' | awk -F' -1 ' '{print $2}' | while read fn"
rclone ls yosjgc: | grep ' -1 ' | awk -F' -1 ' '{print $2}' | while read fn
do
	nameonly=$(echo ${fn} | awk -F"/" '{print $NF}')
	#-- Replacing a Substring With Another String in Bash Learn how to replace a single or multiple occurrences of a substring inside a string in Bash.  Sep 24, 2021 — Avimanyu Bandyopadhyay https://linuxhandbook.com/replace-string-bash/
	#-- ${원본문자열/바꾸려는문자열/바꿔넣을문자열}
	dirname="${fn/$nameonly/''}"
	rclone copy "yosjgc:${fn}" .
	7za a -mx=9 "${nameonly}.7z" "${nameonly}"
	rclone copy "${nameonly}.7z" "yosjgc:${fn}.7z"
	rclone ls "yosjgc:${dirname}"
done
