#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi
MEMO="권별 (+장별) 로 작업하는 책에 있는 그림파일 이름 만들기"

cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__

# https://zetawiki.com/wiki/Bash_2%EC%B0%A8%EC%9B%90_%EB%B0%B0%EC%97%B4

#-- 다음의 열한줄을 복사해서 아래에 붙여놓고 해당 책에 맞추어 입력한다.
# PublisherName="
# " #-- 출판사
# TitleName="
# " #-- 책 제목
# ShortDescription="
# " #-- 저자 발행일 등
# pubdate="
# " #-- 책 발행일의 년월 + 당월 순서 알파벳 1 글자
# gendate="
# " #-- 문서작성일 = 실행일
# https_line="
# " #-- 읽는중인 홈페이지 링크
#

PublisherName="PacktPub" #-- 출판사
TitleName="Modern Android 13 Development Cookbook" #-- 책 제목
pubdate="2307a" #-- 책 발행일의 년월 + 당월 순서 알파벳 1 글자
gendate="230811" #-- 문서작성일 = 실행일
ShortDescription="By Madona S. Wambua Jul 2023 322 pages" #-- 저자 발행일 등
https_line="https://subscription.packtpub.com/book/mobile/9781803235578/pref" #-- 읽는중인 홈페이지 링크
image_type="webp" #-- 파일 사이즈가 작으므로 webp 를 사용한다.

PublisherDir=$(echo "${PublisherName,,}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g") #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.
#-- perl 의 chomp 와 같이 문자열의 앞뒤에 있는 공백만 제거하려면; 출처: https://free-jonathan.tistory.com/9 -> http://greenfinger.tistory.com/m/237
TitleName3word=$(echo ${TitleName,,} | awk '{print $1" "$2" "$3" "}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- 폴더 이름으로 쓰기 위한 3단어
DateTitle3wordDir=$(echo "${pubdate}_${TitleName3word}_${gendate}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g") #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

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
(1) ---->
${cBlue}책 제목: ${cRed}${TitleName}
${cBlue}책 발행일의 년월 + 당월 순서 알파벳 1 글자: ${cRed}${pubdate}
${cBlue}문서작성일: ${cRed}${gendate}
${cBlue}보관 폴더: ${cRed}${DateTitle3wordDir}
${cReset}
__EOF__

for ((rNumber=0 ; rNumber <= ${r_top} ; rNumber++)) #-- for i in {0..14}
do
	for CodeNameStr in Code Name
	do
		ref="r$rNumber[$CodeNameStr]"
		MatrixTab[$rNumber,$CodeNameStr]=${!ref}
	done
	titleCode[$titleCnt]=${MatrixTab[$rNumber,Code]}
	titleName[$titleCnt]=${MatrixTab[$rNumber,Name]}
	titleCnt=$(( titleCnt + 1 ))
done

Gwon_Enter="start" #-- 입력받은 권번호

until [ "x$Gwon_Enter" = "xxx" ] #-- (A) 권번호 입력시 'xx' 를 입력해야 끝난다.
do
	##-- 전체 목록을 보여준다.
	for ((rNumber=0 ; rNumber <= r_top ; rNumber++))
	do
		echo "${cYellow}${titleCode[$((rNumber))]:0:2}${cRed}${titleCode[$((rNumber))]:2}${cBlue}_${titleName[$((rNumber))]}${cReset}"
	done

	Gwon_Enter="start" #-- 입력받은 권번호
	cat <<__EOF__

(2) ${cBlue}----> 권 번호를 선택합니다.  ${cRed}[ ${cYellow}00${cBlue} ${cRed}] ${cBlue}... ${cRed}[ ${cYellow}${r_top} ${cRed}]${cBlue}
          끝내려면, ${cRed}[ ${cYellow}xx ${cRed}] ${cBlue} 즉, '${cCyan}x 두개${cBlue}' 를 입력하세요.${cReset}
__EOF__
	read Gwon_Enter #-- 입력받은 권번호

	if [ $Gwon_Enter = "xx" ]; then #-- if-A.01
		Gwon_Enter="xx" #-- 입력받은 권번호
	else #-- if-A.01

	if [ $Gwon_Enter -lt 0 ] || [ $Gwon_Enter -gt 99 ]; then #-- if-A.02
		cat <<__EOF__
(2a) ----> ${cRed}[ ${cYellow}00${cBlue} ${cRed}] ${cBlue}... ${cRed}[ ${cYellow}${r_top} ${cRed}] ${cBlue}범위를 벗어나므로 작업을 끝냅니다.${cReset}
__EOF__
		Gwon_Enter="xx" #-- 입력받은 권번호
	else #-- if-A.02

		GwonNumberZZ="0000${Gwon_Enter:0:2}"
		GwonNumber99=${GwonNumberZZ:(-2)}
		#-- '0' 일때는 '' 로 되므로 아래로 대신한다. GwonNumber=$(echo "${GwonNumber99}" | sed -r 's/^0+//g') #-- 앞에 붙은 0 을 떼어낸다.
		GwonNumber=$((GwonNumber99))

		cat <<__EOF__
${cUp}
${cRed}[ ${cYellow}${GwonNumber99} ${cRed}]${cReset}
__EOF__

		left_code="" ; left_name=""
		left_link="First Chapter"
		left_title="${cReset}${left_link}"
		if (( "$GwonNumber" > 0 )); then #-- if [ $GwonNumber -gt 0 ]; then
			tno=$((GwonNumber - 1))
			left_code=${titleCode[$((tno))]}
			left_name=${titleName[$((tno))]}
			left3word=$(echo ${left_name} | awk '{print $1" "$2" "$3" "}' | sed -e 's/^ *//g' -e 's/ *$//g')
			left3w_md_file=${left3word,,}
			left_link="[ ${left_Code} ${left3word} ](/${PublisherDir}/${DateTitle3wordDir}/$(echo "${left_code}-${left3w_md_file,,}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g").md)"
			#-- | ${left_link} | 👈 ${Gwon_Jemok} 👉 | ${cBlue} ${left_link} |${cMagenta}
		fi
		right_code="" ; right_name=""
		right_link="Last Chapter"
		right_title="${cReset}${right_link}"
		if (( "$GwonNumber" < "$r_top" )); then #-- if [ "$GwonNumber" -lt "$r_top" ]; then
			tno=$((GwonNumber + 1))
			right_code=${titleCode[$((tno))]}
			right_name=${titleName[$((tno))]}
			right3word=$(echo ${right_name} | awk '{print $1" "$2" "$3" "}' | sed -e 's/^ *//g' -e 's/ *$//g')
			right3w_md_file=${right3word,,}
			right_link="[ ${right_Code} ${right3word} ](/${PublisherDir}/${DateTitle3wordDir}/$(echo "${right_code}-${right3w_md_file,,}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g").md)"
			#-- | ${left_link} | 👈 ${Gwon_Jemok} 👉 | ${cBlue} ${right_link} |${cMagenta}
		fi
		tno=$((GwonNumber))
		Gwon_Part_code=${titleCode[$((tno))]} #-- 권번호 + Part / Section / Chapter 번호 --> '02.p1'
		Gwon_Jemok=${titleName[$((tno))]} #-- 권의 제목
		GwonJemok3word=$(echo ${Gwon_Jemok,,} | awk '{print $1" "$2" "$3" "}' | sed -e 's/^ *//g' -e 's/ *$//g')
		GwonCodeDir=$(echo "${Gwon_Part_code}-${GwonJemok3word,,}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g") #-- 폴더 이름으로 쓰기 위한 3단어

		ChapterSeq=${Gwon_Part_code:0:2} #-- Gwon_Part_code 의 0 번 문자부터 2 개의 문자를 잘라내서 담는다.
		#-- ${Gwon_Part_code:0:2} = "01"
		#-- ${Gwon_Part_code:2} = ".c1"
		#-- ${Gwon_Part_code:3} = "c1"

		cat <<__EOF__
${cBlue}/ / / / / / / /${cMagenta}
Title: ${cBlue}${TitleName} ${cMagenta}( ${cYellow}${Gwon_Part_code:0:2}${Gwon_Part_code:2} ${cMagenta}) ${cReset}${Gwon_Jemok}${cMagenta}
md Path: ${cBlue}${PublisherDir} ${cMagenta}/ ${cBlue}${DateTitle3wordDir} ${cMagenta}/ ${cGreen}${GwonCodeDir}.md${cMagenta}
${cBlue}/ / / / / / / /${cReset}

__EOF__
# 삭제함 Images Folder: ${cBlue}${PublisherDir} ${cMagenta}/ ${cBlue}${DateTitle3wordDir}

		imageCntNo=0 #-- 현재의 권번호 안에서 0 부터 올라가는 사진 카운터
		imageCntZZ="0000${imageCntNo}"
		imageCnt99=${imageCntZZ:(-2)}

		# 이미지 제목
		# -----------

		old_image_jemok=${GwonJemok3word} #-- 처음에는 이 이름을 보여준다.
		image_jemok=${GwonJemok3word}
		until [ "x$image_jemok" = "xxx" ] #-- (B) 이미지 제목 입력
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
			ImageJemok3word=$(echo ${image_jemok,,} | awk '{print $1" "$2" "$3" "}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- 폴더 이름으로 쓰기 위한 3단어
			ImageFileName=$(echo "${ChapterSeq}.${imageCnt99}-${ImageJemok3word}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g") #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.
			cat <<__EOF__

(3) ${cBlue}----> 이미지 파일 이름은 '알파벳 대/소 문자', '숫자'와 '점 대시 빈칸' 만 씁니다.
          이미지 파일 이름이 ${cRed}[ ${cCyan}${image_jemok} ${cRed}] ${cBlue}인 경우,
${cMagenta}![ ${cCyan}${image_jemok} ${cMagenta}](${cBlue}/${PublisherDir}/${DateTitle3wordDir}/${cBlue}${ImageFileName:0:2}.${cGreen}${ImageFileName:3:2}${cBlue}-${ImageFileName:6}.${cBlue}${image_type}${cMagenta})${cBlue} 로 등록합니다.${cRed}
          [ ${cYellow}xx ${cRed}]${cBlue} 즉 '${cCyan}x 두개${cBlue}' 인 경우, ${cCyan}권 번호 입력 ${cMagenta}으로 돌아갑니다.${cMagenta}
부여번호${cRed}  [ ${cYellow}+ ${cRed}]${cBlue} -> ${cGreen}${nextCnt99}${cBlue} = 이미지 번호 ///${cMagenta}
  '${cGreen}${imageCnt99}${cMagenta}'    ${cRed}[ ${cYellow}- ${cRed}]${cBlue} -> 이미지 번호 = ${cGreen}${befoCnt99} ${cBlue}///
          또한, 확장자를 무조건 ${cBlue}'${cCyan}.${image_type}${cBlue}'${cBlue} 로 붙여주므로, 이게 아니면 해당 타입까지 써주고, 결과를 수정하면 됩니다.${cReset}
__EOF__
			read image_jemok
			if [ "x$image_jemok" = "x" ]; then #-- if-B.01
				image_jemok=${old_image_jemok}
				cat <<__EOF__
${cUp}
(3a) ${cBlue}----> ${cMagenta}다시 입력해 주세요 ~${cReset}

__EOF__
			else #-- if-B.01
			cat <<__EOF__
${cUp}
${cRed}[ ${cYellow}${image_jemok} ${cRed}]${cReset}
__EOF__
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
			if [ "x$image_jemok" != "xxx" ]; then #-- if-B.04
				old_image_jemok=${image_jemok}
				ImageJemok3word=$(echo ${image_jemok,,} | awk '{print $1" "$2" "$3" "}' | sed -e 's/^ *//g' -e 's/ *$//g') #-- 폴더 이름으로 쓰기 위한 3단어
				ImageFileName=$(echo "${ChapterSeq}.${imageCnt99}-${ImageJemok3word}" | sed 's/\//_/g' | sed 's/ /_/g' | sed "s/’/\'/g") #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.
				cat <<__EOF__
${cBlue}
/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

| ${left_link} | 👈 ${Gwon_Jemok} 👉 | ${cBlue} ${right_link} |${cMagenta}
|:---:|:---:|:---:|

Title:\` ${cBlue}${TitleName}${cMagenta} \`
Short Description:\` ${cBlue}${ShortDescription}${cMagenta} \`
Link:\` ${cBlue}${https_line}${cMagenta} \`
create:\` ${cBlue}$(date +'%Y-%m-%d %a %H:%M:%S')${cMagenta} \`

PAGE INFO Title:\` ${cMagenta}${cYellow}${Gwon_Part_code:0:2}${cReset}${Gwon_Part_code:2} ${Gwon_Jemok} ${cMagenta}\`
Path:\` ${cBlue}${PublisherDir} ${cMagenta}/ ${cBlue}${DateTitle3wordDir} ${cMagenta}\`
md File:\` ${cYellow}${GwonCodeDir:0:2}${cGreen}${GwonCodeDir:2}.md${cMagenta} \`${cBlue}

# ${cCyan}${Gwon_Jemok}

${cYellow}${ImageFileName:0:2}.${cGreen}${ImageFileName:3:2}${cBlue}-${ImageFileName:6}.${cCyan}${image_type}

${cMagenta}![ ${cGreen}${image_jemok} ${cMagenta}](${cBlue}/${PublisherDir}/${DateTitle3wordDir}/${cYellow}${ImageFileName:0:2}.${cGreen}${ImageFileName:3:2}${cBlue}-${ImageFileName:6}.${cCyan}${image_type}${cMagenta})${cBlue}

/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
${cReset}
(4) ${cBlue}----> 윗줄을 복사해서 사용합니다.
    ----> (3) 으로 돌아갑니다.${cReset}
__EOF__
				imageCntNo=$(($imageCntNo + 1))
				imageCntZZ="0000${imageCntNo}"
				imageCnt99=${imageCntZZ:(-2)}

			fi #-- if [ "x$image_jemok" != "xxx" ]; then #-- if-B.04
			fi #-- if [ "x$image_jemok" = "x-" ]; then #-- if-B.03
			fi #-- if [ "x$image_jemok" = "x+" ]; then #-- if-B.02
			fi #-- if [ "x$image_jemok" = "x" ]; then #-- if-B.01

		done #-- until [ "x$image_jemok" = "xxx" ] #-- (B) 이미지 제목 입력

	fi #-- if-A.02
	fi #-- if-A.01

done #-- until [ "x$Gwon_Part_code" = "xxx" ] #-- (A) 권번호 입력시 'xx' 를 입력해야 끝난다.

# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----
