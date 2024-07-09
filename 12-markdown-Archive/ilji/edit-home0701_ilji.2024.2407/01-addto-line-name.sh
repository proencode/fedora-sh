#!/bin/sh

for file in 50-file-home-0701.md 51-file-ilji-2024-2407.md
do
	seq=1000
	addtoSeqName="addtoSeqName-${file}"
	echo "#--- ${addtoSeqName} BEGIN $(date +%y%m%d-%H%M)"
	while read a_line
	do
		seq=$(($seq + 1))
		echo "${a_line}__LINE__${seq}__NAME__${addtoSeqName}" >> ${addtoSeqName}
	done < ${file}
	lno=$((seq - 999))
	echo "#=== ${addtoSeqName} ${seq} line END $(date +%y%m%d-%H%M)"
done
