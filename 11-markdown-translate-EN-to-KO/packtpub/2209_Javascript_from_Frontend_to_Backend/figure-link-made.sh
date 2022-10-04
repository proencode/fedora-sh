#!/bin/sh

figure_title_made () {
	SeqNumber=$1
	FigureNumber=$2
	FigureTitle=$3
	FigureMemo="${SeqNumber}${FigureNumber} ${FigureTitle}"

	small_FigureMemo=$(echo "${FigureMemo,,}" | sed 's/ /_/g')
	cat <<__EOF__

![ ${FigureMemo} ](/${small_Publisher}/${small_BookCover}_img/${small_FigureMemo}.webp
__EOF__
}

Publisher="packtpub" #-- (1) 출판사
BookCover="JavaScript from Frontend to Backend" #-- (2) 책 제목
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')

#------------------SEQ--FIG--MEMO----------------
figure_title_made "01" "00" "covered in the book"
