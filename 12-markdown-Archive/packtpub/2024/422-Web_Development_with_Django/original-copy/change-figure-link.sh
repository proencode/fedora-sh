#!/bin/bash

FILEPATH=""
Figure_ONLY=""
trace_ON=""
read_trace_ON="n"
read_Figure_ONLY="n"

if [ "x$3" != "x" ]; then
	FILEPATH="$1" #-- 읽어들일 파일 경로 + 파일
	Figure_ONLY="$2"
	trace_ON="$3"
else
	if [ "x$2" != "x" ]; then
		FILEPATH="$1" #-- 읽어들일 파일 경로 + 파일
		Figure_ONLY="$2"
		trace_ON="n"
		read_trace_ON="y"
	else
		if [ "x$1" != "x" ]; then
			FILEPATH="$1" #-- 읽어들일 파일 경로 + 파일
			Figure_ONLY="y"
			read_Figure_ONLY="y"
			trace_ON="n"
			read_trace_ON="y"
		fi
	fi
fi
cat <<__EOF__

$ $0 ..... (${FILEPATH}) (${Figure_ONLY}) (${trace_ON})
$ $0 ..... (.md File) (Figure_ONLY [y]) (trace_ON [n])
__EOF__

Figure_ONLY=${Figure_ONLY,,}
if [ "x$read_Figure_ONLY" = "xy" ]; then #-- argument 입력이 없으면,
	cat <<__EOF__

#----> 다 보려면  press Enter:  Figure 목록만 보려면 'y'
__EOF__
	read a
	echo "42: a=$a"
	a=${a,,}
	echo "44: a=$a=\${a}"
	if [ "x$a" != "xy" ]; then
		Figure_ONLY="n"
		echo "'n' #-- ALL LISTING. 파일 전체를 보여줍니다."
	else
		Figure_ONLY="y"
		echo "'y' #-- Figure list ONLY. Figure 목록만 보여줍니다."
	fi
fi

trace_ON=${trace_ON,,}
if [ "x$read_trace_ON" = "xy" ]; then
	cat <<__EOF__

#----> 결과만 보려면  press Enter:  작업 과정의 값도 보려면 'y'
__EOF__
	read a
	echo "61: a=$a"
	a=${a,,}
	echo "63: a=$a=\${a}"
	if [ "x$a" != "xy" ]; then
		trace_ON="n"
		echo "'n' #-- trace OFF. 결과만 보여줍니다."
	else
		trace_ON="y"
		echo "'y' #-- trace ON. 작업 과정의 값도 보여줍니다."
	fi
fi

#== cat <<__EOF__
#== 
#== #----> 경로 포함한 읽어들일 파일 이름 [ ${FILEPATH} ] 이면 press Enter:  아니면 입력:
#== __EOF__
#== read a
#== if [ "x$a" != "x" ]; then
#== 	FILEPATH=$a
#== fi
cat <<__EOF__
'${FILEPATH}' #-- 경로 포함한 읽어들일 파일 이름

__EOF__

if [ ! -f "${FILEPATH}" ]; then
	cat <<__EOF__
경로 포함한 읽어들일 '${FILEPATH}' 파일이 없으므로 중단합니다.

__EOF__
	exit 1
fi


# 기본 문법
#-- declare -A 변수
#-- 변수[key]=value
#--
# 예시
#-- declare -A map
#--
#-- map[key1]=value1
#-- map[key2]=value2

declare -A figure_image_map
declare -A figure_title_map
SPminusSP=" – "
SEQ=0

figure_link () {
	#-- [Shell Script] 배열(array)과 Map 사용하기 2021. 7. 12. 22:25ㆍLinux
	#-- https://nuritech.tistory.com/22
	#--
	#-- figure_link "Figure 1.1 – The project directory for myproject"
	#-- ............ ----------|||-----------------------------------
	#-- ............ FigNumber ||| FigTitle ----> figure_title_map [ FigNumber ]
	#--
	#-- xxx "Figure 1.1 - " 과 "Figure 1.15 - " 가 같이 있으므로,
	#-- xxx " - " 를 포함시켜서 담는다.
	#-- "Figure 1.1" 과 "Figure 1.15" 가 key 로 들어가므로 붙일 필요가 없다.
	#-- xxx FigNumber=$(echo "$1${SPminusSP}" | awk -F"${SPminusSP}" '{print $1}')
	#-- key 에 공백이 들어가면 안되므로 " " 를 "_" 로 바꾼다.
	FigNumber=$(echo "$1" | awk -F"${SPminusSP}" '{print $1}' | sed 's/ /_/g')
	FigImage=$(echo  "$1" | awk -F"${SPminusSP}" '{print $2}')
	small_FigImage=$(echo "${FigImage,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
	figure_image_map[ "$FigNumber" ]=${small_FigImage} #-- 이미지 파일의 이름을 위한것.
	FigTitle=$(echo  "$2" | awk -F"${SPminusSP}" '{print $2}')
	figure_title_map[ "$FigNumber" ]=${FigTitle} #-- 제목.

	if [ "x$trace_ON" = "xy" ]; then #-- trace --ON--
		cat <<__EOF__
26: for Image="$1"
    figure_image_map[ "$FigNumber" ] = "${figure_image_map[ $FigNumber ]}"
    figure_title_map[ "$FigNumber" ] = "${figure_title_map[ $FigNumber ]}"

#----> trace_ON: Enter to CONTINUE:
__EOF__
		read a
		echo "139: a=$a"
		a=${a,,}
		echo "141: a=$a=\${a}"
	fi
}

#--
#-- 책에 맞추어 수정하는 부분.
#--
PublisherName="packtpub" #-- (1) 출판사명 --
BookYear="2024" #-- (2) 등록년도
BookTitle="422-Web Development with Django 2ed" #-- (3) (시작월일)-(책 제목) --
#--
#-- 본문은 장 번호 (권 번호) 01 또는 001 부터 시작한다.
#--           ++++---- 이 장의 Chapter 번호
#--           |||| ++++++++---- 이 장의 Chapter 제목
#--           |||| ||||||||
#-- md_Create "01" "An Introduction to Django"
#-- 이 스크립트는 장 별로 따로따로 만들고 있으므로, 여기에 해당하는 장의 번호를 지정한다.
ChapterSeq="01"
#--

small_PublisherName=$(echo "${PublisherName,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
BookLink="${BookYear}/${BookTitle}" #-- 호스트의 경로
small_BookLink=$(echo "${BookLink,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
small_ChapterSeq=$(echo "${ChapterSeq,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
image_dir="/${small_PublisherName}/${small_BookLink}_img/${small_ChapterSeq}"

#--
#-- grep "^Figure " 01_an_introduction_to_django.md | uniq #-- 아래 선언을 만들기 위한 스크립트.
#--
#-- "Figure 1.1 – The ..."
#-- -----------^^^-------- 의 " - " 대신, 위에서 선언한 SPminusSP 를 사용한다.
#--
#-- 이미지의 이름을 3-4 단어 정도의 적당한 선에서 잘라준다.
figure_link "Figure 1.1 – The project directory" \
    "Figure 1.1 – The project directory for myproject"
figure_link "Figure 1.2 – The Django welcome" \
    "Figure 1.2 – The Django welcome screen"
figure_link "Figure 1.3 – Editing a single book" \
    "Figure 1.3 – Editing a single book or review"
figure_link "Figure 1.4 – Viewing multiple books" \
    "Figure 1.4 – Viewing multiple books or reviews"
figure_link "Figure 1.5 – A view sending data to" \
    "Figure 1.5 – A view sending data to a template without a model"
figure_link "Figure 1.6 – An HTTP request and an" \
    "Figure 1.6 – An HTTP request and an HTTP response"
figure_link "Figure 1.7 – The request and response" \
    "Figure 1.7 – The request and response flow"
figure_link "Figure 1.8 – The project directory" \
    "Figure 1.8 – The project directory for myproject"
figure_link "Figure 1.9 – The myproject package" \
    "Figure 1.9 – The myproject package (inside the myproject project directory)"
figure_link "Figure 1.10 – The contents of the" \
    "Figure 1.10 – The contents of the myapp app directory"
figure_link "Figure 1.11 – The PyCharm welcome" \
    "Figure 1.11 – The PyCharm welcome screen"
figure_link "Figure 1.12 – PyCharm’s Trust Project" \
    "Figure 1.12 – PyCharm’s Trust Project dialog"
figure_link "Figure 1.13 – The PyCharm project pane" \
    "Figure 1.13 – The PyCharm project pane"
figure_link "Figure 1.14 – The project interpreter" \
    "Figure 1.14 – The project interpreter settings"
figure_link "Figure 1.15 – The Add Python Interpreter" \
    "Figure 1.15 – The Add Python Interpreter window"
figure_link "Figure 1.16 – Packages in the virtual" \
    "Figure 1.16 – Packages in the virtual environment are listed"
figure_link "Figure 1.17 – The Add Configuration" \
    "Figure 1.17 – The Add Configuration… button in the top right of the PyCharm window"
figure_link "Figure 1.18 – Adding a new Python" \
    "Figure 1.18 – Adding a new Python configuration in the Run/Debug Configurations window"
figure_link "Figure 1.19 – The configuration settings" \
    "Figure 1.19 – The configuration settings"
figure_link "Figure 1.20 – Django development server" \
    "Figure 1.20 – Django development server configuration with the Play, Debug, and Stop buttons"
figure_link "Figure 1.21 – The console with the Django" \
    "Figure 1.21 – The console with the Django development server running"
figure_link "Figure 1.22 – The default urls.py file" \
    "Figure 1.22 – The default urls.py file"
figure_link "Figure 1.23 – The views.py default content" \
    "Figure 1.23 – The views.py default content"
figure_link "Figure 1.24 – The contents of views.py" \
    "Figure 1.24 – The contents of views.py after editing"
figure_link "Figure 1.25 – urls.py after editing" \
    "Figure 1.25 – urls.py after editing"
figure_link "Figure 1.26 – The web browser should now " \
    "Figure 1.26 – The web browser should now display the Hello, world! message"
figure_link "Figure 1.27 – The updated views.py reading" \
    "Figure 1.27 – The updated views.py reading name parameter"
figure_link "Figure 1.28 – Setting the name in the URL" \
    "Figure 1.28 – Setting the name in the URL"
figure_link "Figure 1.29 – Setting multiple names in" \
    "Figure 1.29 – Setting multiple names in the URL"
figure_link "Figure 1.30 – No name set in the URL" \
    "Figure 1.30 – No name set in the URL"
figure_link "Figure 1.31 – The reviews app added to" \
    "Figure 1.31 – The reviews app added to settings.py"
figure_link "Figure 1.32 – Creating a new directory" \
    "Figure 1.32 – Creating a new directory inside the reviews directory"
figure_link "Figure 1.33 – Naming the directory" \
    "Figure 1.33 – Naming the directory templates"
figure_link "Figure 1.34 – Creating a new HTML file" \
    "Figure 1.34 – Creating a new HTML file in the templates directory"
figure_link "Figure 1.35 – The new HTML file window" \
    "Figure 1.35 – The new HTML file window"
figure_link "Figure 1.36 – The base.html template" \
    "Figure 1.36 – The base.html template with some example text"
figure_link "Figure 1.37 – The completed view.py with" \
    "Figure 1.37 – The completed view.py with the template render"
figure_link "Figure 1.38 – Your first rendered HTML" \
    "Figure 1.38 – Your first rendered HTML template"
figure_link "Figure 1.39 – No value is rendered in" \
    "Figure 1.39 – No value is rendered in the template because no context was set"
figure_link "Figure 1.40 – views.py with the name" \
    "Figure 1.40 – views.py with the name variable set in the render context"
figure_link "Figure 1.41 – A template rendered with" \
    "Figure 1.41 – A template rendered with a variable"
figure_link "Figure 1.42 – A Django exception screen" \
    "Figure 1.42 – A Django exception screen"
figure_link "Figure 1.43 – The line that caused" \
    "Figure 1.43 – The line that caused the exception"
figure_link "Figure 1.44 – The Stop button in" \
    "Figure 1.44 – The Stop button in the top-right corner of the PyCharm window"
figure_link "Figure 1.45 – A breakpoint on line" \
    "Figure 1.45 – A breakpoint on line 5"
figure_link "Figure 1.46 – The debugger paused" \
    "Figure 1.46 – The debugger paused with the current line (5) highlighted"
figure_link "Figure 1.47 – The attributes of" \
    "Figure 1.47 – The attributes of the request variable"
figure_link "Figure 1.48 – The actions bar" \
    "Figure 1.48 – The actions bar"
figure_link "Figure 1.49 – The new variable" \
    "Figure 1.49 – The new variable name is now in scope, with the world value"
figure_link "Figure 1.50 – Actions to control" \
    "Figure 1.50 – Actions to control execution – the green play icon is the Resume Program button"
figure_link "Figure 1.51 – Clicking the breakpoint" \
    "Figure 1.51 – Clicking the breakpoint that was on line 5 disables it"
figure_link "Figure 1.52 – The Bookr welcome page" \
    "Figure 1.52 – The Bookr welcome page"
figure_link "Figure 1.53 – Searching Django workshop" \
    "Figure 1.53 – Searching Django workshop"
figure_link "Figure 1.54 – Note how HTML characters" \
    "Figure 1.54 – Note how HTML characters are escaped so that we are protected from tag injection"

#-- END OF 링크값 선언.

if [ "x$trace_ON" = "xy" ]; then #-- trace --ON--
	for key in ${!figure_title_map[@]}; do
		value=${key}
		echo "58: figure_title_map:$key, value:$value"
	done
	echo "#----> trace_ON: Enter to CONTINUE:"
	read a
	echo "292: a=$a"
	a=${a,,}
	echo "294: a=$a=\${a}"
fi



# 텍스트 파일 내용을 한줄씩 $line 으로 읽음
while IFS= read -r line; do
	# 문자열 확인
	#------------------vvvvvvvvvvv--- *"figure "* 문자열이 어느 위치든지 찾는다.
	#-- if [[ $line == *"Figure "* ]]; then
	#--------------vvvvvvvvvv--- "figure "* 문자열이 맨 앞에 있는것만 찾는다.
	if [[ $line == "Figure "* ]]; then
		if [ $SEQ -eq 0 ]; then
			#-- 앞줄에 삽입 문자열 추가 --
			#-- key 에 공백이 들어가면 안되므로 " " 를 "_" 로 바꾼다.
			lines_number=$(echo "$line" | awk -F"${SPminusSP}" '{print $1}' | sed 's/ /_/g')
			small_lines_number=$(echo "${lines_number,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
			lines_image=${small_lines_number}-${figure_image_map[ $lines_number ]}
			lines_title=${figure_title_map[ $lines_number ]}

			if [ "x$trace_ON" = "xy" ]; then #-- trace --ON--
				cat <<__EOF__
79: ----> \$figure_title_map[ ---- \"${lines_number}\" ---- ] <----"
    ----> $figure_title_map[ \"${lines_number}\" ] <----"

#----> trace_ON: Enter to CONTINUE:
__EOF__
				read a
				echo "321: a=$a"
				a=${a,,}
				echo "323: a=$a=\${a}"
			fi

			#-- 링크를 출력하는데 이미지 타입을 .webp 로 고정했으므로 확인해야 한다.
			cat <<__EOF__
![ ${lines_title} ](${image_dir}/${lines_image}.webp)
__EOF__
			if [ "x$Figure_ONLY" = "xy" ]; then #-- ONLY Figure
				cat <<__EOF__

${lines_title}

${image_dir}/${lines_image}.webp

${lines_image}.webp

#----> Figure_ONLY: [ $Figure_ONLY ]
a [ $a ]
while IFS= read -r line; do
${line}
while IFS= read -r line; do



read a
__EOF__
				read a
				echo "345: a=$a"
				a=${a,,}
				echo "347: a=$a=\${a}"
			fi
			if [ "x$trace_ON" = "xy" ]; then #-- trace --ON--
				cat <<__EOF__
90: ---->
lines_title=\$figure_title_map[ \${lines_number} ]
lines_title=\$figure_title_map[ ${lines_number} ]
lines_title=${figure_title_map[ $lines_number ]}
\${lines_title}="""${lines_title}"""

\${image_dir} ${image_dir}
\${lines_number} ${lines_number}
\${image_dir}/\${lines_number}.webp) ${image_dir}/${lines_number}.webp)
![ ${lines_title} ](${image_dir}/${lines_number}.webp)
    <----

#----> trace_ON: Enter to CONTINUE:
__EOF__
				read a
				echo "365: a=$a"
				a=${a,,}
				echo "367: a=$a=\${a}"
			fi
			SEQ=1
		else
			SEQ=0
			if [ "x$Figure_ONLY" = "xn" ]; then #-- ALL LISTING
				echo "$line" #-- 원본대로 출력한다.
			fi
		fi
	else
		if [ "x$Figure_ONLY" = "xn" ]; then #-- ALL LISTING
			echo "$line" #-- 원본대로 출력한다.
		fi
	fi
done < "${FILEPATH}"

if [ "x$trace_ON" = "xy" ]; then #-- trace --ON--
	echo "114: for key in ${!figure_title_map[@]}; do"
	for key in ${!figure_title_map[@]}; do
		echo "     value=\"${key}\""
		value="${figure_title_map[ $key ]}"
		echo "     figure_title_map keyr=$key, value=$value"
	done
	echo "#----> trace_ON: Enter to CONTINUE:"
	read a
	echo "392: a=$a"
	a=${a,,}
	echo "394: a=$a=\${a}"
fi

echo "----> FILEPAtH ${FILEPATH}; Figure_ONLY ${Figure_ONLY}; trace_ON ${trace_ON}; read_trace_ON ${read_trace_ON}; read_Figure_ONLY ${read_Figure_ONLY};"
