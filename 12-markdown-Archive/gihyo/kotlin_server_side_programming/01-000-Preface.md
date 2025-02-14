5,$s/　/ /g

## 1부 코틀린 시작하기

### 제1장 [ Kotlin을 추천하는 이유 ](/gihyo/kotlinServerSideProgramming/01-001)

1. 왜 Kotlin이 탄생했는가?
2. Kotlin으로 무엇을 만들 수 있습니까? ~서버 측에서의 이용 의의
3. 코드의 안전성을 높이는 Kotlin의 형태와 Null 비허용/허용
4. 환경 구축 및 첫 프로그램 실행
5. Kotlin의 기본 구문

### 제2장 [ 다양한 Kotlin의 기능 ](/gihyo/kotlinServerSideProgramming/01-002)


1. if, when 문을 식으로 취급 코드를 간단하게 할 수 있다
2. 속성 정의에서 접근자 메서드(getter, setter)가 더 이상 필요하지 않음
3. 데이터 클래스에서 보일러 플레이트를 줄일 수 있습니다.
4. 기본 인수와 명명된 인수로 함수 호출을 단순화할 수 있습니다.
5. 함수형과 고층함수, 타입 별칭으로 로직을 재이용하기 쉽게 할 수 있다
6. 확장 기능으로 유연하게 로직 추가
7. 범위 함수를 사용하여 객체에 대한 처리를 단순화할 수 있습니다.
8. 연산자 오버로드로 클래스에 대한 연산자 처리를 구현할 수 있습니다.
9. 대리자로 중복 처리를 위임할 수 있습니다.
10. 충실한 컬렉션 라이브러리로 컬렉션에 대한 처리를 간단하게 할 수 있다
11. 코루틴으로 비동기 처리를 구현할 수 있습니다.

### 제3장 [ Java와 Kotlin 의 상호 호환성이 기존 자산을 활용 ](/gihyo/kotlinServerSideProgramming/01-003)

1. Java 코드 호출
2. Java 라이브러리 호출
3. Java 클래스를 상속하고 Kotlin에서 구현
4. Java와 상호 호출 할 때의 특별한 예
5. Java 코드를 Kotlin 코드로 변환

## 2부 Kotlin 에서 서버측 개발

### 제4장 [ 웹 애플리케이션 개발의 기반이 되는 Spring Boot 도입 ](/gihyo/kotlinServerSideProgramming/02-004)


1. Spring Boot 소개
2. Spring Boot에서 REST API 구현
3. Spring Framework DI 사용

### 제5장 [ O/R 매퍼를 사용하여 데이터베이스에 연결 ](/gihyo/kotlinServerSideProgramming/02-005)

1. MyBatis란?
2. Docker로 MySQL 환경 구축
3. MyBatis 도입
4. MyBatis에서 CRUD 만들기
5. Spring Boot에서 MyBatis 사용

### 제6장 [ Spring Boot와 MyBatis에서 도서 관리 시스템 웹 애플리케이션 개발 ](/gihyo/kotlinServerSideProgramming/02-006)

1. 책 관리 시스템 사양
2. 애플리케이션 구성
3. 프로젝트 환경 구축
4. 검색계 기능(일람 취득, 상세 취득)의 API 구현
5. 갱신계 기능(등록, 갱신, 삭제)의 API 구현

### 제7장 [ 서적 관리 시스템의 기능 확대 ](/gihyo/kotlinServerSideProgramming/02-007)

1. Spring Security에서 사용자 인증, 권한 부여 메커니즘 구현
2. 대출, 반환 기능의 API 구현
3. Spring AOP에서 로그 출력

### 제8장 [ JUnit 에서 단위 테스트 구현 ](/gihyo/kotlinServerSideProgramming/02-008)

1. JUnit 도입
2. JUnit에서 웹 애플리케이션 단위 테스트

## 제3부 Kotlin 에서 다양한 프레임워크를 사용해보기

### [ 제9장 고속 통신 프레임워크 gRPC ](/gihyo/kotlinServerSideProgramming/03-009)

1. gRPC란?
2. gRPC 도입
3. Spring Boot에서 gRPC Kotlin 서버 측 프로그램 구현

### [ 제10장 Kotlin의 웹 프레임워크 Ktor ](/gihyo/kotlinServerSideProgramming/03-010)

1. Ktor란?
2. Ktor 도입
3. REST API 구현
4. 인증 메커니즘 구현

### 제11장 [ Kotlin제 O/R매퍼 Exposed ](/gihyo/kotlinServerSideProgramming/03-011)

1. Exposed란?
2. Exposed 도입
3. DSL과 DAO 각각의 구현 방법
4. DAO에서 CRUD 만들기

### 제12장 [ Kotlin의 테스팅 프레임워크 Kotest, MockK ](/gihyo/kotlinServerSideProgramming/03-012)

1. Kotest란?
2. Kotest 도입
3. 여러 코딩 스타일(Spec)로 단위 테스트 작성
4. 데이터 구동 테스트 사용
5. MockK를 사용하여 모형화


> 사용하기 전에 반드시 읽어주십시오.

본서는 종이 서적 「Kotlin 서버 측 프로그래밍 실천 개발」(ISBN978-4-297-11859-4)을 바탕으로 제작한 전자 서적입니다. 종이 서적과는 디자인이나 레이아웃이 다르고 보이는 단말에 의해 표시가 다른 경우가 있습니다. 디스플레이 설정은 터미널의 표준 설정을 권장합니다. 전송 후에 보충 정정 등으로 데이터를 재배포하는 경우가 있습니다. 갱신 방법은 구입처의 전자서점의 헬프등을 확인해 주십시오.

본서는 정보 제공만을 목적으로 하고 있으며 게재 내용의 운용 결과에 대해서 기술평론사 및 저자는 일절의 책임을 지지 않습니다. 게재 내용은 특별히 언급이 없는 한 집필 시점보다 이전의 정보 때문에, 변경되는 경우가 있습니다. 특히, 소프트웨어는 버전 업되는 경우가 있어, 본서에서의 설명과는 기능 내용이나 화면도등이 다르게 버리는 경우도 있습니다.

이상을 미리 승낙 후, 이용을 부탁드립니다.

본문에 기재된 제품의 명칭은 모두 관계 각 조직, 각사의 상표 또는 등록상표입니다.

> 본 설명서에 기재된 내용은 정보 제공만을 목적으로 합니다. 따라서 본서를 이용한 개발, 제작, 운용은 반드시 고객 자신의 책임과 판단에 따라 실시해 주십시오. 이러한 정보에 의한 개발, 제작 및 운영 결과에 대해 기술평론사 및 저자는 어떠한 책임도 지지 않습니다.
>
> 본서 기재의 정보는 2021년 2월 시점의 것이므로, 이용시에는 변경되고 있는 경우도 있습니다.
> 
> 또, 소프트웨어에 관한 기술은, 본문에 기재되어 있는 버젼에 근거하고 있습니다. 소프트웨어는 버전 업되는 경우가 있어, 본서에서의 설명과는 기능 내용이나 화면도등이 다르게 버리는 일도 있을 수 있습니다. 이 설명서를 구입하기 전에 반드시 버전 번호를 확인하십시오.
> 
> 이상의 주의사항을 승낙해 주신 후에, 본서를 이용 바랍니다. 이러한 주의사항을 읽지 않고 문의해도 기술평론사 및 저자는 대처하기 어렵습니다. 미리, 알려주십시오.
> 
> 본서에 등장하는 제품명 등은 일반적으로 각사의 상표 또는 등록상표입니다. 또한 본 설명서 중에 ™, Ⓒ, Ⓡ 등의 마크는 기재되어 있지 않습니다.

#### 소개
Kotlin은 서버 측 개발을위한 프로그래밍 언어의 선택으로 주목 받고있는 것 중 하나입니다. 원래 Android 개발의 언어로서는(특히 Google I/O로 Android 앱의 공식적인 개발 언어로 된 2017년 이후는) 널리 사용되고 있는 언어입니다만, 서버 측 개발에서 채용하고 있는 제품도 최근에는 증가했습니다.

정식판의 릴리스가 2016년과 비교적 새로운 일도 있어, 매우 모던한 사양의 프로그래밍 언어가 되고 있습니다. 또 Java와의 상호 호환이라는 특징이 있어, 세상에 이미 많은 Java 자산을 활용할 수도 있고, 모던하고 자산도 풍부하게 있다는 훌륭한 언어입니다.

그러나 그 특징 때문에 "Java를 아는 사람이 아니면 어렵지 않을까"라고 생각되어 버리는 경우도 많습니다. 또, 늘어나고 있다고는 해도 아직 국내에서는 사례가 많지 않고, 실천에서 사용한 경험이 있는 엔지니어도 좀처럼 없기 때문에, 「사용해 보고 싶다고는 생각하고 있지만 헤매고 있다」라고 하는 이야기를 듣는 것 자주 있습니다.

이 책은 이러한 불안을 없애고 서버 측 Kotlin 도입을 뒷받침 할 수 있다면 생각 집필하고 있습니다. Java에 대해서는 프레임워크나 라이브러리는 사용하고 있습니다만, Java의 코드는 (상호 호환성에 대해서 해설을 하는 제3장을 제외하고) 일절 나오지 않습니다. Spring Boot를 비롯한 Java 프레임워크도 어디까지나 "Kotlin에서 서버측 애플리케이션을 개발하기 위한 것"으로서 기본적으로 Java를 의식하지 않고 해설하고 있습니다.

또, 타이틀에도 있듯이 「실천 개발」을 테마로, 제2부에서는 실 제품을 의식한 설계로 어플리케이션의 개발을 하고 있습니다. 그 때문에 실제로 업무로의 개발로 Kotlin을 도입할 때에도, 참고로 해 주실 수 있는 내용이 되고 있습니다.

저자는 관련된 모바일 게임 개발 프로젝트에서 처음으로 서버 측 Kotlin을 사용하여 1에서 제품 개발, 릴리스 및 운영을 경험했습니다. 그 위에 많은 혜택을 받고 역시 훌륭한 언어라고 생각합니다. 이 장점이 조금이라도 많은 분들에게 전해져, 세상에 서버 측 Kotlin에서 개발된 제품이 늘어나는 일조가 되면, 강하게 바라고 있습니다.

#### 대상 독자
이 책의 대상 독자는 서버 측 응용 프로그램 개발 경험이있는 사람들이며 Kotlin을 사용하여 서버 측 개발에 관심이 있다고 가정합니다. 그 때문에 실천적인 어플리케이션의 형태로 코드를 쓰거나, 인증·인가등의 실제의 제품으로 사용하는 기능의 실장 등, 실제로 제품의 개발로 도입할 때에 도움이 되는 내용이 되고 있습니다. 특히 Kotlin과 같은 객체 지향 언어(Java, C# 등)의 경험이나, PHP등의 언어에서도 클래스나 인터페이스라고 하는 객체 지향의 기능을 사용한 개발의 경험이 있는 분은, 보다 이해가 쉽다고 생각합니다.

반대로 기초적인 부분은 내용이 조금 얇게되어 있습니다. 이 책의 1장에서는 기본 문법에 대해서도 해설하고 있습니다만, 어느 정도 프로그래밍이나 오브젝트 지향의 기초적인 부분은 알고 있는 전제로, 최소한의 쓰는 방법의 설명 밖에 실시하고 있지 않습니다. 그 때문에, 프로그래밍 초보자에게는 어려운 내용일지도 모릅니다.

#### 동작 확인 환경
이 설명서의 프로그램은 주로 다음 실행 환경을 사용하여 작동을 확인합니다.

표1
|:---|:---|
| OS | macOS Big Sur (11.2.1) |
| Kotlin | 1.4.30 |
| JDK | correto-11 (11.0.10) |
|intelliJ IDEA | Community Edition 2020.3.2 |
| Spring Boot | 2.4.3 |

#### 샘플 프로그램 사용 방법
이 책의 샘플 프로그램은 다음 필자의 GitHub에서 공개하고 있습니다.

https://github.com/n-takehata/kotlin-server-side-programming-practice

이 리포지토리를 로컬 환경에 Clone하여 사용할 수 있습니다. 각 디렉토리에 배치된 프로그램의 내용은 다음과 같습니다.

- part1──파트 1
  - chapter01──제1장
  - chapter02──제2장
  - chapter03──제3장
- part2──2부
  - chapter04──제4장
  - chapter05──제5장
  - book-manager──챕터 6-8
  - front── 제6~7장에서 사용하는 프런트 엔드의 코드(본서 미게재)
- part3──파트 3
  - chapter09──제9장
  - chapter10──제10장
  - chapter11──제11장
  - chapter12──제12장

제1부~제3부에서 각각 part1~part3의 디렉토리로 나누어져 그 안에서 각 장의 프로그램이 들어간 디렉토리를 chapterXX라는 이름으로 배치하고 있습니다.

제6~8장에 관해서는 특수하고, 같은 어플리케이션을 3장에 걸쳐 개발해 나가기 때문에, book-manager라고 하는 어플리케이션의 프로젝트가 되어 있습니다. 또, 본서내에서 코드는 게재하고 있지 않습니다만, front 디렉토리의 아래에 프런트 엔드와 소통해의 동작 확인용의 샘플 프로그램이 준비되어 있습니다.

실행 방법에 대해서는, 각 장의 프로그램의 main 함수를 재기록하여 실행(제1장에서 해설)등이 주로 되어 옵니다만, 장이나 프로그램의 내용에 의해 바뀌어 옵니다. 자세한 내용은 각 디렉토리의 README에 설명되어 있으므로 여기를 참조하십시오.

또, part2/front 아래의 프런트 엔드의 프로그램의 실행 방법에 대해서는, 제6장 중에서도 해설하고 있습니다.

#### 정오 정보
본 설명서의 정오 정보는 아래의 본 설명서 지원 페이지를 참조하십시오.

https://gihyo.jp/book/2021/978-4-297-11859-4


# .md 파일의 그림 번호를 만들어주는 작업

편의를 위해 조건을 미리 입력한 gihyo-kotlin-image-name-made.sh 스크립트를 사용하였다.

```
12:23:09 화 2022-09-13 yos@yosfedora ~/git-projects/fedora-sh/11-markdown-translate-EN-to-KO/gihyo.jp/2209-Kotlin_서버사이드_프로그래밍_실천개발-epub
2209-Kotlin_서버사이드_프로그래밍_실천개발-epub $ sh gihyo-kotlin-image-name-made.sh
----> sh ../../31-image-name-made-4Books.sh "gihyo.jp" "Kotlin Server Side Programming" "By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4" "01-000" "Preface" "Figure 1.1 IntelliJ IDEA Download.png" "https://gihyo.jp/book/2021/978-4-297-11859-4" "kotlin spring boot"

31-image-name-made-4Books.sh "gihyo.jp"  "Kotlin Server Side Programming"  "By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4"  "01-000"  "Preface"  "Figure 1.1 IntelliJ IDEA Download.png"  "https://gihyo.jp/book/2021/978-4-297-11859-4"  "kotlin spring boot"

publisher="gihyo.jp"
BookCover="Kotlin Server Side Programming"
ShortDescription="By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4"
ChapterSeq="01-000"
ChapterName="Preface"
old_image_jemok="Figure 1.1 IntelliJ IDEA Download.png"
https_line="https://gihyo.jp/book/2021/978-4-297-11859-4"
tags="kotlin spring boot"

----> 출판사 이름이 [ gihyo.jp ] 맞으면 엔터를 누르세요.

----> 폴더 이름으로 쓰기 위한 책 제목 Title: [ Kotlin Server Side Programming ] (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

----> 책 제목이 [ gihyo.jp / kotlin_server_side_programming ] 맞으면 엔터를 누르세요.

----> 설명 요약 Short Description: [ By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4 ] (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

----> 설명 요약이 [ By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4 ] 맞으면 엔터를 누르세요.

----> 원본 링크 [ https://gihyo.jp/book/2021/978-4-297-11859-4 ] (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

----> 원본 링크가 [ https://gihyo.jp/book/2021/978-4-297-11859-4 ] 맞으면 엔터를 누르세요.

----> 태그 [ kotlin spring boot ] (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

----> 태그가 [ kotlin spring boot ] 맞으면 엔터를 누르세요.

+--------+ 챕터  번호
| AA-BBB | AA = '01'로 시작하는 챕터별 전체 일련번호
|        | BBB = '0' 섹션 '00' 챕터로 된 코드
+--------+
----> 챕터 번호를 [ 01-000 ] 이와 같이 다음 줄에 입력합니다. [ 엔터 ] 만 누르면 이 작업을 끝냅니다.
01-001
챕터  이름
==========
----> 챕터의 요약제목을 [ Preface ] 이와 같이 다음 줄에 입력합니다. [ 엔터 ] 만 누르면 챕터 번호 입력으로 돌아갑니다.
Preface

----> 이미지의 제목 입력 (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

----> 이미지별 일련번호 (00-000) 와 이미지에 대한 설명을 [ Figure 1.1 IntelliJ IDEA Download.png ] 이와 같이 다음줄에 입력합니다. [ 엔터 ] 만 누르면 챕터 번호 입력으로 돌아갑니다.
01-001 IntelliJ IDEA Download.png

/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}
@ Q -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ W -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ E -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ A -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[

---------- cut line ----------


> Path: gihyo.jp/kotlin_server_side_programming/01-001_preface
> Title: 01-001 Preface
> Short Description: By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4
> Link: https://gihyo.jp/book/2021/978-4-297-11859-4
> tags: kotlin spring boot
> Images: / gihyo.jp / kotlin_server_side_programming /
> create: 2022-09-13 화 12:23:52

# 01-001 Preface


![ 01-001 IntelliJ IDEA Download.png ](/gihyo.jp/kotlin_server_side_programming_img/01-001_intellij_idea_download.png
)

/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

----> 윗줄을 복사해서 사용합니다.


----> 이미지의 제목 입력 (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

----> 이미지별 일련번호 (00-000) 와 이미지에 대한 설명을 [ 01-001 IntelliJ IDEA Download.png ] 이와 같이 다음줄에 입력합니다. [ 엔터 ] 만 누르면 챕터 번호 입력으로 돌아갑니다.
^C
12:23:58 화 2022-09-13 yos@yosfedora ~/git-projects/fedora-sh/11-markdown-translate-EN-to-KO/gihyo.jp/2209-Kotlin_서버사이드_프로그래밍_실천개발-epub
2209-Kotlin_서버사이드_프로그래밍_실천개발-epub $ 
```
