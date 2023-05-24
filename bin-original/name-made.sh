#!/bin/sh

source ${HOME}/lib/color_base

publisher="packtpub" #-- (1) 출판사
BookCover="JavaScript from Frontend to Backend" #-- (2) 책 제목
ShortDescription="Publication date: 7월 2022 Publisher Packt Pages 336 ISBN 9781801070317" #-- (3) 저자등 설명
ChapterSeq="06" #-- (4) 챕터 (장) 번호
ChapterName="JavaScript Syntax" #-- (5) wiki.js 왼쪽에 표시할 챕터 제목
old_image_jemok="0601 Onion Architecture" #-- (6) 시작시 예시로 든 이미지의 일련번호 + 이름
https_line="https://subscription.packtpub.com/book/web-development/9781801070317/4" #-- (7) 출판사 홈체이지 링크
tags="vue.js node.js" #-- (8) 찾기 위한 태그

sh ${HOME}/bin/image-name-made-for-Books.sh  "${publisher}"  "${BookCover}"  "${ShortDescription}"  "${ChapterSeq}"  "${ChapterName}"  "${old_image_jemok}"  "${https_line}"  "${tags}"
