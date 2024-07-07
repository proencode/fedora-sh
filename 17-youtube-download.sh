#!/bin/sh

VIDEO_DEFAULT="https://www.youtube.com/watch?v=YIU6a76PVvE"
VIDEO_URL=$1

if [ "x${VIDEO_URL}" = "x" ]; then
	cat <<__EOF__

----> youtube URL:
      or press Enter for ${VIDEO_DEFAULT}
__EOF__
	read VIDEO_URL
	if [ "x${VIDEO_URL}" = "x" ]; then
		VIDEO_URL=${VIDEO_DEFAULT}
	fi
fi

cat <<__EOF__

# sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm # RPMfusion 리파지토리 구성
# sudo dnf install youtube-dl libid3tag libmad opusfile sox ffmpeg ffmpeg-devel vlc # FFmpeg 설치

$0 $1 (${VIDEO_URL})

0... 어떤 자막이 있는지 확인하기
1... 자막 만 다운로드 하기
2... 1.5M .44  .mp3
3...  37M .6   .webm
4...  18M .3   .mp4
5...  31M .34  .flv
6... 8.6M .409 .ogg
7...  31M .192 .mkv
8...  24M .108 .avi

----> [1...8]:
__EOF__
read a

OPTVAL=""
if [ "x${a}" = "x0" ]; then
	OPTVAL="--list-subs"
else
if [ "x${a}" = "x1" ]; then
	OPTVAL="--all-subs --skip-download"
else
if [ "x${a}" = "x2" ]; then
	OPTVAL="-x --audio-format mp3"
else
if [ "x${a}" = "x3" ]; then
	OPTVAL=""
else
if [ "x${a}" = "x4" ]; then
	OPTVAL="-f mp4"
else
if [ "x${a}" = "x5" ]; then
	OPTVAL="-f flv"
else
if [ "x${a}" = "x6" ]; then
	OPTVAL="-f ogg"
else
if [ "x${a}" = "x7" ]; then
	OPTVAL="-f mkv"
else
if [ "x${a}" = "x8" ]; then
	OPTVAL="-f avi"
fi
fi
fi
fi
fi
fi
fi
fi
fi

echo "----> youtube-dl ${OPTVAL} ${VIDEO_URL}"
youtube-dl ${OPTVAL} ${VIDEO_URL}
echo "----> youtube-dl ${OPTVAL} ${VIDEO_URL}" > new.log
ls -lt > new.log
echo "----> youtube-dl ${OPTVAL} ${VIDEO_URL}" >> new.log
ls -lt new.log

bin_fs="${HOME}/bin/freesound"
#--
ding_play () {
	if [ "x$PLAY_OK" = "xok" ]; then #-- play 설치가 된 경우,
		if [ "x$1" = "x1" ]; then
			play -q ${bin_fs}/play-1-pbong.wav & #-- 91926__tim-kahn__ding.wav & #-- 0.3M 딩~
		else if [ "x$1" = "x2" ]; then
			play -q ${bin_fs}/play-2-castanets.wav & #-- 411459__inspectorj__castanets-multi-a-h1.wav & #-- 2.0M 캐스터네츠~
		else if [ "x$1" = "x3" ]; then
			play -q ${bin_fs}/play-3-ddenng.wav & #-- 339816__inspectorj__hand-bells-f-single.wav & #-- 1.5M 뗅-
		else if [ "x$1" = "x4" ]; then
			play -q ${bin_fs}/play-4-tiiill.wav & #-- 212541__misstickle__indian-bell-chime.wav & #-- 1.0M 띠일~
		else if [ "x$1" = "x5" ]; then
			play -q ${bin_fs}/play-5-gguuuung.wav & #-- 411090__inspectorj__wind-chime-gamelan-gong-a.wav & #-- 4.2M 데에엥~~
		else
			play -q ${bin_fs}/play-6-ddeeeng.wav & #-- 513865__wormletter__chime-c.wav & #-- 1.7M 교회 뎅-
		fi ; fi ; fi ; fi ; fi
	else
		echo "${cRed}~~~ play-${1} ~~~${cReset}"
	fi
}
PLAY_OK="ok" #-- 'ok' 인 경우만 사용할수 있다.
#--
ding_play 1 #-- 1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회 뎅-
#-- play -q ~/bin/freesound/play-1-pbong.wav & #-- 0.3M 91926__tim-kahn__ding.wav 딩~

cat >/dev/null <<__EOF__
.:
합계 739M
-rw-rw-r--. 1 yos yos    0  5월 24 11:30 10-donwload-size.ls-hlR (---> 3000  5월 24 11:32 10-donwload-size.ls-hlR)
-rw-rw-r--. 1 yos yos  24M  5월 14 21:55 Georgia Tech working with NASA to make the next generation of planetary rovers-YIU6a76PVvE.avi
-rw-rw-r--. 1 yos yos 1.5M  5월 14 21:55 Georgia Tech working with NASA to make the next generation of planetary rovers-YIU6a76PVvE.mp3
-rw-rw-r--. 1 yos yos  18M  5월 14 21:55 Georgia Tech working with NASA to make the next generation of planetary rovers-YIU6a76PVvE.mp4
-rw-rw-r--. 1 yos yos 1.7M  5월 14 21:55 Georgia Tech working with NASA to make the next generation of planetary rovers-YIU6a76PVvE.opus
-rw-rw-r--. 1 yos yos 108M  2월  8 09:41 Ingenious Construction Workers That Are At Another Level ▶12-4_ADKLM0pLQ.mp4
-rw-rw-r--. 1 yos yos 9.7M 10월 27  2019 New Bike Inventions That Are At Another Level ▶6-gVKTgaldTWA.opus
drwxrwxr-x. 2 yos yos 4.0K  5월 18 10:50 a
-rw-rw-r--. 1 yos yos  13K  5월 17 01:19 도이체벨레-강경화장관인터뷰-mB9HK4-g27Q.en.vtt
-rw-rw-r--. 1 yos yos  13K  5월 17 01:19 도이체벨레-강경화장관인터뷰-mB9HK4-g27Q.ko.vtt
-rw-rw-r--. 1 yos yos  14K  5월 24 00:41 미국 ABC ‘뉴스 라이브 프라임’ 강경화 외교부 장관 인터뷰 [한글자막 CC _ENG SUB]-Lnpmyjl9pi4.en.vtt
-rw-rw-r--. 1 yos yos  15K  5월 24 00:41 미국 ABC ‘뉴스 라이브 프라임’ 강경화 외교부 장관 인터뷰 [한글자막 CC _ENG SUB]-Lnpmyjl9pi4.ko.vtt
-rw-rw-r--. 1 yos yos  35M  5월 22 22:00 미국 ABC ‘뉴스 라이브 프라임’ 강경화 외교부 장관 인터뷰 [한글자막 CC _ENG SUB]-Lnpmyjl9pi4.mp4
-rw-rw-r--. 1 yos yos 476M 12월 19 21:14 생명의음표RNA-김빛내리-2019서울대자연과학대공개강연-X3_7vnXbrgI.mkv
-rw-rw-r--. 1 yos yos  54M  4월 15 11:25 택배 도둑맞은 NASA 전 직원의 복수 방법 (feat. 반짝이 폭탄)-_wgtmE_Pr7c.mp4
-rw-rw-r--. 1 yos yos  14M  5월 10 11:15 프로페셔널한 신진보가 목소리를 키워야! 이용우 당선자의 한국형 뉴딜 비판! 윤짜장이 홍남기 경제부총리만큼 참기름이지 않아서 다행이라고 해야 하나 ...-pSKVowlPtFI.mp3

./a:
합계 150M
-rw-rw-r--. 1 yos yos  37M  5월 14 21:55 00.6_200518-102806-102812.NO-PARA.webm-YIU6a76PVvE.webm
-rw-rw-r--. 1 yos yos  18M  5월 14 21:55 01.3_200518-102812-102815.-f.mp4-YIU6a76PVvE.mp4
-rw-rw-r--. 1 yos yos  31M  5월 14 21:55 02.34_200518-102815-102849.--recode-video.flv-YIU6a76PVvE.flv
-rw-rw-r--. 1 yos yos 8.6M  5월 14 21:55 03.409_200518-102849-103258.--recode-video.ogg-YIU6a76PVvE.ogg
-rw-rw-r--. 1 yos yos  31M  5월 14 21:55 04.192_200518-103258-103450.--recode-video.mkv-YIU6a76PVvE.mkv
-rw-rw-r--. 1 yos yos  24M  5월 14 21:55 05.108_200518-103450-103558.--recode-video.avi-YIU6a76PVvE.avi
-rw-rw-r--. 1 yos yos 1.5M  5월 14 21:55 06.44_200518-103558-103602.-x_--audio-format.mp3-YIU6a76PVvE.mp3
-rw-rw-r--. 1 yos yos 4.0K  5월 18 10:41 075-youtube-dl-sampling.sh
합계 21488
__EOF__
