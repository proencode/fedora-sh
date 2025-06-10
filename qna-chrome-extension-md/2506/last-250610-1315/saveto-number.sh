#!/bin/sh

if [[ "x${1}" < "x00" || "x${1}" > "x99" ]]; then
        echo "#-- 입력값은 "00" ~ "99" 사이의 값이라야 합니다."
else
		a="000${1}" #-- ${a: -2} == 뒤에서 2개를 꺼낸다.
        dd="cusr10.1315-${a: -2}"
        if [ -d ${dd} ]; then
                echo "#-- ${dd} 폴더가 있어서 백업할 수 없습니다."
        else
                #-- echo "#-- rsync -avzr cusr10.1315-99 cusr10.1315-${a: -2}"
				#-- echo "#-- 복사후 필요없는 파일은 걸러내야 한다."

                echo "#-- mv cusr10.1315-99 cusr10.1315-${a: -2}"
                mv cusr10.1315-99 cusr10.1315-${a: -2}
				echo "#-- mkdir cusr10.1315-99"
				mkdir cusr10.1315-99
				echo "#-- mkdir 후 ide 에서 새로 파일을 내보내야 한다."

                echo "#-- ls -l --color"
                ls -l --color
        fi
fi
