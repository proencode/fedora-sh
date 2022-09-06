### 목적

1. 윈도우10 에서 VirtualBox 로 fedora 시스템을 운영한다.
2. wiki.js 위키를 집 안의 다른 PC 에서도 볼 수 있도록 한다.

# 윈도우 에서 ip 주소 확인

출처: https://www.cyberciti.biz/faq/how-to-find-my-public-ip-address-from-command-line-on-a-linux/

1. 윈도우 키를 누르고, `cmd` 를 입력하면, 검은 터미널 화면이 나온다.
```
Microsoft Windows [Version 10.0.22000.675]
(c) Microsoft Corporation. All rights reserved.

C:\Users\user>
```

2. 터미널에 `ipconfig` 명령을 입력해서, 윈도우 PC의 ip주소를 확인한다.

```
C:\Users\user> ipconfig
Windows IP 구성


이더넷 어댑터 이더넷:

   연결별 DNS 접미사. . . . :
   링크-로컬 IPv6 주소 . . . . : fe80::f485:f96b:3237:d649%9
   IPv4 주소 . . . . . . . . . : 192.168.100.104
   서브넷 마스크 . . . . . . . : 255.255.255.0
   기본 게이트웨이 . . . . . . : 192.168.100.1

이더넷 어댑터 VirtualBox Host-Only Network:

   연결별 DNS 접미사. . . . :
   링크-로컬 IPv6 주소 . . . . : fe80::c898:6af8:f4a7:5fb7%8
   IPv4 주소 . . . . . . . . . : 192.168.56.1
   서브넷 마스크 . . . . . . . : 255.255.255.0
   기본 게이트웨이 . . . . . . :

C:\Users\user>
```

- 위에 보면 `이더넷 어댑터 xxx` 가 두개 나온다.
1. 이더넷 어댑터 이더넷:
  이더넷 어댑터의 이름이 `이더넷:` 인것이 먼저 나온다.
  이것이 원래 PC 에 달려있는, 인터넷을 위한 이더넷 이다.
  그 아래를 보면, `IPv4 주소` 는 `192.168.100.104` 로 되어 있다.
  이 숫자를 ip번호로 쓰면 된다.
2. 이더넷 어댑터 VirtualBox Host-Only Network:
  이더넷 어댑터의 이름이 `VirtualBox Host-Only Network:` 이다.
  이것은 버추얼 박스에서 호스트와 통신하기 위한 네트워크인데, IP 주소가 `192.168.56.1` 로 돼 있다.
  
# 공유기에서 포트 포워딩 지정

집 안으로 들어온 인터넷 라인에 연결된 공유기에서, 다음과 같이 포트 포워딩을 지정한다.

| Ethernet (wifi) PORT | 해당PC의 IP:포트 | 사용자 및 PC |
|:---:|:---:|----|
| 4800 (14800) | 192.168.219.48:4800 | pi4b |
| 5800 (15800) | 192.168.219.58:5800 | ysgiga |
| 6500 (16500) | 192.168.219.65:6500 | mygram |
| 8900 (18900) | 192.168.219.89:8900 | hnleno |
| 9500 (19500) | 192.168.219.95:9500 | hmdell |

# Fedora 에서 ip 주소 확인

다음과 같이 입력한다.
```
ifconfig | grep -B1 netmask
```
실행 결과:
```
enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.101  netmask 255.255.255.0  broadcast 192.168.56.255
```

# 버추얼박스 에서 포트 포워딩 지정

호스트 (Windows) 의 포트 번호를 게스트 (VirtualBox에 설치한 Fedora) 의 포트와 연결한다
  - VirtualBox >> 네트워크 >> 어댑터 1 >> 포트 포워딩 >> 포트 포워딩 규칙

| 이름 | 프로토콜 | 호스트 IP:포트 (PC쪽) | 게스트 IP:포트(VirtualBox쪽) |
|---|---|---|---|
| wikijs | TCP | 192.168.219.89 : 8900 | 192.168.56.101 : 5800 |

# 게스트 이름 지정하기

## 내부망에서 (= 집 컴퓨터 끼리만) 쓰려면,

| 브라우저에서 `hd:5800` 와 같이 hd 라는 이름을 쓰기 위해서 |
|:---:|
| (윈도우) C:\Windows\System32\drivers\etc\hosts |
| (리눅스) /etc/hosts |
| `192.168.219.58 hd` 로 지정한다. |

## 외부망에서 (= 집 바깥에서) 연결해 쓰려면,

### 1. 도메인 이름과 포트 번호 지정하기

도메인 이름이 없으면, duckdns.org 등에서 무료 DNS 서비스를 받아도 된다.

```
proen.duckdns.org:15800 |
```

### 2. 공유기에 지정한 포트포워딩으로 집 컴퓨터에 들어오는거 허락하기

| 외부(인터넷쪽) 도메인 이름:포트 (또는) 외부 ip:포트 | 내부 (집 컴퓨터) ip:포트 |
|:---:|:---:|
| proen.duckdns.org:15800 (또는) 116.39.226.45:15800 | 192.168.219.58:5800 |

### 3. 공유기에 지정한 포트포워딩으로 VirtualBox 까지 들어오는거 허락하기

| 외부 (인터넷 쪽) 도메인:포트 | 호스트 (윈도우) IP:포트 | 게스트 (버철박스) IP:포트 |
|:---:|:---:|:---:|
| proen.duckdns.org:15822 | 192.168.219.58:4444 | 192.168.56.101:22 |
| proen.duckdns.org:15800 | 192.168.219.58:5800 | 192.168.56.101:5800 |

- 외부 PC 에서 내부 PC 의 VirtualBox 접속하기 설명자료:
https://shutcoding.tistory.com/9

## 공인 IP 확인

```
dig +short myip.opendns.com @resolver1.opendns.com

dig TXT +short o-o.myaddr.l.google.com @ns1.google.com

dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'

dig +short txt ch whoami.cloudflare @1.0.0.1

host myip.opendns.com resolver1.opendns.com

curl ifconfig.co
```

# 윈도우 10 컴퓨터에 고정 IP 설정하기

출처: https://netu.co.kr/atboard_view.php?model=&grp1=support&grp2=faq&uid=16405&keyfield=all&keyword=&page=7

1. 바탕화면에 있는 `제어판` 클릭
--> 제어판이 없다면,
바탕화면 빈곳 > 오른쪽 마우스 클릭 > `개인 설정` 클릭 >
`테마` > `바탕화면아이콘 설정` > [`v`] 제어판 에 체크
2. `제어판` > `네트워크 및 인터넷`>'네트워크 상태 및 작업 보기` 또는 `네트워크 및 공유센터`
1. `어댑터 설정 변경`
1. 마우스로 `이더넷` 아이콘 클릭 > `속성` 클릭
1. 이더넷 속성에서 `인터넷 프로토콜 버전 4 (TCP/IPv4)` 를 `더블클릭`
1. (`o`) 다음 IP 주소 사용 에 클릭하고,
`IP주소`
`서브넷 마스크`
`기본 게이트웨이`
(`o`) 다음 DNS 서버 주소 사용 에 클릭,
`기본 DNS`
`보조 DNS` 를 입력한다.
1. 위와 같이 수동으로 입력한 IP 주소를 -> 자동으로 변경하려면,
(`o`) 자동으로 IP 주소 받기 에 클릭
(`o`) 자동으로 DNS 서버 주소 받기 에 클릭 한다.

