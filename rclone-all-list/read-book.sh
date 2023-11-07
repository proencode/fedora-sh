#!/bin/sh

if [ "x$1" != "x" ]; then
	seq_1to6=0
	while IFS= read -r a_line; do
		seq_1to6=$(( seq_1to6 + 1 ))
		if [ $seq_1to6 = 1 ]; then
			b_jemok=$a_line #-- "Test Data Management" 제목
			#-- echo "1: b_jemok \"$b_jemok\" = a_line \"$a_line\" #-- \"Test Data Management\" 제목"
		else
		if [ $seq_1to6 = 2 ]; then
			b_chulpan=$a_line #-- "DZone" 출판사
			#-- echo "2: b_chulpan \"$b_chulpan\" = a_line \"$a_line\" #-- \"DZone\" 출판사"
		else
		if [ $seq_1to6 = 3 ]; then
			xx=1 ### echo "3: \"OPEN NOW\" = 쓰지 않음"
		else
		if [ $seq_1to6 = 4 ]; then
			b_nalja=$a_line #-- "Requested Nov 06, 2021" 요청일
			m=$( echo $b_nalja | awk '{print $2}' )
			if [ "$m" = "Jan" ]; then mm="01"; else if [ "$m" = "Feb" ]; then mm="02"; else if [ "$m" = "Mar" ]; then mm="03"; else
			if [ "$m" = "Apr" ]; then mm="04"; else if [ "$m" = "May" ]; then mm="05"; else if [ "$m" = "Jun" ]; then mm="06"; else
			if [ "$m" = "Jul" ]; then mm="07"; else if [ "$m" = "Aug" ]; then mm="08"; else if [ "$m" = "Sep" ]; then mm="09"; else
			if [ "$m" = "Oct" ]; then mm="10"; else if [ "$m" = "Nov" ]; then mm="11"; else if [ "$m" = "Dec" ]; then mm="12"; else
			mm="00"
			fi; fi; fi;  fi; fi; fi;
			fi; fi; fi;  fi; fi; fi
			d=$( echo $b_nalja | awk '{print $3}' ) ; dd=${d:0:2} #-- 0번째부터 2자리
			y=$( echo $b_nalja | awk '{print $4}' ) ; yy=${y:(-2)} #-- 뒷쪽에서 2자리
			### echo "b_jemok \"$b_jemok\" ; b_chulpan \"$b_chulpan\" ;"
			#-- echo "4: m=\"$m\" mm=\"$mm\" ${yy}${mm}${dd}-${b_jemok}_${b_chulpan} = a_line \"$a_line\""
			f1=$( echo ${b_jemok} | awk '{print $1}' )
			f2=$( echo ${b_jemok} | awk '{print $2}' )
			f3=$( echo ${b_jemok} | awk '{print $3}' )
			f4=$( echo ${b_jemok} | awk '{print $4}' )
			f5=$( echo ${b_jemok} | awk '{print $5}' )
			if [ "$f5" = "-" ]; then
				f5=""
				if [ $f4 = "-" ]; then
					f4=""
					if [ $f3 = "-" ]; then
						f3=""
						if [ $f2 = "-" ]; then
							f2=""
						fi
					fi
				fi
			fi
			f98=$( echo "$f1 $f2 $f3 $f4 $f5" | sed -e 's/^ *//g' -e 's/ *$//g' ) #-- bash 앞과 뒤 공백만 제거
			f99=$( echo "$f98" | sed 's/!//g' | sed 's/://g' | sed 's/*//g' | sed 's/(//g' | sed 's/)//g' | sed 's/\$//g' | sed "s/'//g" | sed "s/ - /-/g" | sed "s/,//g" | sed "s/ -- /--/g" | sed 's/ /_/g' )
			echo "파일 ....> ${yy}${mm}${dd}-${f99}"
			filename=$( echo $b_jemok | sed 's/!//g' | sed 's/://g' | sed 's/*//g' | sed 's/(//g' | sed 's/)//g' | sed 's/\$//g' | sed "s/'//g" | sed "s/ - /-/g" | sed "s/,//g" | sed "s/ -- /--/g" | sed 's/ /_/g' )
			echo "제목 ----> ${yy}${mm}${dd}-${filename}"
			je_ch=$( echo ${b_jemok}..${b_chulpan} | sed 's/!//g' | sed 's/://g' | sed 's/*//g' | sed 's/(//g' | sed 's/)//g' | sed 's/\$//g' | sed "s/'//g" | sed "s/ - /-/g" | sed "s/,//g" | sed "s/ -- /--/g" | sed 's/ /_/g' )
			echo "내역 ====> ${yy}${mm}${dd}-${je_ch}"
		else
		if [ $seq_1to6 = 5 ]; then
			xx=2 ##-- "Share This:" = 쓰지 않음
			### echo "5: \"Share This:\" 쓰지 않음 = a_line \"$a_line\""
		else
		if [ $seq_1to6 = 6 ]; then
			xx=3 #-- "" = 쓰지 않음
			seq_1to6=0 #-- 6줄 처리가 끝났다.
			### echo "6: seq_1to6=$seq_1to6 #-- 6줄 처리가 끝났다. = a_line \"$a_line\""
		fi; fi; fi;  fi; fi; fi
	done < $1
fi
