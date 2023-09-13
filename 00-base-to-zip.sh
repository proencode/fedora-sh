#!/bin/sh

for base in cadbase emailbase georaebase scanbase
do
	for year in 2010  2011  2012  2013  2014  2015  2016  2017  2018  2019  2020  2021  2022  2023
	do
		for month in {1..12}
		do
			a="00${month}"
			mm=${a: -2}
			base_year_mm=${base}/${year}/${mm}
			if [ -d ${base_year_mm} ]; then
				psco="zkdhtm${year}"
				cat <<__EOF__
				ls -alR ${base_year_mm} > ${base}/${year}/${base}-${year}-${mm}.ls-alR
				7za a -mx=9 -p${psco} ${base}/${year}/${base}-${year}-${mm}.7z ${base}/${year}/${mm}
__EOF__
			fi
		done
	done
done
