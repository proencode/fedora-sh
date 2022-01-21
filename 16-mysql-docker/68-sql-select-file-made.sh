#!/bin/sh

mysql_select () {
	save_dir_file="${1}"
	table_name="${2}"
	mysql --login-path=ksamlog ksam21 -e "
select '#    ////    ${table_name} $(date +'%y%m%d%a-%H%M')' as ${table_name} ;
select * from ${table_name}\\G ;
" >> ${save_dir_file}
}

save_dir="run_sh/mysql_docker_start"
save_dir_file="${save_dir}/sql-timediff-$(date +'%y%m%d%a-%H%M%S')"
echo "" > ${save_dir_file}
# ----
mysql_select "${save_dir_file}" "ord"
mysql_select "${save_dir_file}" "bill"
# ----
ls_list=(ls ${save_dir}/sql-*) # 배열
ls ${save_dir}/sql-*

top=${#ls_list[@]} # 배열의 갯수
last=$((top - 1))
befr=$((top - 2))

if [ ${befr} -lt 1 ]; then
	echo "----> 파일이 2 개 이상 되어야 비교할수 있습니다."
else
	out_dir_file="${save_dir}/db-change-$(date +'%y%m%d-%H%M%S')"
	echo "mysql --login-path=ksamlog ksam21 -e \"select 'id', id, 'hapkum', hapkum from ord where id=1 or id=3\" ; vi ${out_dir_file}" > ${out_dir_file}
	echo "sed -i 's/ id/_id/g' ${ls_list[befr]} ; diff ${ls_list[befr]} ${ls_list[last]} >> ${out_dir_file} ; vi ${out_dir_file}"
	sed -i 's/ id/_id/g' ${ls_list[befr]} ; diff ${ls_list[befr]} ${ls_list[last]} >> ${out_dir_file} ; vi ${out_dir_file}
fi
ls ${save_dir}/[ds]*
