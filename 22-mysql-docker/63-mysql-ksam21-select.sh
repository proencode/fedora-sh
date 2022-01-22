#!/bin/sh

for table in bong dam jak kongim magam nap ord sec_role sec_user sekum tagmemo
do
	echo "----> mysql --login-path=ksamlog ksam21 -e \"select \"${table}\", count(*), max(id) from ${table} ;\""
	mysql --login-path=ksamlog ksam21 -e "select \"${table}\", count(*), max(id) from ${table} ;"
done

for table in kongim kongim_ord magam magam_ord sec_user sec_role sec_user_sec_role
do
	echo "----> mysql --login-path=ksamlog ksam21 -e \"desc ${table} ;\""
	mysql --login-path=ksamlog ksam21 -e "desc ${table} ;"
done
