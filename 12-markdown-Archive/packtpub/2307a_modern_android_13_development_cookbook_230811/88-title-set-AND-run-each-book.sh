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
BookTitle="Modern Android 13 Development Cookbook" #-- 책 제목
ShortDescription="By Madona S. Wambua Jul 2023 322 pages" #-- 저자 발행일 등
pubdate="2307a" #-- 책 발행일의 년월 + 당월 순서 알파벳 1 글자
gendate=$(date +%y%m%d) #-- 문서작성일 = 실행일
https_line="https://subscription.packtpub.com/book/mobile/9781837634934/pref/" #-- 읽는중인 홈페이지 링크

LNpublisher=$(echo "${publisher,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.
LNbookTitle=$(echo "${BookTitle,,}" | sed 's/ /_/g') #-- 책 제목: 소문자로 바꾸고 공백을 밑줄로 바꾼다.

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
${cCyan}(1)
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

last_BookNumber=-444 #-- (-444)=마지막으로 선택한 권 번호가 없다.

this_code="start" #-- 권번호 + Part / Section / Chapter 번호 --> '02.p1'

until [ "x$this_code" = "xexit" ] #-- (A) 권번호 입력시 'exit' 를 입력해야 끝난다.
do
	for ((rNumber=0 ; rNumber <= r_top ; rNumber++))
	do
		echo "${cYellow}${titleCode[$((rNumber))]:0:2}${cRed}${titleCode[$((rNumber))]:2}${cBlue}-${titleName[$((rNumber))]}${cReset}"
	done

	this_code="start" #-- 권번호 + Part / Section / Chapter 번호 --> '02.p1'
	cat <<__EOF__
${cCyan}(2)
${cBlue}권 번호를 선택합니다.

----> select Number: ${cRed}[ ${cYellow}00${cBlue} ${cRed}] ${cBlue}... ${cRed}[ ${cYellow}${r_top} ${cRed}] ${cBlue}끝내려면, 'exit' 를 입력하세요.${cReset}
__EOF__
	read this_code #-- 선택한 권번호

	if [ $this_code = "exit" ]; then #-- if-A.01
		this_code="exit" #-- 권번호 + Part / Section / Chapter 번호 --> '02.p1'
	else #-- if-A.01

	if [ $this_code -lt 0 ] || [ $this_code -gt 99 ]; then #-- if-A.02
		cat <<__EOF__
----> ${cRed}[ ${cYellow}00${cBlue} ${cRed}] ${cBlue}... ${cRed}[ ${cYellow}${r_top} ${cRed}] ${cBlue}범위를 벗어나므로 작업을 끝냅니다.${cReset}
__EOF__
		this_code="exit" #-- 권번호 + Part / Section / Chapter 번호 --> '02.p1'
	else #-- if-A.02

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
		if [ $this_BookNumber > 0 ]; then
			tno=$((this_BookNumber - 1))
			left_code=${titleCode[$((tno))]}
			left_name=${titleName[$((tno))]}
			left_title="${cYellow}${left_code:0:2}${cReset}${left_code:2}-${left_name}"
		fi
		right_title="END"
		if [ $this_BookNumber < $r_top ]; then
			tno=$((this_BookNumber + 1))
			right_code=${titleCode[$((tno))]}
			right_name=${titleName[$((tno))]}
			right_title="${cYellow}${right_code:0:2}${cReset}${right_code:2}-${right_name}"
		fi
		tno=$((this_BookNumber))
		this_code=${titleCode[$((tno))]} #-- 권번호 + Part / Section / Chapter 번호 --> '02.p1'
		this_name=${titleName[$((tno))]} #-- 권의 제목
		this_title="${cYellow}${this_code:0:2}${cRed}${this_code:2}${cBlue}-${this_name}${cReset}"
		this_fileName=$(echo "${this_code}-${this_name},,}" | sed 's/ /_/g' | sed 's/’//g' | sed "s/,//g")

		BookSeq=${this_code:0:2} #-- this_code 의 0 번 문자부터 2 개의 문자를 잘라내서 담는다.
		#-- ${this_code:0:2} = "01"
		#-- ${this_code:2} = ".c1"
		#-- ${this_code:3:2} = "c1"

		cat <<__EOF__

${left_title} <--- ${this_title} ---> ${right_title}
__EOF__

		imageCntNo=0 #-- 현재의 권번호 안에서 0 부터 올라가는 사진 카운터
		imageCntZZ="0000${imageCntNo}"
		imageCnt99=${imageCntZZ:(-2)}

		# 이미지 제목
		# -----------

		old_image_jemok=${this_name}
		image_jemok=${this_name}
		until [ "x$image_jemok" = "xexit" ] #-- (B) 이미지 제목 입력
		do
			nextCntNo=$(($imageCntNo + 1))
			nextCntZZ="0000${nextCntNo}"
			nextCnt99=${nextCntZZ:(-2)}
			if (( "${imageCntNo}" < 1 )); then #-- if [ ${imageCntNo} -lt 1 ]; then
				befoCntNo=0
				befoCnt99="00"
			else
				befoCntNo=$(($imageCntNo - 1))
				befoCntZZ="0000${befoCntNo}"
				befoCnt99=${befoCntZZ:(-2)}
			fi
			LNimage_jemok=$(echo "${image_jemok,,}" | sed 's/ /_/g')
			cat <<__EOF__

${cBlue}>>>>>     ${cGreen}${this_code} ${cCyan}권의 파일이름: ${cYellow}${this_name}.md

${cCyan}----> ${cMagenta}이미지 파일의 이름 = '${cBlue}알파벳만${cMagenta} 대/소 문자' '숫자' '.' '-' '빈칸'${cReset}

${cYellow}>>>>> (7) ${cMagenta}이미지 ${cBlue}'${cYellow}${imageCnt99}${cBlue}' ${cMagenta}번째의 설명을 ${cRed}[ ${cGreen}${image_jemok} ${cRed}] ${cMagenta}이와 같이 다음줄에 입력합니다.
${cYellow}>>>>>     ${cRed}[${cGreen}${image_jemok}${cRed}] ${cMagenta}이렇게 입력한 경우, ${cBlue}![ ${cGreen}${image_jemok} ${cBlue}](/${LNpublisher}/${LNbookTitle}/${cRed}${BookSeq}${cBlue}.${cYellow}${imageCnt99}${cBlue}-${cGreen}${LNimage_jemok}${cBlue}.webp ${cMagenta}처럼 등록됩니다.
${cYellow}>>>>>     ${cRed}[ ${cGreen}exit ${cRed}]${cMagenta} 인 경우, ${cCyan}챕터 번호 ${cMagenta}입력으로 돌아갑니다.
${cYellow}>>>>>     ${cRed}[ ${cGreen}+ ${cRed}]${cMagenta} 인 경우, 챕터번호를 ${cBlue}'${cYellow}${nextCnt99}${cBlue}' 로 변경, ${cRed}[ ${cGreen}- ${cRed}]${cMagenta} 인 경우, 챕터번호를 ${cBlue}'${cYellow}${befoCnt99}${cBlue}' 로 변경,
${cYellow}>>>>>     ${cBlue}확장자를 무조건 ${cBlue}'${cYellow}.webp${cBlue}'${cMagenta} 로 붙여주므로, 이게 아니면 해당 타입까지 써주고, 결과를 수정하면 됩니다.${cReset}
${cReset}
__EOF__
			read image_jemok
			if [ "x$image_jemok" = "x" ]; then #-- if-B.01
				image_jemok=${old_image_jemok}
				cat <<__EOF__
${cUp}
${cCyan}----> ${cMagenta}다시 입력해 주세요 ~

__EOF__
			else #-- if-B.01
			echo "----$image_jemok----"
			if [ "x$image_jemok" = "x+" ]; then #-- if-B.02
				imageCntNo=$(($imageCntNo + 1))
				imageCntZZ="0000${imageCntNo}"
				imageCnt99=${imageCntZZ:(-2)}
				image_jemok=${old_image_jemok}
			else #-- if-B.02
			if [ "x$image_jemok" = "x-" ]; then #-- if-B.03
				if (( "${imageCntNo}" < 1 )); then #-- if [ ${imageCntNo} -lt 1 ]; then
					imageCntNo=0
					imageCnt99="00"
				else
					imageCntNo=$(($imageCntNo - 1))
					imageCntZZ="0000${imageCntNo}"
					imageCnt99=${imageCntZZ:(-2)}
				fi
				image_jemok=${old_image_jemok}
			else #-- if-B.03
			if [ "x$image_jemok" != "xexit" ]; then #-- if-B.04
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


> Book Title: ${this_code} ${this_name}
> Short Description: ${ShortDescription}
> Path: ${LNpublisher}/${LNbookTitle}
> this File Name: ${this_fileName}.md

> Link: ${https_line}
> Images: / ${LNpublisher} / ${LNbookTitle} /
> create: $(date +'%Y-%m-%d %a %H:%M:%S')

# ${this_code} ${ChapterName}


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

			fi #-- if [ "x$image_jemok" != "xexit" ]; then #-- if-B.04
			fi #-- if [ "x$image_jemok" = "x-" ]; then #-- if-B.03
			fi #-- if [ "x$image_jemok" = "x+" ]; then #-- if-B.02
			fi #-- if [ "x$image_jemok" = "x" ]; then #-- if-B.01

		done #-- until [ "x$image_jemok" = "xexit" ] #-- (B) 이미지 제목 입력

	fi #-- if-A.02
	fi #-- if-A.01

done #-- until [ "x$this_code" = "xexit" ] #-- (A) 권번호 입력시 'exit' 를 입력해야 끝난다.

# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----
