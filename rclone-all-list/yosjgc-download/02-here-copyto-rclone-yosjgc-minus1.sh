#!/bin/sh

rclone_name="yosjgc"

if [ -d "$1" ]; then
	from_dir="$1"
	echo "----> from_dir ${from_dir}"
else
	echo "----> ls -l --color"
	ls -l --color
	echo "----> Enter Directory name:"
	read a
	if [ "x$a" = "x" ]; then
		exit -1
	fi
	from_dir="$a"
fi

cat <<__EOF__
rclone_name: ${rclone_name}
from_dir: ${from_dir}
ls -l --color ${from_dir}:
$(ls -l --color ${from_dir})

----> press Enter:
__EOF__
read a

#-- if [ ! -d ${from_dir} ]; then
#-- 	echo "mkdir -p ${from_dir}"
#-- 	mkdir -p ${from_dir}
#-- fi

copy_root_to() {
	name="$1"
	echo "----> rclone lsl ${rclone_name}:\"${name}\""
	rclone lsl ${rclone_name}:"${name}"
	echo "----> rclone delete ${rclone_name}:\"${name}\""
	rclone delete ${rclone_name}:"${name}"
	echo "----> rclone copy \"${name}\" ${rclone_name}:\""
	rclone copy "${name}" ${rclone_name}:\"
	echo "----> rclone lsl ${rclone_name}:\"${name}\""
	rclone lsl ${rclone_name}:"${name}"
}

copyto() {
	dir="$1"
	name="$2"
	echo "----> rclone lsl \"${from_dir}/${dir}/${name}\""
	rclone lsl ${rclone_name}:"${dir}/${name}"
	echo "----> rclone copy \"${from_dir}/${dir}/${name}\" ${rclone_name}:\"${dir}/${from_dir}/\""
	rclone copy "${from_dir}/${dir}/${name}" ${rclone_name}:"${dir}/${from_dir}/"
	echo "----> rclone lsl ${rclone_name}:\"${dir}/${name}\""
	rclone lsl ${rclone_name}:"${dir}/${name}"
}

echo "copy_root_to"
copy_root_to "경비및후원.xlsx"
echo "----> press Enter:" ; read a

#--

echo "Life"
copyto "Life" "2021-08 문서.docx"
copyto "Life" "2021-10 일지.docx"
copyto "Life" "2021-11 공지.docx"

echo "Life/2023문서"
copyto "Life/2023문서" "2021 아파트 관리비.xlsx"
copyto "Life/2023문서" "2021 올바로 02g.docx"
copyto "Life/2023문서" "2021 올바로 02g의 사본.docx"
copyto "Life/2023문서" "2021-11 일지.docx"
copyto "Life/2023문서" "2021-12 일지.docx"
copyto "Life/2023문서" "2021년 올바로 배출자 ／ 처리자.docx"
copyto "Life/2023문서" "2021년 올바로 배출자 ／ 처리자의 A5 인쇄용.docx"
copyto "Life/2023문서" "2021년 올바로 배출자 ／ 처리자의 사본.docx"
copyto "Life/2023문서" "2021년 올바로 배출자 ／ 처리자의 인쇄본.docx"
copyto "Life/2023문서" "2022 아파트 관리비.xlsx"
copyto "Life/2023문서" "2022-01 일지.docx"
copyto "Life/2023문서" "2022-02 일지.docx"
copyto "Life/2023문서" "2022-03 일지.docx"
copyto "Life/2023문서" "2022-04 일지.docx"
copyto "Life/2023문서" "2022-05 일지.docx"
copyto "Life/2023문서" "2022-06 일지.docx"
copyto "Life/2023문서" "2022-07 일지.docx"
copyto "Life/2023문서" "2022-08 일지.docx"
copyto "Life/2023문서" "2022-09 일지.docx"
copyto "Life/2023문서" "2022년도 4분기 가계부.xlsx"
copyto "Life/2023문서" "220202 세계 인구자료.xlsx"
copyto "Life/2023문서" "220202 코로나19 실시간 상황판.xlsx"
copyto "Life/2023문서" "A4 컬러 라인 나눔고딕코딩11.docx"
copyto "Life/2023문서" "A5 점선 양식 나눔고딕11.docx"
copyto "Life/2023문서" "Dart test source.docx"
copyto "Life/2023문서" "Doit Flutter 2.0.docx"
copyto "Life/2023문서" "Fedora 가상 시스템 설치.docx"
copyto "Life/2023문서" "Fedora 가상 시스템 인쇄용.docx"
copyto "Life/2023문서" "Flutter에서 MVVM 아키텍처 구현을 위한 초보자 가이드.docx"
copyto "Life/2023문서" "win10 에서 Flutter 설치.docx"
copyto "Life/2023문서" "공유 2021 아파트 관리비.xlsx"
copyto "Life/2023문서" "스프링 부트 + 코틀린.docx"
copyto "Life/2023문서" "얏지 A5 점선 양식.docx"
copyto "Life/2023문서" "영어 공부.docx"
copyto "Life/2023문서" "월말 김어준_index의 사본.xlsx"
copyto "Life/2023문서" "제목 없는 스프레드시트.xlsx"

echo "Life/Job/01-서원타이어"
copyto "Life/Job/01-서원타이어" "2020-12 On-demand Delivery System with Python & PWA.docx"
copyto "Life/Job/01-서원타이어" "3D CAD 오픈소스 포함 캐드 프로그램.docx"
copyto "Life/Job/01-서원타이어" "Github 사용법.docx"
copyto "Life/Job/01-서원타이어" "Grails 4 튜토리얼.docx"
copyto "Life/Job/01-서원타이어" "gate242 흐름도 A5 양식.docx"
copyto "Life/Job/01-서원타이어" "gate242 흐름도 원본.docx"
copyto "Life/Job/01-서원타이어" "gate242 흐름도.docx"
copyto "Life/Job/01-서원타이어" "xlsTOgukdongdb 이전함수.docx"
copyto "Life/Job/01-서원타이어" "개발일지.docx"

echo "Life/Job/01-서원타이어/구글 스프레드시트/"
copyto "Life/Job/01-서원타이어/구글 스프레드시트" "2019년 캘린더.xlsx"
copyto "Life/Job/01-서원타이어/구글 스프레드시트" "구매 주문서.xlsx"
copyto "Life/Job/01-서원타이어/구글 스프레드시트" "할 일 목록.xlsx"

echo "Life/Job/01-서원타이어/서원자료/"
copyto "Life/Job/01-서원타이어/서원자료" "2019 올바로 대조작업.xlsx"
copyto "Life/Job/01-서원타이어/서원자료" "교통사고 합의서.xlsx"

echo "Life/Job/01-서원타이어/서원자료/설명메모/"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "200828 폐기물 수탁 재활용 관리대장 출력용 시스템.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "200921 거래내역과 올바로내역의 상호가 틀리는 경우 수정방법.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "220126 올바로만 있음 메뉴에 내역이 나오는 문제 해결 방법.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "220126 인쇄본: 올바로만 있음 메뉴에 내역이 나오는 문제 해결 방법.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "거래처테이블의 여분필드 사용.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "관리대장.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "폐기물 수탁 재활용 관리대장.docx"
copyto "Life/Job/01-서원타이어/서원자료/설명메모" "폐차장 계약 절차.docx"

echo "Life/Job/01-서원타이어/서원자료/올바로 관련자료/2019년도/"
copyto "Life/Job/01-서원타이어/서원자료/올바로 관련자료/2019년도" "1901 폐기물 수탁 재활용 관리대장.xlsx"
copyto "Life/Job/01-서원타이어/서원자료/올바로 관련자료/2019년도" "2019 올바로등록.docx"

echo "Life/Job/01-서원타이어/"
copyto "Life/Job/01-서원타이어" "제목 없는 문서.docx"
copyto "Life/Job/02-카오스패션" "2021-5 카오스노트.docx"
copyto "Life/Job/02-카오스패션" "Kaossam 샘플실 납품외주관리.xlsx"

echo "Life/Job/메디/"
copyto "Life/Job/메디" "[xls] 품목별 수량 합계 만들기.xlsx"

echo "Life/Job/프로그램/"
copyto "Life/Job/프로그램" "Grails 4 SSC 예제.docx"

echo "Life/정치/"
copyto "Life/정치" "더민주명단.xlsx"

echo "Life/책메모/노자/"
copyto "Life/책메모/노자" "이경숙 노자도덕경.docx"

echo "Life/책메모/채근담/"
copyto "Life/책메모/채근담" "채근담 전집-100 완역.docx"
copyto "Life/책메모/채근담" "채근담 전집-225 원본.docx"
copyto "Life/책메모/채근담" "채근담 후집-134 완역.docx"
copyto "Life/책메모/채근담" "채근담 후집-134 원본.docx"

echo "Life/책메모/"
copyto "Life/책메모" "춘향전(春香傳) 3.docx"

echo "Life/현대 메모/"
copyto "Life/현대 메모" "2020 아파트 관리비.xlsx"
copyto "Life/현대 메모" "2020년 일지.docx"
copyto "Life/현대 메모" "2021 개발일지.docx"
copyto "Life/현대 메모" "2021년 일지.docx"
copyto "Life/현대 메모" "Cm 을 픽셀로 바꾸기.xlsx"
copyto "Life/현대 메모" "냉수를 졸졸 흐르게 한 것임.xlsx"
copyto "Life/현대 메모" "통장관리.xlsx"

echo "Life/현대 메모/2020사진/"
copyto "Life/현대 메모/2020사진" "2020 가계부.xlsx"
copyto "Life/현대 메모/2020사진" "2020 아파트 관리비 공유.xlsx"
copyto "Life/현대 메모/2020사진" "2021 간편 달력.docx"
copyto "Life/현대 메모/2020사진" "2021 아파트 관리비 공유.xlsx"
copyto "Life/현대 메모/2020사진" "간편 가계부.xlsx"

echo "root/"
copyto "root" "Google 노트에서 가져온 문서 - 내 노트.docx"
copyto "root" "Google 노트에서 가져온 문서 - 노트 1.docx"
copyto "root" "서신.docx"
copyto "root" "진접현대일지.docx"
copyto "root" "프로젝트 제안서.docx"

echo "root/old현대/"
copyto "root/old현대" "무선 네트워크 없이 hp 프린터 스마트폰 인쇄.docx"
copyto "root/old현대" "카톡 백업하기.docx"
copyto "root/old현대" "핸드폰 앱 정리.xlsx"

echo "root/old현대/보관/"
copyto "root/old현대/보관" "2020 아파트 관리비의 사본.xlsx"
copyto "root/old현대/보관" "82쿡 대구언니야들아, 내가 비밀한 개 알려주까.docx"
copyto "root/old현대/보관" "스미싱 사칭문자 사기.docx"

echo "현대 공유/"
copyto "현대 공유" "2021 고정비 지출.xlsx"
copyto "현대 공유" "2021년 가계부.xlsx"
copyto "현대 공유" "2022년 가계부.xlsx"
copyto "현대 공유" "2023년 가계부.xlsx"
copyto "현대 공유" "5 tiny habits for a happy life.docx"
copyto "현대 공유" "Grails 사용.docx"
copyto "현대 공유" "VS Code 강의 번역.docx"
copyto "현대 공유" "박셩리선생 일본산고.docx"
copyto "현대 공유" "심심할때 보는 유튜브.docx"
copyto "현대 공유" "행복한 삶을 위한 다섯가지 작은 습관.docx"
copyto "현대 공유" "현대 게시판.docx"

echo "현대 공유/Old files/"
copyto "현대 공유/Old files" "2020 고정비 지출.xlsx"
copyto "현대 공유/Old files" "2021-1 2 3 가계부.xlsx"

