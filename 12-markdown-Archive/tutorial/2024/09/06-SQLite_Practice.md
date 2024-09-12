
# 1. SQLite 샘플 파일 만들기

## 1. 준비한 샘플파일을 구글 스프레드 시트로 업로드

1. ilji/2024/2408/ [2024년-8월27x.xlsx.7z](ilji/2024/2408/2024년-8월27x.xlsx.7z)
1. 크롬 브라우저를 열고, 구글 드라이브 drive.google.com 들어가서,
(1) `+ 신규` 클릭, `새폴더` 클릭 > 새폴더 이름 `expense` 입력하고 `만들기` 클릭
(2) 새로 만든 `expense` 폴더로 들어가서,
(3) `2024년-8월27x.xlsx.7z` 압축을 풀어서 `2024년-8월.xlsx` 파일을 만든다.
(4) `+ 신규` > `파일 업로드` > 파일 이름 `2024년-8월.xlsx` 선택하고 [열기] 클릭해서 업로드한다.

## 2. 샘플파일의 표기를 변경

### (1) 금액 컬럼에 '`,`' 표시

`1,234,567` 로 표시하기 위해, 해당 `B` 컬럼을 클릭해서 컬럼 전체를 선택하고,
파일, 수정, 보기,... 등 메뉴에서, 서식 > 숫자 > 맞춤 숫자 형식 > `#,##0` > [적용] 클릭

### (2) 금액 컬럼에 '`,`' 표시 삭제

`1234567` 로 표시하기 위해, 금액 자리인 `B` 컬럼을 클릭해서 컬럼 전체를 선택하고,
메뉴에서, 서식 > 숫자 > 맞춤 숫자 형식 > `0` > [적용] 클릭

### (3) 날짜 컬럼을 '`8/28 수`' 로 표시

날짜 자리는 `2024-08-28` 대신 `8/28` 로 입력하기 위해, 해당 `D` 컬럼을 클릭해서 전체 선택하고,
서식 > 숫자 > 맞춤 날짜 및 시간 > 맞춤 날짜 및 시간 형식 > 적용 버튼 옆의 [v] 클릭해서,
`'월'` 선택 > `'/'` 입력 > `'일'` 선택 > `' '` 입력 > `'요일 축약형 (화)'` 선택하고 > [적용] 선택
그러면, `'8/28'` 으로 입력하면, `'8/28 수'` 형식으로 등록된다.
다음부터는,
메뉴에서, 서식 > 숫자 > 맞춤 숫자 형식 > `m"/"d" "ddd` > [적용] 클릭 할 수 있다.

### (4) 날짜 컬럼을 '`2024-08-28`' 로 표시

날짜 자리를 `2024-08-28` 로 쓰려면,
다시 `D` 컬럼 전체를 선택 > 서식 .. 숫자 .. 맞춤 .. 맞춤 형식 .. 적용 옆의 체크 [v] 클릭해서,
`'연도 (1930)'` 선택 > `'-'` 입력 > `'월'` 선택 > `'-'` 입력 > `'일'` 선택 > [적용] 선택
다음부터는,
메뉴에서, 서식 > 숫자 > 맞춤 숫자 형식 > `yyyy"-"mm"-"dd` > [적용] 클릭 할 수 있다.

## 3. .csv 로 다운로드 하기 위해서,

1. `내드라이브 > sqlexam` 의 `2024년-8월.xlsx` 파일을 더블클릭 하면 파일이 열린다
1. 금액 컬럼과 날짜 컬럼의 표시를 바꾸고, `파일` > `다운로드` > `쉼표로 구분된 값 (.csv)` 을 클릭해서
`2408.csv` 파일로 다운로드한다.
1. 다운로드한 `.csv` 파일을 `DB Browser for SQLite` 에서 사용한다.

## 4. sqlite 샘플 파일

### 2408.csv

```
뽕따바800*4,3200,왕도매,2024-08-03,1827,빙과,1
탱크보이800*4,3200,왕도매,2024-08-03,1827,빙과,2
콩가득두부800g,2980,왕도매,2024-08-03,1827,반찬,3
진소컵매65g*6*2,9960,왕도매,2024-08-04,1833,라면,4
으뜸결명자40t,4950,왕도매,2024-08-04,1833,차,5
"안티캄,속몰큐어10캡슐",6800,백약국,2024-08-05,1521,약,6
광동원탕*10,9000,아침약국,2024-08-08,1658,약,7
아이리버이어폰*3,15000,홈플아성다이소,2024-08-10,1106,문구,8
자전거배낭200,15000,왕도매,2024-08-10,1134,배낭,9
파워에이드제로600ml,1350,왕도매,2024-08-10,1134,음료,10
파워에이드제로1.5L,2280,왕도매,2024-08-10,1134,음료,11
일미치자단무지1kg,8500,왕도매,2024-08-10,1134,반찬,12
빠삐코1600류*2,1600,왕도매,2024-08-11,1805,빙과,13
다블팅사과맛*2,1600,왕도매,2024-08-11,1805,빙과,14
젤루조아제주감귤800*2,1600,왕도매,2024-08-11,1805,빙과,15
탱크보이800*2,1600,왕도매,2024-08-11,1805,빙과,16
알뜨랑골드핑크140g*3,8400,왕도매,2024-08-11,1805,비누,17
카누디카페인미니10입,3500,왕도매,2024-08-12,1059,커피,18
핫브레이크1000,1000,gs25진접행복,2024-08-12,1154,기호,19
스니커즈피넛,1500,gs25진접행복,2024-08-12,1154,기호,20
뼈해장국3순두부1,34000,전주콩나물국밥,2024-08-14,1859,석식,21
대추방울토마토1팩,5980,왕도매,2024-08-15,1727,채소,22
진소순65g*6,4980,왕도매,2024-08-15,1727,라면,23
진소매65g*6,4980,왕도매,2024-08-15,1727,라면,24
다우니퍼퓸스프링가든1L,10000,왕도매,2024-08-15,1727,세탁,25
홈매트리퀴드R,19300,왕도매,2024-08-15,1727,방제,26
양구수박1통6kg,26800,왕도매,2024-08-17,1239,과일,27
이발,12000,베스트맨,2024-08-19,1035,이발,28
진소순65g*6,4980,왕도매,2024-08-19,1806,라면,29
진소매65g*6,4980,왕도매,2024-08-19,1806,라면,30
검은콩깨보리건빵400g*3,8100,왕도매,2024-08-19,1806,기호,31
오카레약간매운맛100g,2750,왕도매,2024-08-28,1826,반찬,32
오백세카레약매100g,4350,왕도매,2024-08-27,1826,반찬,33
어반빗자루받기세트,6000,왕도매,2024-08-27,1826,주방,34
백설갈색설탕3kg,8450,왕도매,2024-08-28,1827,설탕,35
백오이5개,2980,왕도매,2024-08-28,1827,채소,36
```

# 2. DB Browser for SQLite 다운로드
https://sqlitebrowser.org/

1. SQL 데이터베이스 처음 다루기 다비드 2021. 2. 1
https://blog.naver.com/davethe/222228296094
1. SQLite3 테이블 생성과 CRUD 2020. 9. 23.
https://eine.tistory.com/entry/SQLite3로-해보는-데이터베이스-튜토리얼-테이블-생성과-CRUD [아인스트라세의 SW 블로그:티스토리] 
1. 파이썬에서 sqlite 사용 2021. 3. 22.
https://m.blog.naver.com/PostView.naver?blogId=realcar4u&logNo=222283649528&categoryNo=0&proxyReferer=
1. SQLite 날짜 및 시간 함수 sqlite.org
https://www.sqlite.org/lang_datefunc.html

## sqlite는 아래 5가지 제한 적인 data type만을 2015. 12. 8.

https://blog.naver.com/tokimdh77/220561836945

(1) `NULL` The value is a NULL value.
(2) `INTEGER` The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.
(3) `REAL` The value is a floating point value, stored as an 8-byte IEEE floating point number.
(4) `TEXT` The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).
(5) `BLOB` The value is a blob of data, stored exactly as it was input. (**B**inary **L**arge **Ob**ject)
참고 : BLOB는 이미지, 오디오, 동영상과 같은 큰 data를 hex code로 처리할때 사용된다.
sql 쿼리에서 일반적으로 사용되는 varchar, text, ntext, boolean등은 적당히 겹치는것을 사용하면 된다.

### 하지만 가장 큰 문제는 datetime 이 없다는 것이다.

그 해결책으로 sqlite는 datetime을 아래 3가지 형태의 format 하에 저장할 수 있도록 지원한다.
(1) `TEXT` as ISO8601 strings ("YYYY-MM-DD HH:MM:SS.SSS").
(2) `REAL` 줄리안일 BC4714-11-24 이 기준일
(3) `INTEGER` 유닉스계열 time format : 1970-01-01 00:00:00 UTC.
(4) Create table에서 datetime을 TEXT로 사용한 예
```
... timeMemo TEXT not null DEFAULT (datetime('now', 'localtime')) ...
```
(5) Update or Insert 에서 datetime을 TEXT로 사용한 예
```
... [timeLast]=datetime('now', 'localtime') ...
```
(6) 각종 날짜 계산은 아래 function들을 이용한다.
```
date(timestring, modifier, modifier, ...)

time(timestring, modifier, modifier, ...)

datetime(timestring, modifier, modifier, ...)
#-- 가장 기준이 되는 funcion : 'YYYY-MM-DD HH:MM:SS'

julianday(timestring, modifier, modifier, ...)
#-- 줄리안 일을 기준으로 현제 시간을 출력한다.

strftime(format, timestring, modifier, modifier, ...)
#-- time 입출력 format 설정 : '%Y-%m-%d %H:%M:%S'
```

(7) 또다른 문제는 현제 시간을 출력하는 datetime('now');를 하면 국제 표준시(영국)을 기준으로 출력된다.
따라서 한국의 표준시를 얻으려면 select datetime('now', 'localtime'); 처럼 해줘야만 한다.
```
sqlite> select datetime('now');
   2012-02-27 17:17:13
sqlite> select datetime('now', 'localtime');
   2012-02-28 02:19:24
sqlite> select datetime('now', '+9 hours');
   2012-02-28 02:19:43
```

(8) 현제와 지정된 시간의 차이를 계산하려면 아래처럼 해주면 된다.
```
SELECT strftime('%d', The_Column_Name) - strftime('%d', 'now', 'localtime') FROM Payment;

SELECT strftime('%s','2004-01-01 02:34:56') - strftime('%s','now');
```
'%s' 는 시간을 초로 나타내라는 말이다.
'%d' 는 시간을 날짜로 나타내라는 말이다.
두번째 줄에 둘다 'localtime'을 빼주면, 결과 값은 둘다 넣어준거와 같다.

# DB Browser for SQLite 실행

1. 새 데이터베이스 (N) > 파일이름 (다운로드 폴더 안에) `1st_DB` [저장] > [취소]
1. 파일 (F) > 가져오기 (I) > CSV 파일에서 테이블 가져오기 (T) > 파일 이름 `tbl-2408.csv` [열기] > 첫 행에 필드명 포함(C) 체크하지 말고 [확인]
1. SQL 실행(E) > `select * from tbl-2408;` 하고, `▶️`(실행) 클릭하면, 오류 발생
```
에러가 발생하여 실행 중단됨.
결과: near "-": syntax error
1번째 줄:
select * from tbl-
```
4. SQL 실행(E) > `select * from `**"**`tbl-2408`**"**`;` 하고, `▶️`(실행) 클릭하면, 정상 작동한다.

| pum | kum | shop | date | time | jong | seq |
|-----|-----|-----|-----|-----|-----|-----|
| 뽕따바800*4 | 3200	| 왕도매 | 2024-08-03 | 1827 | 빙과 | 1 |
| 탱크보이800*4 | 3200 | 왕도매 | 2024-08-03 | 1827 | 빙과 | 2 |
| 콩가득두부800g | 2980 | 왕도매 | 2024-08-03 | 1827 | 반찬 | 3 |
| 진소컵매65g*6*2 | 9960 | 왕도매 | 2024-08-04 | 1833 | 라면 | 4 |
| 으뜸결명자40t | 4950 | 왕도매 | 2024-08-04 | 1833 | 차 | 5 |

```
에러 없이 실행 완료.
결과: 18ms의 시간이 걸려서 37 행이 반환되었습니다
1번째 줄:
select * from "tbl-2408"
```
5. 테이블 이름이 `tbl_2408` 로 되어 있다면,
SQL 실행(E) > `select * from tbl_2408;` 하고, `▶️`(실행) 클릭하면, 정상 작동한다.
```
에러 없이 실행 완료.
결과: 21ms의 시간이 걸려서 37 행이 반환되었습니다
1번째 줄:
select * from tbl_2408
```
## sql 참고

1. SQLite Query: Select, Where, LIMIT, OFFSET, Count, Group By 작성자 : 마커스 알렌마커스 알렌 업데이트 2024 년 7 월 29 일 https://www.guru99.com/ko/sqlite-query.html
1. SQLite INSERT, UPDATE, DELETE Query with Example 작성자 : 마커스 알렌마커스 알렌 업데이트  2024 년 7 월 29 일 https://www.guru99.com/ko/sqlite-query-insert-update.html
1. SQLite 기본 SELECT WHERE BETWEEN Like 2021.11.17. https://ksrapp.tistory.com/5
1. SQL 기초 (SQLIte사용) 생각하는 마리오네트·2021년 7월 13일 https://velog.io/@ljs7463/SQL-%EA%B8%B0%EC%B4%88
1. 

> Page Info:
> (1) Title: 06 DB Browser for SQLite 로 sql 실습
> (2) Short Description: sql 실습
> (3) Path: tutorial/2024/09/06-SQLite_Practice
> 제목: DB Browser for SQLite 로 sql 실습
> 쓴이: By yosj 240906
> 링크: 
> 입력: 2024-09-10 화 1353
> 파일: 06-SQLite_Practice.md

