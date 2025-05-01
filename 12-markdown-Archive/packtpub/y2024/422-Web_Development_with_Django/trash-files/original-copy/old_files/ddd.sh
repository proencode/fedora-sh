#!/bin/bash

FILEPATH="$1" #-- 읽어들일 파일 경로 + 파일

if [ ! -f "${FILEPATH}" ]; then
	echo "#----> $0 \"${FILEPATH}\" <---- 처리할 .md 최초의 원본 파일을 지정해야 합니다."
	exit -1
fi

declare -A figure_title_map
SPminusSP=" – "
SEQ=0
check_echo_ok="no" #-- "yes" 면 확인용 echo 를 실행한다.

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
	FigTitle=$(echo  "$1" | awk -F"${SPminusSP}" '{print $2}')
	figure_title_map[ "$FigNumber" ]=${FigTitle}
	if [ "x$check_echo_ok" = "xyes" ]; then #-- "yes" 면 확인용 echo 를 실행한다.
		cat <<__EOF__
26: figure_link="$1"
    figure_title_map[ "$FigNumber" ] = "${figure_title_map[ $FigNumber ]}"

__EOF__
	fi
}

# 기본 문법
#-- declare -A 변수
#-- 변수[key]=value
#--
# 예시
#-- declare -A map
#--
#-- map[key1]=value1
#-- map[key2]=value2
#--
#-- grep "^Figure " 01_an_introduction_to_django.md | uniq #-- 아래 선언을 만들기 위한 스크립트.

#-- 링크값 선언.

#-- "Figure 1.1 – The ..." 의 " - " 대신, 위에서 선언한 SPminusSP 를 사용한다.
#--
figure_link "Figure 1.1 – The project directory for myproject"
figure_link "Figure 1.2 – The Django welcome screen"
figure_link "Figure 1.3 – Editing a single book or review"
figure_link "Figure 1.4 – Viewing multiple books or reviews"
figure_link "Figure 1.5 – A view sending data to a template without a model"
figure_link "Figure 1.6 – An HTTP request and an HTTP response"
figure_link "Figure 1.7 – The request and response flow"
figure_link "Figure 1.8 – The project directory for myproject"
figure_link "Figure 1.9 – The myproject package (inside the myproject project directory)"
figure_link "Figure 1.10 – The contents of the myapp app directory"
figure_link "Figure 1.11 – The PyCharm welcome screen"
figure_link "Figure 1.12 – PyCharm’s Trust Project dialog"
figure_link "Figure 1.13 – The PyCharm project pane"
figure_link "Figure 1.14 – The project interpreter settings"
figure_link "Figure 1.14 – The project interpreter settings"
figure_link "Figure 1.15 – The Add Python Interpreter window"
figure_link "Figure 1.16 – Packages in the virtual environment are listed"
figure_link "Figure 1.17 – The Add Configuration… button in the top right of the PyCharm window"
figure_link "Figure 1.18 – Adding a new Python configuration in the Run/Debug Configurations window"
figure_link "Figure 1.19 – The configuration settings"
figure_link "Figure 1.20 – Django development server configuration with the Play, Debug, and Stop buttons"
figure_link "Figure 1.21 – The console with the Django development server running"
figure_link "Figure 1.22 – The default urls.py file"
figure_link "Figure 1.23 – The views.py default content"
figure_link "Figure 1.24 – The contents of views.py after editing"
figure_link "Figure 1.25 – urls.py after editing"
figure_link "Figure 1.26 – The web browser should now display the Hello, world! message"
figure_link "Figure 1.27 – The updated views.py reading name parameter"
figure_link "Figure 1.28 – Setting the name in the URL"
figure_link "Figure 1.29 – Setting multiple names in the URL"
figure_link "Figure 1.30 – No name set in the URL"
figure_link "Figure 1.31 – The reviews app added to settings.py"
figure_link "Figure 1.32 – Creating a new directory inside the reviews directory"
figure_link "Figure 1.33 – Naming the directory templates"
figure_link "Figure 1.34 – Creating a new HTML file in the templates directory"
figure_link "Figure 1.35 – The new HTML file window"
figure_link "Figure 1.36 – The base.html template with some example text"
figure_link "Figure 1.37 – The completed view.py with the template render"
figure_link "Figure 1.38 – Your first rendered HTML template"
figure_link "Figure 1.39 – No value is rendered in the template because no context was set"
figure_link "Figure 1.40 – views.py with the name variable set in the render context"
figure_link "Figure 1.41 – A template rendered with a variable"
figure_link "Figure 1.42 – A Django exception screen"
figure_link "Figure 1.43 – The line that caused the exception"
figure_link "Figure 1.44 – The Stop button in the top-right corner of the PyCharm window"
figure_link "Figure 1.45 – A breakpoint on line 5"
figure_link "Figure 1.46 – The debugger paused with the current line (5) highlighted"
figure_link "Figure 1.47 – The attributes of the request variable"
figure_link "Figure 1.48 – The actions bar"
figure_link "Figure 1.49 – The new variable name is now in scope, with the world value"
figure_link "Figure 1.50 – Actions to control execution – the green play icon is the Resume Program button"
figure_link "Figure 1.51 – Clicking the breakpoint that was on line 5 disables it"
figure_link "Figure 1.52 – The Bookr welcome page"
figure_link "Figure 1.53 – Searching Django workshop"
figure_link "Figure 1.54 – Note how HTML characters are escaped so that we are protected from tag injection"

#-- END OF 링크값 선언.

if [ "x$check_echo_ok" = "xyes" ]; then #-- "yes" 면 확인용 echo 를 실행한다.
	for key in ${!figure_title_map[@]}; do
		value=${key}
		echo "58: figure_title_map:$key, value:$value"
	done
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
			lines_title=${figure_title_map[ $lines_number ]}

			if [ "x$check_echo_ok" = "xyes" ]; then #-- "yes" 면 확인용 echo 를 실행한다.
				cat <<__EOF__
79: ----> \$figure_title_map[ ---- \"${lines_number}\" ---- ] <----"
    ----> $figure_title_map[ \"${lines_number}\" ] <----"
__EOF__
			fi

			#-- 링크를 출력하는데 이미지 타입을 .webp 로 고정했으므로 확인해야 한다.
			cat <<__EOF__
![ ${lines_title} ](${wiki_link}/${lines_number}.webp)
__EOF__
			if [ "x$check_echo_ok" = "xyes" ]; then #-- "yes" 면 확인용 echo 를 실행한다.
				cat <<__EOF__
90: ---->
lines_title=\$figure_title_map[ \${lines_number} ]
lines_title=\$figure_title_map[ ${lines_number} ]
lines_title=${figure_title_map[ $lines_number ]}
\${lines_title}="""${lines_title}"""

\${wiki_link} ${wiki_link}
\${lines_number} ${lines_number}
\${wiki_link}/\${lines_number}.webp) ${wiki_link}/${lines_number}.webp)
![ ${lines_title} ](${wiki_link}/${lines_number}.webp)
    <----
__EOF__
			fi
			SEQ=1
		else
			SEQ=0
			echo "$line" #-- 원본대로 출력한다.
		fi
	else
		echo "$line" #-- 원본대로 출력한다.
	fi
done < "${FILEPATH}"

if [ "x$check_echo_ok" = "xyes" ]; then #-- "yes" 면 확인용 echo 를 실행한다.
	echo "114: for key in ${!figure_title_map[@]}; do"
	for key in ${!figure_title_map[@]}; do
		echo "     value=\"${key}\""
		value="${figure_title_map[ $key ]}"
		echo "     figure_title_map keyr=$key, value=$value"
	done
fi

