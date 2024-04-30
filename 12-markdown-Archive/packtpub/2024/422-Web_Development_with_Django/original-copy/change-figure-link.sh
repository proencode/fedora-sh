#!/bin/bash

figure_link () {
	#-- [Shell Script] 배열(array)과 Map 사용하기 2021. 7. 12. 22:25ㆍLinux
	#-- https://nuritech.tistory.com/22
	#--
	#-- figure_link "Figure 1.1 – The project directory for myproject"
	#-- ............ ----------|||-----------------------------------
	#-- ........ figure_number ||| figure_title [ ]
	#--
	#-- "Figure 1.1 - " 과 "Figure 1.15 - " 가 같이 있으므로,
	#-- " - " 를 추가한다.
	figure_number = $(echo "$1" | awk -F" - " '{print "$1 - "}')
	figure_title[ $figure_number ] = $(echo "$1" | awk -F" - " '{print $2}')
}

declare -A figure_number
declare -A figure_title
figure_seq=0

# 텍스트 파일 경로
FILEPATH="$1"
SEQ=0

# 텍스트 파일 내용을 읽음
while IFS= read -r line; do
	# 문자열 확인
	#-- if [[ $line == *"Figure "* ]]; then #-- check "figure " on any position
	if [[ $line == "Figure "* ]]; then #-- delete first asterisk (*)
		if [ $SEQ -eq 0 ]; then
			# 앞줄에 삽입 문자열 추가
			echo "![ ${line} ](---)"
			SEQ=1
		else
			SEQ=0
			echo "$line"
		fi
	else
		echo "$line"
	fi
done < "$FILEPATH"

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
#-- grep "^Figure " 01_an_introduction_to_django.md | uniq

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
