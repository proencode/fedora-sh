#!/bin/sh

publisher="PacktPub" #-- (1) 출판사
BookCover="How to Build Android Apps with Kotlin 2ED" #-- (2) 책 제목
ShortDescription="By Alex Forrester, Eran Boudjnah, Alexandru Dumbravan, and 2 more 2023-05 Pages 704 ISBN 9781837634934" #-- (3) 저자등 설명
ChapterSeq="00" #-- (4) ''00' 또는 '01' 부터 시작하는 권 번호 (+ 장 번호)
ChapterName="Preface" #-- (5) wiki.js 왼쪽에 표시할 챕터 제목
old_image_jemok=${ChapterName} #-- (6) 시작시 예시로 든 이미지의 일련번호 + 이름
https_line="https://subscription.packtpub.com/book/mobile/9781837634934/pref/" #-- (7) 출판사 홈페이지 링크
tags="Kotlin Android" #-- (8) 찾기 위한 태그

CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi

sh ${CMD_DIR}/01-run-each-book.sh  "${publisher}"  "${BookCover}"  "${ShortDescription}"  "${ChapterSeq}"  "${ChapterName}"  "${old_image_jemok}"  "${https_line}"  "${tags}"
