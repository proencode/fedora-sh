#!/bin/sh

if [ "x$1" != "x" ]; then
	cat <<__EOF__

qq="$(echo "${1,,}" | sed 's/ /_/g')"
mkdir \${qq} ; ls -ltr

__EOF__
else
	cat <<__EOF__

Hint: 다음과 같이 입력하세요.

sh $0  "2307a Modern Android 13 Development Cookbook 230811"

__EOF__
fi
