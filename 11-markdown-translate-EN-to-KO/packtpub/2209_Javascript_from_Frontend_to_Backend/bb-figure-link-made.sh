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
__EOF__
}

Publisher="packtpub" #-- (1) 출판사
BookCover="JavaScript from Frontend to Backend" #-- (2) 책 제목
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')

#------------------SEQ--FIG--MEMO----------------
figure_title_made "02" "00" "Displaying a message in the browser window"
figure_title_made "02" "01" "Message displayed in the console"
figure_title_made "02" "02" "node -h command that displays help"
figure_title_made "02" "03" "Running a Node.js program"
figure_title_made "02" "04" "Error when modifying a constant value"
figure_title_made "02" "05" "Using the var keyword"
figure_title_made "02" "06" "Running the program under Node.js"
figure_title_made "02" "07" "The variable c defined by let is"
figure_title_made "02" "08" "The same results on the Node.js server"
figure_title_made "02" "09" "1.10 An uninitialized variable is undefined"
figure_title_made "02" "10" "1.11 Using conditional tests"
figure_title_made "02" "11" "1.12 Running the else part of the test"
figure_title_made "02" "12" "1.13 Condition with or"
figure_title_made "02" "13" "1.14 Test nesting"
figure_title_made "02" "14" "1.15 Displaying numbers from 0 to 5"
figure_title_made "02" "15" "1.16 from 0 to 5 in the browser console"
figure_title_made "02" "16" "1.17 Loop with the for statement"
figure_title_made "02" "17" "1.18 Using a function to display numbers from 1 to 10"
figure_title_made "02" "18" "1.19 Call of the display_10_first_integers function"
figure_title_made "02" "19" "1.20 Successive calls to the display_10_function"
figure_title_made "02" "20" "1.21 Calculation of the sum of the first 10 integers"
figure_title_made "02" "21" "1.22 Calculation of the sum of"
