#!/bin/sh

CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi

publisher="gihyo" #-- (1) 출판사
BookCover="Kotlin Server Side Programming" #-- (2) 책 제목
ShortDescription="By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4" #-- (3) 저자등 설명
ChapterSeq="02-006" #-- (4) 챕터 (장) 번호
ChapterName="006 Spring Boot 와 MyBatis" #-- (5) wiki.js 왼쪽에 표시할 챕터 제목
old_image_jemok="601 Onion Architecture" #-- (6) 시작시 예시로 든 이미지의 일련번호 + 이름
https_line="https://gihyo.jp/book/2021/978-4-297-11859-4" #-- (7) 출판사 홈체이지 링크
tags="kotlin spring boot" #-- (8) 찾기 위한 태그

sh ${CMD_DIR}/image-link-made.sh "${publisher}"  "${BookCover}"  "${ShortDescription}"  "${ChapterSeq}"  "${ChapterName}"  "${old_image_jemok}"  "${https_line}"  "${tags}"
