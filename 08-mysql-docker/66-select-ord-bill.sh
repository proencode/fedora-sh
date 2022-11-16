#!/bin/sh

mysql --login-path=ksamlog ksam21 -v -e "

SET lc_time_names = 'ko_KR' ; -- mysql 의 한글처리: https://dev.mysql.com/doc/refman/5.7/en/locale-support.html

select id, concat (nap_id, '-', dam_id) as geo, stno, bongstat as bo, billstat as bl, feestat as fe
	, date_format (addok, '%y-%m-%d%a%H:%i') as 'addok'
	, date_format (napgi, '%d%a%H:%i') as 'napgi'
-- 	, date_format (bongfrom, '%d%a%H:%i') as 'from'
-- 	, date_format (bongto, '%d%a%H:%i') as 'to'
	, hapkum
	, date_format (napok, '%d%a%H:%i') as 'napok'
	, date_format (hapkumok, '%d%a%H:%i') as 'hapkumok'
	, date_format (billok, '%d%a%H:%i') as 'billok'
	, jak_id as jk
	, date_format (bongok, '%d%a%H:%i') as 'bongok'
	, date_format (feeok, '%d%a%H:%i') as 'feeok'
	from ord ;

"

cat <<__EOF__

스타일번호는 ST01 ST02 ST03 과 같이 공백으로 뛰워 입력합니다.
----> 스타일번호:
__EOF__
read stnos
if [ "x$stnos" = "x" ]; then
	exit 0
fi

stylenois=""

for stno in ${stnos[@]} ; do
	if [ "x$stylenois" != "x" ]; then
		stylenois="${stylenois} or"
	fi
	stylenois="${stylenois} stno='${stno}'"
done

mysql --login-path=ksamlog ksam21 -v -e "

SET lc_time_names = 'ko_KR' ; -- mysql 의 한글처리: https://dev.mysql.com/doc/refman/5.7/en/locale-support.html

select id, concat (nap_id, '-', dam_id) as geo, stno, bongstat as bo, billstat as bl, feestat as fe
	, date_format (addok, '%y-%m-%d%a%H:%i') as 'addok'
	, date_format (napgi, '%d%a%H:%i') as 'napgi'
	, date_format (bongfrom, '%d%a%H:%i') as 'from'
	, date_format (bongto, '%d%a%H:%i') as 'to'
	, date_format (napok, '%d%a%H:%i') as 'napok'
	, date_format (hapkumok, '%d%a%H:%i') as 'hapkumok'
	, date_format (billok, '%d%a%H:%i') as 'billok'
	, jak_id as jk
	, date_format (bongok, '%d%a%H:%i') as 'bongok'
	, date_format (feeok, '%d%a%H:%i') as 'feeok'
	from ord where ${stylenois}
	;

select id, concat (nap_id, '-', dam_id) as geo, billstat as bi
	, date_format (billok, '%d%a%H:%i') as 'billok'
	, dambill, hapkum, vat, gakum, running
	, date_format (addok, '%d%a%H:%i') as 'addok'
	, date_format (updok, '%d%a%H:%i') as 'updok'
	from bill
	;
"
