#!/bin/sh

bulk_dir=aa_bulk
md_dir=bb_mdFormat
if [ ! -d ${md_dir} ]; then
	echo "#----> mkdir -p ${md_dir}"
	mkdir -p ${md_dir}
fi
echo "#----> rsync -avzr ${bulk_dir}/* ${md_dir}"
rsync -avzr ${bulk_dir}/* ${md_dir}
cat <<__EOF__
#----> ls ${md_dir}
$(ls ${md_dir})

#----> ${md_dir} 의 파일 내용을 Markdown 포맷으로 수정해야 합니다.

__EOF__
