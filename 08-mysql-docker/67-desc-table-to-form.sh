#!/bin/sh 

tables=($(mysql --login-path=ksamlog ksam21 -e "show tables"))

for table in ${tables[@]} ; do
	if [ "${table:0:9}" != "Tables_in" ]; then
		echo "desc ${table} ;"
		# mysql --login-path=ksamlog ksam21 -v -e "desc ${table}" | grep -v "+--" | sed -e 's/| NULL    //'
		# mysql --login-path=ksamlog ksam21 -vv -e "desc ${table}" > /tmp/sqlout
		# cat /tmp/sqlout | grep -v "+--" | sed -e 's/|$//g' | sed -e 's/| NULL    //g'
		# desc_table=($(mysql --login-path=ksamlog ksam21 -e "desc ${table}"))
		# for desc_line in ${desc_table[@]} ; do
		#	echo ${desc_line} | grep -v "+--" | sed -e 's/|$//g' | sed -e 's/| NULL    //g'
		# done
	else
		echo "-- ${table} -- $(date +"%y%m%d%a%H%M")"
	fi
done

cat <<__EOF__
-- (숫자부터 끝까지 복사헤서 : 입력한 뒤에 붙여널고 엔터)
-- : 1,\$-11s/| Default //
-- : 1,\$-11s/-+---------+/-+/
-- : 1,\$-11s/| NULL    //
-- : 1,\$-11s/                |//
-- / ^+-- (+----+ 표시가 필요없는 경우에는 n 으로 찾고 dd 로 삭제한다.)
-- vi run_sh/mysql_docker_start/99-67-desc-tablesin_ksam21-$(date +"%y%m%d").txt # (vi 에서 수정하기) ---- cut&copy
exit ; -- copy cmd to next there.  -- $(date +"%y%m%d%a%H%M")
#
__EOF__

mysql --login-path=ksamlog ksam21
