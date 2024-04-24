#!/bin/sh

#-- fff "1.53" "Searching Django workshop"
fff () {
	FigureNumber=$1
	FigureTitle=$2

	FigureMemo="${FigureNumber} ${FigureTitle}"
	small_FigureMemo=$(echo "${FigureMemo,,}" | sed 's/ /_/g')
	cat <<__EOF__
![ ${FigureMemo} ](/${small_Publisher}/${img_dir}/${small_FigureMemo}.webp)
${FigureMemo}

----> press Enter:
__EOF__
	read a
}

#-- figure_title_made "1.53" "Searching Django workshop"
#--
#-- Figure 1.53 – Searching Django workshop
#-- "Figure" "1.53" " – " "Searching Django workshop"
#-- _____(1) "1_53" __(2) "searching_django_workshop" ___(3) .webp
#--
#-- ![ Figure 1.53 – Searching Django workshop
#-- ---^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ----------------------------------- _____
#-- ](/packtpub/2024/422-web_development_with_django/1_53-searching_django_workshop.webp)
#--    ^^^^^^^^ |||| +++++++++++++++++++++++++++++++ //// -------------------------
#-- 
#-- ![ Figure 1.53 – Searching Django workshop ](/packtpub/2024/422-web_develo..
#-- ..pment_with_django/1_53-searching_django_workshop.webp)

#-- (1-2) 책에 맞추어 수정하는 부분.
#--

Publisher="packtpub" #-- (1) 출판사 --
BookYear="2024" #-- (2-1) 등록년도
BookTitle="422 Web Development with Django 2ed" #-- (2-2) 시작월일 + 책 제목 --
Year_Title="${BookYear}/${BookTitle}" #-- (2) 호스트의 경로
ShortDescription="Publication date: May 2023 Publisher Packt Pages 764" #-- (3) 저자등 설명 --
tags="Django" #-- (4) 찾기 위한 태그 --
https_line="https://subscription.packtpub.com/book/web-development/9781803230603/pref" #-- (5) 출판사 홈페이지 링크 --
#--
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
small_YearTitle=$(echo "${Year_Title,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
img_dir="${small_YearTitle}_img"
if [ ! -d ${img_dir} ]; then
	mkdir -p ${img_dir}
fi
#--
#-- (6) 사진번호, 사진제목 및 설명 중 일부 --
fff "1.53" "Searching Django workshop"
#--
