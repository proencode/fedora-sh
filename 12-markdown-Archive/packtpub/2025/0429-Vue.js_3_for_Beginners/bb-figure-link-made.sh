#!/bin/sh

figure_title_made () {
	SeqNumber=$1
	FigureNumber=$2
	FigureTitle=$3
	FigureMemo="${SeqNumber}${FigureNumber} ${FigureTitle}"

	small_FigureMemo=$(echo "${FigureMemo,,}" | sed 's/ /_/g')
	cat <<__EOF__

![ ${FigureMemo} ](/${small_Publisher}/${small_BookCover}_img/${small_FigureMemo}.webp
)
${small_FigureMemo}.webp
----> press Enter:
__EOF__
	read a
}

#-- (1-2) 책에 맞추어 수정하는 부분.
#--
Publisher="packtpub" #-- (1) 출판사 --
BookYear="2024" #-- (2-1) 등록년도
BookTitle="2409 Vue.js 3 for Beginners" #-- (2-2) 시작월일 + 책 제목 --
BookCover="${BookYear}/${BookTitle}" #-- (2) 호스트의 경로
#--
BookCover="Vue.js 3 for Beginners" #-- (2) 책 제목 --
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')
#--
#----------- (3) 권번호, 사진번호, 사진제목 및 설명 중 일부 --
figure_title_made "01" "00" "digital version of this book"
figure_title_made "03" "00" "Kotlin Types"

#--
