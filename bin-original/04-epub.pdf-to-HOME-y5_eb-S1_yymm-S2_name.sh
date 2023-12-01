#!/bin/sh

cat <<__EOF__
#-- [yymm: $1] [original_file: $2]
#--
__EOF__

yymm=$1
if [ "x${yymm}" \< "x2101" ] || [ "x${yymm}" \> "x2912" ]; then
	echo "Error: yymm: 2101 ... 2912"
	exit -1
fi
original_file=$2
if [ ! -f "${original_file}" ]; then
	echo "Error: '${original_file}' NOT found"
	exit -1
fi
new_dir="${HOME}/ys555nc.mega/eb/${yymm}"
if [ ! -d ${new_dir} ]; then
	echo "----> mkdir ${new_dir}"
	mkdir ${new_dir}
fi
name_change=$(echo "${original_file}" | sed 's/ /_/g')

echo "----> ls -l ${new_dir} | grep --color ${name_change}"
ls -l ${new_dir} | grep --color "${name_change}"
echo "----> mv \"${original_file}\" ${name_change} ; rsync -avzr ${name_change} ${new_dir}/"
echo "----> press Enter:"
read a
mv "${original_file}" ${name_change} ; rsync -avzr ${name_change} ${new_dir}/

echo "----> ls -l ${new_dir} | grep --color ${name_change}"
ls -l ${new_dir} | grep --color "${name_change}"
