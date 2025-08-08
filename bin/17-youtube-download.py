# yt_dlp 모듈 다운로드: 50개의 프로젝트로 완성하는 파이썬 업무 자동화 / 오토코더 지음 / 위즈앤북
import yt_dlp

# 다운로드 받고싶은 유튜브 URL 입력
urls = ("https://www.youtube.com/watch?v=DeMxqQaxvNU",
        "https://www.youtube.com/watch?v=mRzPKMcYdYI")

for url in urls:
    print("#-- 1. YoutubeDL 객체를 만들며 outtmpl 옵션으로 다운로드 받을 위치를 지정.")
    # ydl = yt_dlp.YoutubeDL({"outtmpl": "C:/AutoCoder/%(title)s.%(ext)s"})
    ydl = yt_dlp.YoutubeDL({"outtmpl": "${HOME}/다운로드/%(title)s.%(ext)s"})
    print("#-- 2. 동영상의 메타데이터를 딕셔너리 형태로 저장.")
    info_dict = ydl.extract_info(url, download=True)
    print("#-- 3. 동영상이 다운로드 완료될 때까지 대기.")
    ydl.download([url])
    print("#-- 4. 동영상의 제목과 파일 경로를 출력.")
    print("#--    제목: ", info_dict(["title"])
    print("#--    재생시간(초): ", info_dict["duration"])
