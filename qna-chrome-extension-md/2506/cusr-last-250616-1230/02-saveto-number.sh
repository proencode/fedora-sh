#!/bin/sh

cc="cusr16.1230" #-- "cusr12.1039"

echo "#-- sh 02-saveto-number.sh (${1})"
echo "#-- "
if [[ "x${1}" < "x00" || "x${1}" > "x99" ]]; then
        echo "#-- sh 02-saveto-number.sh 00"
        echo "#-- "
        echo "#-- 입력값은 "00" ~ "99" 사이의 값이라야 합니다."
else
        a="000${1}" #-- ${a: -2} == 뒤에서 2개를 꺼낸다.
        dd="${cc}-${a: -2}"
        if [ -d ${dd} ]; then
                echo "#-- ${dd} 폴더가 있어서 백업할 수 없습니다."
        else
                echo "#-- rsync -avzr ${cc}-99/ ${cc}-${a: -2}/"
                rsync -avzr ${cc}-99/ ${cc}-${a: -2}/
                echo "#-- ls -l --color"
                ls -l --color
        fi
fi
