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

Publisher="packtpub" #-- (1) 출판사 --
BookCover="Mastering Vim" #-- (2) 책 제목 --
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')

#----------- (3) 권번호, 사진번호, 사진제목 및 설명 중 일부 --
# figure_title_made "02" "00" "Displaying a message in the browser window"

#--
