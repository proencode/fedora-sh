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

# figure_title_made "04" "00" "Figure 3.1 – The featured section on a large screen"
# figure_title_made "04" "01" "Figure 3.2 – The featured section on a small screen"
# figure_title_made "04" "02" "Figure 3.3 – The footer on a large screen"
# figure_title_made "04" "03" "Figure 3.4 – The footer on a small screen"
# figure_title_made "04" "04" "Figure 3.5 – The button on small and large screens"
# figure_title_made "04" "05" "Figure 3.6 – Top navigation on a large screen"
# figure_title_made "04" "06" "Figure 3.7 – Side navigation on a small screen"

# figure_title_made "05" "00" "Figure 4.1 – Flutter architecture layers"
# figure_title_made "05" "01" "Figure 4.2 – Flutter web layered architecture"

figure_title_made "07" "00" "Figure 5.1 – About page"
figure_title_made "07" "02" "Figure 5.2 – Named URL route"
figure_title_made "07" "03" "Figure 5.3 – Navigator 2.0"
