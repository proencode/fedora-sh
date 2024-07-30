#!/bin/sh

bulk_dir=aa_bulk
md_made_dir=bb_md_made
if [ ! -d ${md_made_dir} ]; then
	echo "#----> mkdir -p ${md_made_dir}"
	mkdir -p ${md_made_dir}
fi
echo "#----> rsync -avzr ${bulk_dir}/* ${md_made_dir}"
rsync -avzr ${bulk_dir}/* ${md_made_dir}
cat <<__EOF__
#----> ls ${md_made_dir}
$(ls ${md_made_dir})

#----> ${md_made_dir} 의 파일 내용을 Markdown 포맷으로 수정해야 합니다.

__EOF__
