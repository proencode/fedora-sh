#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi

# https://zetawiki.com/wiki/Bash_2%EC%B0%A8%EC%9B%90_%EB%B0%B0%EC%97%B4

publisher="PacktPub" #-- 출판사
BookTitle="Modern Android 13 Development Cookbook" #-- 책 제목
ShortDescription="By Madona S. Wambua Jul 2023 322 pages" #-- 저자 발행일 등
pubdate="2307a" #-- 책 발행일의 년월 + 당월 순서 알파벳 1 글자
gendate=$(date +%y%m%d) #-- 문서작성일 = 실행일
https_line="https://subscription.packtpub.com/book/mobile/9781837634934/pref/" #-- 읽는중인 홈페이지 링크


declare -A  r0=([Code]="00"     [Name]="Preface")
declare -A  r1=([Code]="01"     [Name]="Getting Started with Modern Android Development Skills")
declare -A  r2=([Code]="02"     [Name]="Creating Screens Using a Declarative UI and Exploring Compose Principles")
declare -A  r3=([Code]="03"     [Name]="Handling the UI State in Jetpack Compose and Using Hilt")
declare -A  r4=([Code]="04"     [Name]="Navigation in Modern Android Development")
declare -A  r5=([Code]="05"     [Name]="Using DataStore to Store Data and Testing")
declare -A  r6=([Code]="06"     [Name]="Using the Room Database and Testing")
declare -A  r7=([Code]="07"     [Name]="Getting Started with WorkManager")
declare -A  r8=([Code]="08"     [Name]="Getting Started with Paging")
declare -A  r9=([Code]="09"     [Name]="Building for Large Screens")
declare -A r10=([Code]="10"     [Name]="Implementing Your First Wear OS Using Jetpack Compose")
declare -A r11=([Code]="11"     [Name]="GUI Alerts – What’s New in Menus, Dialog, Toast, Snackbars, and More in Modern Android Development")
declare -A r12=([Code]="12"     [Name]="Android Studio Tips and Tricks to Help You during Development")
declare -A r13=([Code]="13"     [Name]="Index")
declare -A r14=([Code]="14"     [Name]="Other Books You May Enjoy")
r_top=14 #--^^


declare -A MatrixTab

if [ "x$1" = "x" ]; then
	sw01="0"
	cat <<__EOF__
$1
sh $0 $1 <---- '1' 입력하면, 소문자 타이틀로 표시합니다.

__EOF__
	exit -1
fi

sw01=$1

titleCnt=0
declare -A titleCode
declare -A titleName

cat <<__EOF__
책 제목: ${BookTitle}
책 발행일의 년월 + 당월 순서 알파벳 1 글자: ${pubdate}
문서작성일: ${gendate}

보관 폴더: $(echo "${pubdate}-${BookTitle,,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")-${gendate}

----> 권번호 titleCode[] 와 권별 제목 titleName[] 을 배열에 담습니다.
__EOF__
#
for ((rNumber=0 ; rNumber <= ${r_top} ; rNumber++)) #-- for i in {0..14}
do
	for CodeNameStr in Code Name ImgDir
	do
		ref="r$rNumber[$CodeNameStr]"
		MatrixTab[$rNumber,$CodeNameStr]=${!ref}
	done
#--
	if [ "$1" = "0" ]; then
		#-- (0) 원본대로 보여준다.
		echo "----> ${MatrixTab[$rNumber,Code]} : ${MatrixTab[$rNumber,Name]} #--- 원본"
	else
	if [ "$1" = "1" ]; then
		#-- (1) 소문자로 바꾸고 공백,따옴표,컴마를 바꾼다.
		titleCode[$titleCnt]=${MatrixTab[$rNumber,Code]}
		titleName[$titleCnt]=${MatrixTab[$rNumber,Name]}
		titleCnt=$(( titleCnt + 1 ))

		mdName=$(echo "${MatrixTab[$rNumber,Code]}-${MatrixTab[$rNumber,Name],,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
		cat <<__EOF__
${mdName}
__EOF__
	fi
	fi
done
#
cat <<__EOF__
<---- 권번호 titleCode[] 와 권별 제목 titleName[] 을 배열에 담습니다.

----> 권별로 앞/뒤 페이지 이동을 위한 링크를 만듭니다.
__EOF__
for ((rNumber=0 ; rNumber <= r_top ; rNumber++))
do
	leftStr="BEGIN"
	if [ $rNumber -gt 0 ]; then
		mdName=$(echo "${titleCode[$((rNumber - 1))]}-${titleName[$((rNumber - 1))],,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
		leftStr="${cMagenta}[ ${cGreen}${titleCode[$((rNumber - 1))]}${cBlue}-${titleName[$((rNumber - 1))]} ${cMagenta}]${cBlue}(/packtpub/fdsfdsfsd/${cCyan}${mdName}"
	fi
	rightStr="END"
	if [ $rNumber -lt $r_top ]; then
		mdName=$(echo "${titleCode[$((rNumber + 1))]}-${titleName[$((rNumber + 1))],,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")
		rightStr="${cMagenta}[ ${cYellow}${titleCode[$(( rNumber + 1 ))]}${cBlue}-${titleName[$(( rNumber + 1 ))]} ${cMagenta}]${cBlue}(/packtpub/fdsfdsfsd/${cCyan}${mdName}"
	fi
	echo "${leftStr}${cReset} <--- ${cRed}${titleCode[$((rNumber))]}${cReset} ---> ${rightStr}${cReset}"
done
cat <<__EOF__
<---- 권별로 앞/뒤 페이지 이동을 위한 링크를 만듭니다.
__EOF__
