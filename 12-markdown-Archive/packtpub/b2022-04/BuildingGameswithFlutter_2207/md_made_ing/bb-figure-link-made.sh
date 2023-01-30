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
BookCover="JavaScript from Frontend to Backend" #-- (2) 책 제목 --
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')

#----------- (3) 권번호, 사진번호, 사진제목 및 설명 중 일부 --
figure_title_made "00" "00" "Preface_Table"

figure_title_made "04" "00" "3.1 Our protagonist"
figure_title_made "04" "01" "3.2 Our game enemies"
figure_title_made "04" "02" "3.3 The gold coins"
figure_title_made "04" "03" "3.4 The game world"
figure_title_made "04" "04" "3.5 The tile map used"
figure_title_made "04" "05" "3.6 Gold Rush screen"
figure_title_made "04" "06" "3.7 The game menu screen"
figure_title_made "04" "07" "3.8 The Settings screen"
figure_title_made "04" "08" "3.9 The Game Over"
figure_title_made "04" "09" "3.10 Game screen showing"

figure_title_made "06" "00" "4.1 Sprite at 0"
figure_title_made "06" "01" "4.2 George on a white"
figure_title_made "06" "02" "4.3 Enemy sprites"
figure_title_made "06" "03" "4.4 George and the enemy"

figure_title_made "07" "00" "5.1 The game with the HUD"
figure_title_made "07" "01" "5.2 The quadrant mapping to"

figure_title_made "09" "00" "7.1 Editing a map with the"
figure_title_made "09" "01" "7.2 An image containing"
figure_title_made "09" "02" "7.3 Using the terrain images"
figure_title_made "09" "03" "7.4 The Gold Rush tile map"
figure_title_made "09" "04" "7.5 Our tile map showing the"

figure_title_made "10" "00" "8.1 The web version of the"
figure_title_made "10" "01" "8.2 Audio permissions in"

figure_title_made "12" "00" "9.1 Shadow effects on"

figure_title_made "13" "00" "10.1 Health score reduced"

figure_title_made "14" "00" "11.1 The game menu screen"
figure_title_made "14" "01" "11.2 The Settings screen"
figure_title_made "14" "02" "11.3 The game over screen"

figure_title_made "15" "00" "Flutter_for_Beginners_Second"
figure_title_made "15" "01" "Flutter_Cookbook"

