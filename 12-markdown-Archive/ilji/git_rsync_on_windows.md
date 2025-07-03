## window에 rsync설치하고 사용하는 방법
by 까느.dev 2024. 7. 2. https://7daysmornig.tistory.com/79

1. Git을 기본적으로 설치하여야 한다.
1. https://repo.msys2.org/msys/x86_64/ 를 통해 rsync-버전_x86_64.pkg.tar.zst를 다운로드한다.
ilji/2024/2409/[rsync-3.3.0-1-x86_64.pkg.tar.zst](ilji/2024/2409/rsync-3.3.0-1-x86_64.pkg.tar.zst)
1. Git에 rsync패키지 복사하기 C:\Program Files\Git\usr\bin\ 경로에 rsync-3.2.3–1-x86_64.pkg\usr\bin\에 있는 rsync.exe파일을 복사한다.
1. rsync만으로 실행은 안되고 dependent 패키지를 다운로드 및 동일하게 GIT 폴더에 복사해주어야 한다.
- libopenssl https://repo.msys2.org/msys/x86_64/libopenssl-3.3.1-1-x86_64.pkg.tar.zst
- libxxhash https://repo.msys2.org/msys/x86_64/llibxxhash-0.8.2-1-x86_64.pkg.tar.zst
- libzstd https://repo.msys2.org/msys/x86_64/llibzstd-1.5.6-1-x86_64.pkg.tar.zst

### Add rsync to Windows git bash
Utilizing power of rsync inside git bash Prasanna Wijesiriwardana Dec 25, 2020
https://prasaz.medium.com/add-rsync-to-windows-git-bash-f42736bae1b3

### 윈도우용 zstd
빠른 무손실 압축 알고리즘 및 데이터 압축 도구

1. 윈도우용 zstd: https://sourceforge.net/projects/zstd-for-windows/

(1) zstd 다운로드 링크: https://sourceforge.net/projects/zstd-for-windows/files/latest/download

(2) zstd_Windows7[MinGW](static).zip 압축해제:
$ ls -l
total 3984
drwxr-xr-x 1 USER 197121       0  7월  2 11:59 'zstd_Windows7[MinGW](static)'/
-rw-r--r-- 1 USER 197121  612861  7월  2 11:59 'zstd_Windows7[MinGW](static).zip'

$ ls -l zstd_Windows7\[MinGW\]\(static\)/zstd_Win32/
total 1472
-rwxr-xr-x 1 USER 197121 1504288  7월  2 11:59 zstd.exe*

(3) https://repo.msys2.org/msys/x86_64/ 접속해서,
rsync 최종버전: rsync-3.4.1-1-x86_64.pkg.tar.zst (16-Jan-2025 08:36 368K) 를 받는다.

(4) rsync-3.2.3–1-x86_64.pkg\usr\bin\ 에 있는 rsync.exe 파일을
Git 폴더인 C:\Program Files\Git\usr\bin\ 경로에 복사한다.



### [압축 방식 비교] gzip / snappy / lz4 / brotli / zstd / lzo
출처: https://data-engineer-tech.tistory.com/35 [데이터 엔지니어 기술 블로그:티스토리] jun_yeong_park 2021. 7. 10. 12:05

