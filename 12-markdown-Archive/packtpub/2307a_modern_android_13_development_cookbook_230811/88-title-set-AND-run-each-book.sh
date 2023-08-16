#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi
MEMO="권별 (+장별) 로 작업하는 책에 있는 그림파일 이름 만들기"

cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__

# https://zetawiki.com/wiki/Bash_2%EC%B0%A8%EC%9B%90_%EB%B0%B0%EC%97%B4

#-- 다음의 열한줄을 복사해서 아래에 붙여놓고 해당 책에 맞추어 입력한다.
# publisher="
# " #-- 출판사
# BookTitle="
# " #-- 책 제목
# ShortDescription="
# " #-- 저자 발행일 등
# pubdate="
# " #-- 책 발행일의 년월 + 당월 순서 알파벳 1 글자
# gendate=$(date +%y%m%d) #-- 문서작성일 = 실행일
# https_line="
# " #-- 읽는중인 홈페이지 링크
#

publisher="PacktPub" #-- 출판사
LNpublisher=$(echo "${publisher,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

BookTitle="Modern Android 13 Development Cookbook" #-- 책 제목
LNbookTitle=$(echo "${BookTitle,,}" | sed 's/ /_/g') #-- 책 제목: 소문자로 바꾸고 공백을 밑줄로 바꾼다.

ShortDescription="By Madona S. Wambua Jul 2023 322 pages" #-- 저자 발행일 등

pubdate="2307a" #-- 책 발행일의 년월 + 당월 순서 알파벳 1 글자
gendate=$(date +%y%m%d) #-- 문서작성일 = 실행일
https_line="https://subscription.packtpub.com/book/mobile/9781837634934/pref/" #-- 읽는중인 홈페이지 링크


declare -A  r0=([Code]="00"     [Name]="Preface")
declare -A  r1=([Code]="01.c1"  [Name]="Getting Started with Modern Android Development Skills")
declare -A  r2=([Code]="02.c2"  [Name]="Creating Screens Using a Declarative UI and Exploring Compose Principles")
declare -A  r3=([Code]="03.c3"  [Name]="Handling the UI State in Jetpack Compose and Using Hilt")
declare -A  r4=([Code]="04.c4"  [Name]="Navigation in Modern Android Development")
declare -A  r5=([Code]="05.c5"  [Name]="Using DataStore to Store Data and Testing")
declare -A  r6=([Code]="06.c6"  [Name]="Using the Room Database and Testing")
declare -A  r7=([Code]="07.c7"  [Name]="Getting Started with WorkManager")
declare -A  r8=([Code]="08.c8"  [Name]="Getting Started with Paging")
declare -A  r9=([Code]="09.c9"  [Name]="Building for Large Screens")
declare -A r10=([Code]="10.c10" [Name]="Implementing Your First Wear OS Using Jetpack Compose")
declare -A r11=([Code]="11.c11" [Name]="GUI Alerts – What’s New in Menus, Dialog, Toast, Snackbars, and More in Modern Android Development")
declare -A r12=([Code]="12.c12" [Name]="Android Studio Tips and Tricks to Help You during Development")
declare -A r13=([Code]="13"     [Name]="Index")
declare -A r14=([Code]="14"     [Name]="Other Books You May Enjoy")
r_top=14 #--^^


declare -A MatrixTab

titleCnt=0
declare -A titleCode
declare -A titleName

cat <<__EOF__
${cBlue}책 제목: ${cRed}${BookTitle}
${cBlue}책 발행일의 년월 + 당월 순서 알파벳 1 글자: ${cRed}${pubdate}
${cBlue}문서작성일: ${cRed}${gendate}
${cBlue}보관 폴더: ${cRed}$(echo "${pubdate}-${BookTitle,,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")-${gendate}
${cReset}
__EOF__

for ((rNumber=0 ; rNumber <= ${r_top} ; rNumber++)) #-- for i in {0..14}
do
	for CodeNameStr in Code Name ImgDir
	do
		ref="r$rNumber[$CodeNameStr]"
		MatrixTab[$rNumber,$CodeNameStr]=${!ref}
	done
	#-- 소문자로 바꾼다.
	titleCode[$titleCnt]=${MatrixTab[$rNumber,Code]}
	titleName[$titleCnt]=${MatrixTab[$rNumber,Name]}
	titleCnt=$(( titleCnt + 1 ))
	#-- 공백,따옴표,컴마를 바꾼다.
	mdName=$(echo "${MatrixTab[$rNumber,Code]}-${MatrixTab[$rNumber,Name],,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
done

wikiLink=$(echo "${publisher,,}/${BookTitle,,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")

last_BookNumber=-1 #-- (-1)=마지막으로 선택한 권 번호가 없다.

for ((rNumber=0 ; rNumber <= r_top ; rNumber++))
do
	echo "${cYellow}${titleCode[$((rNumber))]:0:2}${cRed}${titleCode[$((rNumber))]:2}${cBlue}-${titleName[$((rNumber))]}${cReset}"
done
cat <<__EOF__

권 번호를 선택합니다.

----> select Number: ('00' ... '${r_top}')
__EOF__
read this_BookNumber99 #-- 선택한 권번호
if [ $this_BookNumber99 -lt 0 ] || [ $this_BookNumber99 -gt 99 ]; then
	cat <<__EOF__
----> ('00' ... '${r_top}') 범위를 벗어나므로 작업을 끝냅니다.
__EOF__
	exit -1
fi
this_BookNumberZZ="0000${this_BookNumber99}"
this_BookNumber99=${this_BookNumberZZ:(-2)}
this_BookNumber=$(echo "${this_BookNumber99}" | sed -r 's/^0+//g') #-- 앞에 붙은 0 을 떼어낸다.
cat <<__EOF__
${cUp}
${cRed}[ ${cYellow}${this_BookNumber99} ${cRed}]${cReset}

__EOF__

#-- for ((rNumber=0 ; rNumber <= r_top ; rNumber++))
#-- do
#-- 	leftStr="BEGIN"
#-- 	if [ $rNumber -gt 0 ]; then
#-- 		mdName=$(echo "${titleCode[$((rNumber - 1))]}-${titleName[$((rNumber - 1))],,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
#-- 		leftStr="${cMagenta}[ ${cGreen}${titleCode[$((rNumber - 1))]}${cBlue}-${titleName[$((rNumber - 1))]} ${cMagenta}]${cBlue}(/${wikiLink}/${cCyan}${mdName}"
#-- 	fi
#-- 	rightStr="END"
#-- 	if [ $rNumber -lt $r_top ]; then
#-- 		mdName=$(echo "${titleCode[$((rNumber + 1))]}-${titleName[$((rNumber + 1))],,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
#-- 		rightStr="${cMagenta}[ ${cYellow}${titleCode[$(( rNumber + 1 ))]}${cBlue}-${titleName[$(( rNumber + 1 ))]} ${cMagenta}]${cBlue}(/${wikiLink}/${cCyan}${mdName}"
#-- 	fi
#-- 	#-- 앞뒤 링크 확인: echo "${leftStr}${cReset} <--- ${cRed}${titleCode[$((rNumber))]}${cReset} ---> ${rightStr}${cReset}"
#-- 	if [ $rNumber = $this_BookNumber ]; then
#-- 		echo "${cYellow}${titleCode[$((rNumber))]}${cCyan}-${titleName[$((rNumber))]}${cReset}"
#-- 	else
#-- 		echo "${cRed}${titleCode[$((rNumber))]}${cBlue}-${titleName[$((rNumber))]}${cReset}"
#-- 	fi
#-- done

left_title="BEGIN"
if [ $this_BookNumber -gt 0 ]; then
	tno=$((this_BookNumber - 1))
	left_code=${titleCode[$((tno))]}
	left_name=${titleName[$((tno))]}
	left_title="${cYellow}${left_code:0:2}${cReset}${left_code:2}-${left_name}"
	mdName=$(echo "${left_code}-${left_name},,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
fi
right_title="END"
if [ $this_BookNumber -lt $r_top ]; then
	tno=$((this_BookNumber + 1))
	right_code=${titleCode[$((tno))]}
	right_name=${titleName[$((tno))]}
	right_title="${cYellow}${right_code:0:2}${cReset}${right_code:2}-${right_name}"
	mdName=$(echo "${right_code}-${right_name},,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
fi
tno=$((this_BookNumber))
this_code=${titleCode[$((tno))]}
this_name=${titleName[$((tno))]}
this_title="${cYellow}${this_code:0:2}${cRed}${this_code:2}${cBlue}-${this_name}${cReset}"
cat <<__EOF__
${left_title} <--- ${this_title} ---> ${right_title}
__EOF__










cat <<__EOF__
----> press Enter:
__EOF__
read a
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


if [ "x$4" != "x" ]; then
	ChapterSeq="$4"
else
	ChapterSeq="01.c1" #-- (4) '01'= 00 또는 01 부터 시작하는 권 번호 (+ 부 'p1'=Part / 장 'c1'=Chapter / 절 's1'=Section) 번호
fi
BookSeq=${ChapterSeq:0:2} #-- ChapterSeq 의 0 번 문자부터 2 개의 문자를 잘라내서 담는다.
#-- ${ChapterSeq:0:2} = "01"
#-- ${ChapterSeq:3:2} = "c1"

imageCntNo=0 #-- 현재의 권번호 안에서 0 부터 올라가는 사진 카운터
imageCntZZ="0000${imageCntNo}"
imageCnt99=${imageCntZZ:(-2)}

if [ "x$5" != "x" ]; then
	ChapterName="$5"
else
	ChapterName="Preface" #-- (5) wiki.js 왼쪽에 표시할 챕터 제목
fi
if [ "x$6" != "x" ]; then
	old_image_jemok="$6"
else
	old_image_jemok="Android Foundation" #-- (6) 시작시 예시로 든 이미지의 일련번호 + 이름

fi
if [ "x$7" != "x" ]; then
	https_line="$7"
else
	https_line="https://subscription.packtpub.com/book/mobile/9781837634934/pref/" #-- (7) 출판사 홈페이지 링크
fi
if [ "x$8" != "x" ]; then
	tags="$8"
else
	tags="kotlin android" #-- (8) 찾기 위한 태그
fi

# ${cBlue}${CMD_NAME} ${cRed}"${publisher}"  ${cMagenta}"${BookTitle}"  ${cRed}"${ShortDescription}"  ${cMagenta}"${ChapterSeq}"  ${cRed}"${ChapterName}"  ${cMagenta}"${old_image_jemok}"  ${cRed}"${https_line}"  ${cMagenta}"${tags}"

cat <<__EOF__

${cBlue}
       publisher="${cRed}${publisher}${cBlue}"
       BookTitle="${cMagenta}${BookTitle}${cBlue}"
ShortDescription="${cRed}${ShortDescription}${cBlue}"
      ChapterSeq="${cMagenta}${ChapterSeq}${cBlue}"
     ChapterName="${cRed}${ChapterName}${cBlue}"
 old_image_jemok="${cMagenta}${old_image_jemok}${cBlue}"
      https_line="${cRed}${https_line}${cBlue}"
            tags="${cMagenta}${tags}${cBlue}"
${cReset}
__EOF__

# 01-000 Preface

# 출판사 이름
# -----------

if [ "x$1" = "x" ]; then
	#-- (대문자, 공백, - 와 _ 제외한 특수문자) 는 안됨 !
	cat <<__EOF__

${cRed}[ ${cCyan}1 ${cRed}] ${cBlue}---- packtpub
  2   ---- medium
  3   ---- docker
  4   ---- howtogeek
  5   ---- ddanzi
  6   ---- ysjn
  7   ---- gihyo

${cGreen}----> ${cCyan}출판사 이름 ${cRed}[ ${cGreen}1 ~ 6 ${cRed}]${cCyan} 또는 새로운 ${cRed}[ ${cMagenta}= 알파벳만 = ${cGreen}출판사 분류명 ${cRed}] ${cCyan}을 입력하세요.${cReset}
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		publisher="packtpub"
		echo "${cUp}"
	else
		if [ "x$a" = "x1" ]; then
			publisher="packtpub"
		else
		if [ "x$a" = "x2" ]; then
			publisher="medium"
		else
		if [ "x$a" = "x3" ]; then
			publisher="docker"
		else
	
		if [ "x$a" = "x4" ]; then
			publisher="howtogeek"
		else
		if [ "x$a" = "x5" ]; then
			publisher="ddanzi"
		else
		if [ "x$a" = "x6" ]; then
			publisher="ysjn"
		else

		if [ "x$a" = "x7" ]; then
			publisher="gihyo"
		else
			publisher="$a"
		fi
		fi
		fi

		fi
		fi
		fi

		fi
	fi
else
	a="cmd 에서 지정"
	publisher="$1"

fi
publish_no=$a

LNpublisher=$(echo "${publisher,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${publisher} ${cMagenta}] ${cBlue}출판사 이름을 정했습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
fi

# 책 제목
# -------

cat <<__EOF__
${cRed}[ ${cBlue}${publish_no} ${cYellow}${publisher} ${cBlue}= ${cYellow}${LNpublisher} ${cRed}]

${cGreen}----> (1) ${cCyan}폴더 이름으로 쓰기 위한 책 제목 Title: ${cRed}[ ${cGreen}${BookTitle} ${cRed}] ${cMagenta}= '${cBlue}알파벳만${cMagenta} 대/소 문자' '숫자' '.' '-' '빈칸'${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
	a=${BookTitle}
fi
BookTitle=$a
LNbookTitle=$(echo "${BookTitle,,}" | sed 's/ /_/g') #-- 책 제목: 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${LNpublisher} ${cBlue}/ ${cGreen}${LNbookTitle} ${cBlue}책 제목: ${cGreen}${BookTitle} ${cMagenta}] ${cBlue}책 제목을 정했습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
fi

# 설명 요약
# ---------

cat <<__EOF__
      ${cRed}[ ${cYellow}${LNpublisher} ${cBlue}/ ${cYellow}${LNbookTitle} ${cBlue}책 제목: ${cYellow}${BookTitle} ${cRed}]

${cGreen}----> (2) ${cCyan}설명 요약 Short Description: ${cRed}[ ${cGreen}${ShortDescription} ${cRed}] ${cMagenta} '한글/영문' '숫자' '.' '-' '빈칸'${cBlue})${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
	a=${ShortDescription}
fi
ShortDescription=$a

cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${ShortDescription} ${cMagenta}] ${cBlue}설명 요약을 정했습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
fi

# 원본 링크
# ---------

cat <<__EOF__
      ${cRed}[ ${cYellow}${ShortDescription} ${cRed}]

${cGreen}----> (3) ${cCyan}원본 링크 ${cRed}[ ${cGreen}${https_line} ${cRed}] ${cMagenta}= '${cBlue}알파벳만${cMagenta} 대/소 문자' '숫자' '.' '-' '빈칸'${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
	a=${https_line}
fi
https_line=$a

cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${https_line} ${cMagenta}] ${cBlue}원본 링크를 정했습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
fi

# 태그
# ---------

cat <<__EOF__
      ${cRed}[ ${cYellow}${https_line} ${cRed}]

${cGreen}----> (4) ${cCyan}태그 ${cRed}[ ${cGreen}${tags} ${cRed}] ${cMagenta}= '${cBlue}알파벳만${cMagenta} 대/소 문자' '숫자' '.' '-' '빈칸'${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	a=${tags}
	echo "${cUp}"
fi
tags=$a

cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${tags} ${cMagenta}] ${cBlue}태그를 정했습니다..${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
fi
echo "      ${cRed}[ ${cYellow}${tags} ${cRed}]${cReset}"

yesno="xxx"
until [ "x$yesno" = "xy" ]
do
	cat <<__EOF__

${cBlue}====> 계속 진행하기 위해서 ${cMagenta}[ ${cYellow}y ${cMagenta}] ${cBlue}를 눌러 주세요.${cReset}
__EOF__
	read yesno
done



# ChapterSeq="00-p1"
# ChapterName="Preface"
# ---------------------


until [ "x$ChapterSeq" = "x" ]
do
	cat <<__EOF__


$(ls -l *.md)

${cBlue}
===================
  ++-------'01'=권 번호 ('00' 또는 '01'부터 시작)
  || +----- 부 'p1'=Part / 장 'c1'=Chapter / 절 's1'=Section) 구분
  || |+---- 부, 장, 절 의 일련번호
  || ||
[ 01.c1 ] = 권 번호 (챕터 번호)
===================
${cYellow}>>>>> (5) ${cCyan}(챕터 번호)를 ${cRed}[ ${cGreen}${ChapterSeq} ${cRed}] ${cCyan}이와 같이 다음 줄에 입력합니다. ${cRed}[ ${cGreen}exit ${cRed}]${cCyan} 인 경우, 이 작업을 끝냅니다.${cReset}
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		echo "${cUp}"
		a=$ChapterSeq #-- 엔터인 경우, ChapterSeq 원래값을 그대로 갖게 하려고.
	fi
	if [ "x$a" = "xexit" ]; then #-- 'exit' 를 입력하면 끝낸다.
		ChapterSeq="" #-- 끝낸다.
		ChapterName=""
	else
		ChapterSeq=$a
		BookSeq=${ChapterSeq:0:2} #-- ChapterSeq 의 0 번 문자부터 2 개의 문자를 잘라내서 담는다.
		cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${ChapterSeq} ${cMagenta}] ${cBlue}(챕터 번호)를 정했습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}"
fi
		cat <<__EOF__
      ${cRed}[ ${cYellow}${ChapterSeq} ${cRed}]
${cBlue}
===================
${ChapterSeq} 권의 이름 (챕터 이름)
===================
${cYellow}>>>>> (6) ${cGreen}${ChapterSeq} ${cCyan}권의 요약제목 을 ${cRed}[ ${cGreen}${ChapterName} ${cRed}] ${cCyan}이와 같이 다음 줄에 입력합니다. ${cRed}[ ${cGreen}exit ${cRed}]${cBlue} 를 입력하면, 이 작업을 끝냅니다.${cReset}
__EOF__
		read a
		if [ "x$a" = "x" ]; then
			echo "${cUp}"
			a=$ChapterName
		fi
		if [ "x$a" = "xexit" ]; then
			ChapterSeq="" #-- 끝낸다.
			ChapterName=""
		else
			ChapterName=$a
			chapterSeqName="${ChapterSeq} ${ChapterName}"
			LNchapterSeqName=$(echo "${chapterSeqName,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.
			cat <<__EOF__

${cBlue}====> ${cMagenta}[ ${cGreen}${ChapterName} ${cMagenta}] ${cBlue}챕터 이름을 정했습니다.${cReset}
__EOF__
			read a
			if [ "x$a" = "x" ]; then
				echo "${cUp}"
			fi
			cat <<__EOF__
      ${cRed}[ ${cYellow}${ChapterName} ${cRed}]
__EOF__
			# 이미지 제목
			# -----------

			old_image_jemok=${ChapterName}
			image_jemok=${ChapterName}
			until [ "x$image_jemok" = "xx" ] #-- exit
			do
				nextCntNo=$(($imageCntNo + 1))
				nextCntZZ="0000${nextCntNo}"
				nextCnt99=${nextCntZZ:(-2)}
				#-- if [ ${imageCntNo} -lt 1 ]; then
				if (( "${imageCntNo}" < 1 )); then
					befoCntNo=0
					befoCnt99="00"
				else
					befoCntNo=$(($imageCntNo - 1))
					befoCntZZ="0000${befoCntNo}"
					befoCnt99=${befoCntZZ:(-2)}
				fi
				LNimage_jemok=$(echo "${image_jemok,,}" | sed 's/ /_/g')
				cat <<__EOF__

${cBlue}>>>>>     ${cGreen}${ChapterSeq} ${cCyan}권의 파일이름: ${cYellow}${LNchapterSeqName}.md

${cCyan}----> ${cMagenta}이미지 파일의 이름 = '${cBlue}알파벳만${cMagenta} 대/소 문자' '숫자' '.' '-' '빈칸'${cReset}

${cYellow}>>>>> (7) ${cMagenta}이미지 ${cBlue}'${cYellow}${imageCnt99}${cBlue}' ${cMagenta}번째의 설명을 ${cRed}[ ${cGreen}${image_jemok} ${cRed}] ${cMagenta}이와 같이 다음줄에 입력합니다.
${cYellow}>>>>>     ${cRed}[${cGreen}${image_jemok}${cRed}] ${cMagenta}이렇게 입력한 경우, ${cBlue}![ ${cGreen}${image_jemok} ${cBlue}](/${LNpublisher}/${LNbookTitle}/${cRed}${BookSeq}${cBlue}.${cYellow}${imageCnt99}${cBlue}-${cGreen}${LNimage_jemok}${cBlue}.webp ${cMagenta}처럼 등록됩니다.
${cYellow}>>>>>     ${cRed}[ ${cGreen}x ${cRed}]${cMagenta} 인 경우, ${cCyan}챕터 번호 ${cMagenta}입력으로 돌아갑니다.
${cYellow}>>>>>     ${cRed}[ ${cGreen}+ ${cRed}]${cMagenta} 인 경우, 챕터번호를 ${cBlue}'${cYellow}${nextCnt99}${cBlue}' 로 변경, ${cRed}[ ${cGreen}- ${cRed}]${cMagenta} 인 경우, 챕터번호를 ${cBlue}'${cYellow}${befoCnt99}${cBlue}' 로 변경,
${cYellow}>>>>>     ${cBlue}확장자를 무조건 ${cBlue}'${cYellow}.webp${cBlue}'${cMagenta} 로 붙여주므로, 이게 아니면 해당 타입까지 써주고, 결과를 수정하면 됩니다.${cReset}
${cReset}
__EOF__
				read image_jemok
				if [ "x$image_jemok" = "x" ]; then
					echo "${cUp}"
					image_jemok=${old_image_jemok}
					cat <<__EOF__

${cCyan}----> ${cMagenta}다시 입력해 주세요 ~

__EOF__
				else
				echo "----$image_jemok----"
				if [ "x$image_jemok" = "x+" ]; then
					imageCntNo=$(($imageCntNo + 1))
					imageCntZZ="0000${imageCntNo}"
					imageCnt99=${imageCntZZ:(-2)}
					image_jemok=${old_image_jemok}
				else
				if [ "x$image_jemok" = "x-" ]; then
					#-- if [ ${imageCntNo} -lt 1 ]; then
					if (( "${imageCntNo}" < 1 )); then
						imageCntNo=0
						imageCnt99="00"
					else
						imageCntNo=$(($imageCntNo - 1))
						imageCntZZ="0000${imageCntNo}"
						imageCnt99=${imageCntZZ:(-2)}
					fi
					image_jemok=${old_image_jemok}
				else
				if [ "x$image_jemok" != "xx" ]; then #-- exit
					old_image_jemok=${image_jemok}
					LNimage_jemok=$(echo "${image_jemok,,}" | sed 's/ /_/g') #-- 전부 대문자로 바꾸려면 ${image_jemok^^}, 전부 소문자는 ${image_jemok,,}
					cat <<__EOF__
      ${cRed}[ ${cYellow}${image_jemok} ${cRed}]

${cBlue}
/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
${cReset}
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/.^[i\`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUUUUUUUUU^[

@ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


> Title: ${BookTitle}
> Short Description: ${ShortDescription}
> Path: ${LNpublisher}/${LNbookTitle}
> tags: ${tags}
> this File Name: ${LNchapterSeqName}.md

> Chapter Name: ${ChapterSeq} ${ChapterName}
> Link: ${https_line}
> Images: / ${LNpublisher} / ${LNbookTitle} /
> create: $(date +'%Y-%m-%d %a %H:%M:%S')

# ${ChapterSeq} ${ChapterName}


${cRed}${BookSeq}${cBlue}.${cYellow}${imageCnt99}${cBlue}-${cGreen}${LNimage_jemok}${cBlue}.webp${cReset}


${cBlue}![ ${cGreen}${image_jemok} ${cBlue}](/${LNpublisher}/${LNbookTitle}/${cRed}${BookSeq}${cBlue}.${cYellow}${imageCnt99}${cBlue}-${cGreen}${LNimage_jemok}${cBlue}.webp${cReset})

${cBlue}
/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
${cBlue}
----> 윗줄을 복사해서 사용합니다.
${cReset}
__EOF__
					imageCntNo=$(($imageCntNo + 1))
					imageCntZZ="0000${imageCntNo}"
					imageCnt99=${imageCntZZ:(-2)}
				fi
				fi
				fi
				fi
			done #-- until [ "x$image_jemok" = "x" ]
		fi #-- if [ "x$a" = "x" ]; then #-- 요약제목 없으면,

	fi #-- ChapterSeq="" 이므로 끝낸다.

done #-- until [ "x$ChapterSeq" = "x" ]


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
