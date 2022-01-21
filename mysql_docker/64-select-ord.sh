#!/bin/sh

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
	from ord ;

"
