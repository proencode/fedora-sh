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
BookCover="Taking Flutter to the Web" #-- (2) 책 제목 --

small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')

#----------- (3) 권번호, 사진번호, 사진제목 및 설명 중 일부 --
# figure_title_made "00" "00" "Preface"

# figure_title_made "02" "00" "Figure 1.1 – Flutter, a cross-platform UI framework"
# figure_title_made "02" "01" "Figure 1.2 – Flutter Demo Home Page"

# figure_title_made "03" "00" "Figure 2.1 – Home page with header"
# figure_title_made "03" "01" "Figure 2.2 – Home page with course cards"
# figure_title_made "03" "02" "Figure 2.3 – Home page featured section"
# figure_title_made "03" "03" "Figure 2.4 – Call to action and footer"

