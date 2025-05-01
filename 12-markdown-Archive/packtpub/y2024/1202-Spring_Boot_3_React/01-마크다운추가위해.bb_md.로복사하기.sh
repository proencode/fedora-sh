#!/bin/sh

aa_bulk_OK_dir="aa_bulk_OK_dir"
if [ ! -d ${aa_bulk_OK_dir} ]; then
	echo "#-- ${aa_bulk_OK_dir} 폴더가 없으므로 작업을 중단합니다."
	exit -1
fi

bb_md_made_dir="bb_md_made_dir"
if [ ! -d ${bb_md_made_dir} ]; then
	echo "#-- mkdir -p ${bb_md_made_dir}"
	mkdir -p ${bb_md_made_dir}
fi

#--
#-- (1-5) 책에 맞추어 수정하는 부분.
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
Publisher="packtpub" #-- (1) 출판사 --
BookJemok="Full Stack Development with Spring Boot 3 and React 4Ed" #-- 책 이름
TypingYear="2024" #-- 입력년도
TypingMmDd="1202" #-- 입력월일
TypingJemok="Spring Boot 3 React" #-- 짧은 제목
AuthorDate="Juha Hinkula / Oct 2023 / 454 pages 4Ed" #-- 저자등 설명
https_line="https://subscription.packtpub.com/book/web-development/9781805122463/pref" #-- 책 링크
img_dir="img-${Publisher}_${TypingYear}_${TypingMmDd}" #-- 이미지 저장 폴더
if [ ! -d ${img_dir} ]; then
	echo "#-- mkdir -p ${img_dir}"
	mkdir -p ${img_dir}
fi
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--
echo "#----> rsync -avzr ${aa_bulk_OK_dir}/* ${bb_md_made_dir}"
rsync -avzr ${aa_bulk_OK_dir}/* ${bb_md_made_dir}
cat <<__EOF__
#----> ls ${bb_md_made_dir}
$(ls ${bb_md_made_dir})

#----> ${bb_md_made_dir} 의 파일 내용을 Markdown 포맷으로 수정해야 합니다.

__EOF__
