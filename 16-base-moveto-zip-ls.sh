#!/bin/sh

log_name="log-16-base-moveto-zip-ls"
echo "$(date +'%H:%M:%S:')#----> log_name ${log_name}" >> ${log_name}
for base in cadbase emailbase georaebase scanbase
do
	echo "$(date +'%H:%M:%S:')#----> base ${base}" >> ${log_name}
	for year in 2010  2011  2012  2013  2014  2015  2016  2017  2018  2019  2020  2021  2022  2023
	do
		to_dir=base_year_zip/${base}/${year}
		echo "$(date +'%H:%M:%S:')#----> mkdir -p ${to_dir}" >> ${log_name}
		mkdir -p ${to_dir}
		echo "$(date +'%H:%M:%S:')#----> mv ${base}/${year}/*[Rz] ${to_dir}/" >> ${log_name}
		mv ${base}/${year}/*[Rz] ${to_dir}/
	done
done
