#!/bin/bash

if [ "x$1" != "x" ]; then
	file1="$1"
else
	file1="kor-tradepub"
fi
echo "#-- ${file1}"

if [ "x$2" != "x" ]; then
	file2="$2"
else
	file2="eng-tradepub"
fi
echo "#-- ${file2}"

cn=10000
while read line
do
	cn=$((cn - 1))
	spcline="${line}          "
	reqmmddyyyy=${spcline:0:10}
	if [[ "x$line" != "xShare This:" ]] && [[ "x$line" != "x이 공유:" ]] && [[
		"x$line" != "xOPEN NOW" ]] && [[ "x$line" != "x지금 열다" ]] && [[
		"x$line" != "xDZone" ]] && [[ "x$line" != "xD존" ]] && [[
		$reqmmddyyyy != "Requested " ]]; then
		if [[ "$line" =~ "일에 요청됨" ]]; then
			echo "$cn:e~~~ ($line) !!! 일에 요청됨 ----"
		else
			echo "$cn:e=== ($line)"
		fi
	fi
done < $file1

cn=10000
while read line
do
	cn=$((cn - 1))
	spcline="${line}          "
	reqmmddyyyy=${spcline:0:10}
	if [[ "x$line" != "xShare This:" ]] && [[ "x$line" != "x이 공유:" ]] && [[
		"x$line" != "xOPEN NOW" ]] && [[ "x$line" != "x지금 열다" ]] && [[
		"x$line" != "xDZone" ]] && [[ "x$line" != "xD존" ]] && [[
		$reqmmddyyyy != "Requested " ]]; then
		if [[ "$line" =~ "일에 요청됨" ]]; then
			echo "----$line !!! 일에 요청됨 ----"
		else
			echo "$cn:e=== <$line>"
		fi
	fi
done < $file2
