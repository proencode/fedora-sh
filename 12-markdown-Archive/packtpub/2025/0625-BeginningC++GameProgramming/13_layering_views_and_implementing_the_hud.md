
| ≪ [ 12 Collision Detection Pickups and Bullets ](/books/packtpub/2025/0625_beginning_c++_game_programming/12) | 13 Layering Views and Implementing the HUD | [ 14 Sound Effects File IO and Finishing the Game ](/books/packtpub/2025/0625_beginning_c++_game_programming/14) ≫ |
|:----:|:----:|:----:|

# 13 Layering Views and Implementing the HUD
#----> 본문을 기재하는 위치.



| ≪ [ 12 Collision Detection Pickups and Bullets ](/books/packtpub/2025/0625_beginning_c++_game_programming/12) | 13 Layering Views and Implementing the HUD | [ 14 Sound Effects File IO and Finishing the Game ](/books/packtpub/2025/0625_beginning_c++_game_programming/14) ≫ |
|:----:|:----:|:----:|

> (1) Title: 13 Layering Views and Implementing the HUD
> (2) Short Description: John Horton May 2024 648 pages 3rd Edition
> (3) Path: /books/packtpub/2025/0625_beginning_c++_game_programming/13
> (4) tags: C++, game
> (5) .md 파일의 이름: 13_layering_views_and_implementing_the_hud.md
> (6) 이미지 저장폴더: ./img_0625/13
> (7) 이미지링크 예시: ![ 설명 ](/img/packtpub/2025/img_0625/13/99-예시_이미지.webp)
> 책이름: Beginning C++ Game Programming
> 안내: https://www.packtpub.com/en-us/product/beginning-c-game-programming-9781835088258
> 서문: https://subscription.packtpub.com/book/game-development/9781835081747/pref
> 독서시작일: 2025-07-19 토 13:19:37

---------- cut line ----------

https://coldmater.tistory.com/226
Vim 에서 매크로 등록하고 실행하기
1. 알파벳(a-z), 숫자(0-9) 중 1 글자로 된 '레지스터' 를 정해서
   +---+----------+
   | q | 레지스터 | 로 매크로 기록을 시작한다.
   +---+----------+
- 'q' 를 누르고, 레지스터 이름으로 a-z, 0-9 중 하나를 정해서 입력하면
  (레지스터로 'a'를 입력했다고 가정)
  상태표시줄에 'Recording @a' 라고 표시되면서 실제 명령어를 입력받을 준비가 된다.
- 명령어를 다 입력했으면, 다시 `q` 를 눌러서 매크로 기록을 끝낸다.
   +---+----------+
2. | @ | 레지스터 | 로 레지스터 에 저장된 매크로를 실행한다.
   +---+----------+
   +----+
3. | @@ | 로 직전에 실행한 매크로를 다시한번 실행한다.
   +----+
   +----------+---+----------+      +----------+----+
4. | 반복횟수 | @ | 레지스터 | 또는 | 반복횟수 | @@ | 로 저장된 매크로를
   +----------+---+----------+      +----------+----+
   '반복횟수' 만큼 재실행 할수 있다.
5. 또는, 아래와 같이 타이핑할 매크로 를 vi 로 입력해 놓고,
                +---+----------+----+
해당 줄 위에서, | " | 레지스터 | yy | 로 레지스터에 저장할수 있다.
                +---+----------+----+

**ff-func-key-setting.vi**
|   q   |   w   |   e   |   r   |   t   |   y   |   u   |   i   |   o   |   p   |
:------:|------:|------:|------:|------:|------:|------:|------:|------:|------:|
|- 'X': |'''Expl| 'XX'Δ | 'XX'. | 'XX', | 'XX'; | 'XX') | 'XX': | 'XX'} |       |
|'=BackQuote    |Δ=space|       |       |       |       |       |       |       |
|   a   |   s   |   d   |   f   |   g   |   h   |   j   |   k   |   l   |   ;   |
|-**X**:|  ###  |**X**_ |**X**. |**X**, |**X**; |**X**) |**X**: |**X**} |       |
|       |       |       |       |       |       |       |       |       |       |
|   z   |   x   |   c   |   v   |   b   |   n   |   m   |   ,   |   .   |   /   |
|       |       |       |       |       |       |       |       |       |       |
|       |       |       |       |       |       |       |       |       |       |

---------- cut line ----------
