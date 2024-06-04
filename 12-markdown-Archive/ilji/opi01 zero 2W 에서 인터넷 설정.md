
# nmtui 실행

### 네트웍을 관리하는 텍스트 ui 프로그램 `"nmtui"` 를 실행한다.
```
$ nmtui
  -----
```

- chrome 브라우저 설정 = `모양` > `글꼴 맞춤설정` > `고정폭 글꼴` > Noto Sans Mono` 로 지정해야 박스표시가 깨지지 않는다.
- Brave 브라우저 설정 = `모양` > `콘텐츠` > `글꼴 맞춤설정` > `고정폭 글꼴` > `Lucida Console` 또는 `Noto Sans Mono` 지정.

## 1. 네트워크 연결을 활성화

### 1-1. 연결 활성화를 선택한다.
```
┌─┤ NetworkManager TUI ├──┐
│                         │ 
│ Please select an option │ 
│                         │ 
│ Edit a connection       │ 
│ Activate a connection   │ <---- 연결 활성화 선택
│ Set system hostname     │ 
│                         │ 
│ Quit                    │ 
│                    <OK> │ 
└─────────────────────────┘ 
```

### 1-2. Wired (유선) 과 Wi-Fi (무선) 연결을 활성화 한다.

Opi zero2W 에 유선 랜 케이블을 꽂으면, Opi 가 랜 연결 (activate) 활성화를 하고 공유기를 찾으므로, 공유기에서 그 Wired (유선) 랜 포트에 랜덤으로 지정한 ip 주소를 지정해 준다.

Wi-Fi (무선) 은 Opi zero2W 를 켜면, 어느 공유기에 연결할지 모르므로 (주위에 있는 모든 무선 공유기를 알아볼 수는 있는데, 어디에 연결할지는 모르므로) 연결을 수동으로 활성화 시켜줘야 한다.

아래 화면에서, Wired (유선) 은 연결이 되어 있으므로, 앞에 `*` 별 표시가 있다.
Wi-Fi (무선) 은 아직 연결된 것이 없으므로, 앞에 `*` 별 표시 된것은 없다.
```
┌──────────────────────────────────────────────────────────┐
│ ┌─────────────────────────────────────────┐              │
│ │ Wired                                 ↑ │ <Deactivate> │ <---- 선택한 것을 취소할떄만
│ │ * Wired connection 1                  ▒ │              │
│ │                                       ▒ │              │
│ │ Wi-Fi                                 ▮ │              │
│ │   U+Net5A21                     ▂▄▆█  ▒ │              │
│ │   U+Net5A21_5G                  ▂▄▆█  ▒ │              │
│ │   [air purifier] Samsung        ▂▄__  ▒ │              │
│ │   SO070VOIP7B49                 ▂▄__  ▒ │              │
│ │   U+NetD5AB                     ▂___  ▒ │              │
│ │   iptime                        ▂___  ▒ │              │
│ │   [LG_FloorStand A/C]145b       ▂___  ▒ │              │
│ │   SK_WiFiGIGA80A8_2.4G          ▂___  ▒ │              │
│ │   DIRECT-5D-SA SL-J1560W Series ▂___  ▒ │              │
│ │                                       ▒ │              │
│ │                                       ▒ │              │
│ │                                       ↓ │ <Back>       │
│ └─────────────────────────────────────────┘              │
└──────────────────────────────────────────────────────────┘
```

### 1-3. 와이파이 중에서 쓸수 있는 공유기를 엔터키를 눌러서 선택한다.

상하 화살표 키를 눌러서 현재 사용하고 있는 와이파이로 가서 엔터키를 눌러 선택한다.
```
│ ┌─────────────────────────────────────────┐              │
│ │ Wired                                 ↑ │ <Activate>   │
│ │ * Wired connection 1                  ▒ │              │
│ │                                       ▒ │              │
│ │ Wi-Fi                                 ▒ │              │
│ │   U+Net5A21                     ▂▄▆█  ▒ │              │ <---- 엔터
│ │   U+Net5A21_5G                  ▂▄▆█  ▒ │              │
│ │   [air purifier] Samsung        ▂▄__  ▒ │              │
│ │   U+NetE800_5G                  ▂▄__  ▒ │              │
```

### 1-4. 공유기에 지정된 와이파이 비번을 입력한다.

비번 입력후 `[tab]` `[tab]` `[Enter]` 를 눌러 저장한다.
```
   │ │   U+NetE800                     ▂▄__  ▒ │              │
 ┌───────┤ Authentication required by wireless network ├────────┐
 │                                                              │
 │ Passwords or encryption keys are required to access the      │
 │ wireless network 'U+Net5A21'.                                │ <---- 선택한 와이파이
 │                                                              │
 │     Password **********____________________                  │ <---- 무선비번 입력
 │                                                              │
 │                                                <Cancel> <OK> │
 └──────────────────────────────────────────────────────────────┘
   │ │                                       ▒ │              │
```

### 1-5. 무선이 선택 되었으므로 (`*`) 표시가 된다. 이를 취소하려면 `<Deactivate>` 를 누른다.
```
│ │ Wired                               ↑ │ <Deactivate> │ <---- 무선 취소할때
│ │ * Wired connection 1                ▒ │              │ 
│ │                                     ▒ │              │ 
│ │ Wi-Fi                               ▮ │              │ 
│ │ * U+Net5A21                   ▂▄▆█  ▒ │              │ <---- 무선 선택됐음
│ │   U+Net5A21_5G                ▂▄▆█  ▒ │              │ 
│ │   [air purifier] Samsung      ▂▄__  ▒ │              │ 
│ │   SO070VOIP7B49               ▂▄__  ▒ │              │ 
│ │                                     ▒ │              │ 
│ │                                     ▒ │              │ 
│ │                                     ↓ │ <Back>       │ <---- 나가기
```
와이파이 설정이 다 됐으므로, `<Back>` 을 눌러서 나간다.
- 이 상태에서는 공유기에서 랜덤으로 ip 번호를 골라서 지정해 준다. (유동 IP)

## 2. 고정 ip 를 유/무선에 지정

### 2-1. 고정 ip 로 지정하기 위해 연결수정 으로 간다.
```
┌─┤ NetworkManager TUI ├──┐
│                         │
│ Please select an option │
│                         │
│ Edit a connection       │ <---- 연결수정 선택
│ Activate a connection   │
│ Set system hostname     │
│                         │
│ Quit                    │
│                    <OK> │
└─────────────────────────┘
```

### 2-2. 유선을 선택하고 수정으로 들어간다.
```
┌───────────────────────────────────────┐
│ ┌─────────────────────────┐           │
│ │ Ethernet              ↑ │ <Add>     │
│ │   Wired connection 1  ▒ │           │ <---- 1. 유선을 선택하고
│ │ Wi-Fi                 ▒ │ <Edit...> │ <---- 2. 수정 선택
│ │   U+Net5A21           ▒ │           │
│ │                       ▒ │ <Delete>  │
│ │                       ▒ │           │
│ │                       ▮ │           │
│ │                       ▒ │           │
│ │                       ▒ │           │
│ │                       ↓ │ <Back>    │
│ └─────────────────────────┘           │
└───────────────────────────────────────┘

311 ~ ~ ~ ~

┌────────────────────┤ Edit Connection ├──────────────────┐
│                                                         │
│  Profile name Wired connection 1______________________  │
│        Device eth0 (F2:DB:79:7A:C6:84)________________  │
│                                                         │
│ ═ ETHERNET                                    <Show>    │
│                                                         │
│ ═ IPv4 CONFIGURATION <Automatic>              <Show>    │ <---- Auto 선택
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │
│                                                         │
│ [X] Automatically connect                               │
│ [X] Available to all users                              │
│                                           <Cancel> <OK> │
└─────────────────────────────────────────────────────────┘

312 ~ ~ ~ ~

│  Profile name Wired connection 1______________________  │
│        Device eth0 (F2:DB:79:7A:C6:84)________________  │
│                                                         │
│ ═ ETHERNET          ┌────────────┐            <Show>    │
│                     │ Disabled   │                      │
│ ═ IPv4 CONFIGURATION│ Automatic  │            <Show>    │
│ ═ IPv6 CONFIGURATION│ Link-Local │            <Show>    │
│                     │ Manual     │                      │ <---- Manual 선택
│ [X] Automatically co│ Shared     │                      │
│ [X] Available to all└────────────┘                      │
│                                                         │
│                                           <Cancel> <OK> │

313 ~ ~ ~ ~

│ ═ ETHERNET                                    <Show>    │
│                                                         │
│ ═ IPv4 CONFIGURATION <Manual>                 <Show>    │ <---- Show 선택
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │

314 ~ ~ ~ ~

│ ╤ IPv4 CONFIGURATION <Manual>                 <Hide>    │
│ │          Addresses <Add...>                           │ <---- Add 선택
│ │            Gateway _________                          │
│ │        DNS servers <Add...>                           │
│ │     Search domains <Add...>                           │

315 ~ ~ ~ ~

│ ═ ETHERNET                                    <Show>    │
│                                                         │
│ ╤ IPv4 CONFIGURATION <Manual>                 <Hide>    │
│ │          Addresses 192.168.999.33___________ <Remove> │ <---- 유선 ip 지정
│ │                    <Add...>                           │
│ │            Gateway 192.168.999.1____________          │ <---- 게이트웨이
│ │        DNS servers 168.126.63.1_____________ <Remove> │ <---- KT 서버
│ │                    <Add...>                           │
│ │     Search domains <Add...>                           │
│ │                                                       │
│ │            Routing (No custom routes) <Edit...>       │
│ │ [ ] Never use this network for default route          │
│ │ [ ] Ignore automatically obtained routes              │
│ │ [ ] Ignore automatically obtained DNS parameters      │
│ │                                                       │
│ │ [ ] Require IPv4 addressing for this connection       │
│ └                                                       │
│                                                         │
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │
│                                                         │
│ [X] Automatically connect                               │
│ [X] Available to all users                              │
│                                                         │
│                                           <Cancel> <OK> │ <---- OK
```

### 2-3. 유선을 선택하고 수정으로 들어간다.
```
│ ┌─────────────────────────┐           │
│ │ Ethernet              ↑ │ <Add>     │
│ │   Wired connection 1  ▒ │           │
│ │ Wi-Fi                 ▒ │ <Edit...> │
│ │   U+Net5A21           ▒ │           │ <---- Wi-Fi에 놓고 Edit 선택
│ │                       ▒ │ <Delete>  │

321 ~ ~ ~ ~

┌────────────────────┤ Edit Connection ├──────────────────┐
│                                                         │
│  Profile name U+Net5A21_______________________________  │
│        Device wlan0 (34:BE:2D:72:C9:52)_______________  │
│                                                         │
│ ╤ WI-FI                                       <Hide>    │
│ │        SSID U+Net5A21_______________________________  │
│ │        Mode <Client>                                  │
│ │                                                       │
│ │    Security <WPA & WPA2 Personal>                     │
│ │    Password **********______________________________  │
│ │             [ ] Show password                         │
│ │                                                       │
│ │              BSSID _________________________________  │
│ │ Cloned MAC address _________________________________  │
│ │                MTU __________ (default)               │
│ └                                                       │
│                                                         │
│ ═ IPv4 CONFIGURATION <Automatic>              <Show>    │ <---- Auto 선택
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │
│                                                         │
│ [X] Automatically connect                               │
│ [X] Available to all users                              │
│                                           <Cancel> <OK> │
└─────────────────────────────────────────────────────────┘

322 ~ ~ ~ ~

│ └                   ┌────────────┐                      │
│                     │ Disabled   │                      │
│ ═ IPv4 CONFIGURATION│ Automatic  │            <Show>    │
│ ═ IPv6 CONFIGURATION│ Link-Local │            <Show>    │
│                     │ Manual     │                      │ <---- Manual 선택
│ [X] Automatically co│ Shared     │                      │
│ [X] Available to all└────────────┘                      │

323 ~ ~ ~ ~

│ ═ IPv4 CONFIGURATION <Manual>                 <Show>    │ <---- Show 선택
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │

324 ~ ~ ~ ~

┌────────────────────┤ Edit Connection ├───────────────────┐
│                                                         ↑│
│  Profile name U+Net5A21_______________________________  ▮│
│        Device wlan0 (34:BE:2D:72:C9:52)_______________  ▒│
│                                                         ▒│
│ ╤ WI-FI                                         <Hide>  ▒│
│ │        SSID U+Net5A21_______________________________  ▒│
│ │        Mode <Client>                                  ▒│
│ │                                                       ▒│
│ │    Security <WPA & WPA2 Personal>                     ▒│
│ │    Password **********______________________________  ▒│
│ │             [ ] Show password                         ▒│
│ │                                                       ▒│
│ │              BSSID _________________________________  ▒│
│ │ Cloned MAC address _________________________________  ▒│
│ │                MTU __________ (default)               ▒│
│ └                                                       ▒│
│                                                         ▒│
│ ╤ IPv4 CONFIGURATION <Manual>                   <Hide>  ▒│ <---- Manual Show
│ │          Addresses 192.168.999.133___ <Remove>        ▒│ <---- 무선 ip 지정
│ │                    <Add...>                           ▒│
│ │            Gateway 192.168.999.1_____                 ▒│ <---- 게이트웨이
│ │        DNS servers 168.126.63.1______ <Remove>        ▒│ <---- KT 서버
│ │                    <Add...>                           ▒│
│ │     Search domains <Add...>                           ▒│
│ │                                                       ▒│
│ │            Routing (No custom routes) <Edit...>       ▒│
│ │ [ ] Never use this network for default route          ▒│
│ │ [ ] Ignore automatically obtained routes              ▒│
│ │ [ ] Ignore automatically obtained DNS parameters      ▒│
│ │                                                       ▒│
│ │ [ ] Require IPv4 addressing for this connection       ▒│
│ └                                                       ▒│
│                                                         ▒│
│ ═ IPv6 CONFIGURATION <Automatic>               <Show>   ▒│
│                                                         ▒│
│ [X] Automatically connect                               ▒│
│ [X] Available to all users                              ▒│
│                                            <Cancel> <OK>▮│ <---- OK
│                                                         ↓│
└──────────────────────────────────────────────────────────┘

325 ~ ~ ~ ~

┌───────────────────────────────────────┐
│ ┌─────────────────────────┐           │
│ │ Ethernet              ↑ │ <Add>     │
│ │   Wired connection 1  ▒ │           │
│ │ Wi-Fi                 ▒ │ <Edit...> │
│ │   U+Net5A21           ▒ │           │
│ │                       ▒ │ <Delete>  │
│ │                       ▒ │           │
│ │                       ▮ │           │
│ │                       ↓ │ <Back>    │ <---- Back
│ └─────────────────────────┘           │
└───────────────────────────────────────┘
```

## 3. 연결 확인

### 3-1. 연결의 등록이 끝났으므로 활성화 작업으로 들어간다.
```
┌─┤ NetworkManager TUI ├──┐
│                         │
│ Please select an option │
│                         │
│ Edit a connection       │
│ Activate a connection   │ <---- Activate 선택
│ Set system hostname     │
│                         │
│ Quit                    │
│                    <OK> │
└─────────────────────────┘

411 ~ ~ ~ ~

┌───────────────────────────────────────────────┐
│ ┌──────────────────────────────┐              │
│ │ Wired                      ↑ │ <Deactivate> │
│ │ * Wired connection 1       ▒ │              │
│ │                            ▒ │              │
│ │ Wi-Fi                      ▒ │              │
│ │ * U+Net5A21          ____  ▒ │              │
│ │                            ▒ │              │
│ │                            ↓ │ <Back>       │ 활성 (*표시) 됐으므로 돌아간다.
│ └──────────────────────────────┘              │
└───────────────────────────────────────────────┘

412 ~ ~ ~ ~

┌─┤ NetworkManager TUI ├──┐
│                         │ 
│ Please select an option │ 
│                         │ 
│ Edit a connection       │ 
│ Activate a connection   │
│ Set system hostname     │ 
│                         │ 
│ Quit                    │ <---- Quit
│                    <OK> │ 
└─────────────────────────┘ 
```

### 3-2. ip 가 제대로 지정됐는지 확인한다.
```
$ ifconfig
  --------
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.999.104  netmask 255.255.255.0  broadcast 192.168.999.255
        inet6 fe80::76da:c6b2:a4d4:c905  prefixlen 64  scopeid 0x20<link>
        ether f2:db:79:7a:c6:84  txqueuelen 1000  (Ethernet)
        RX packets 5982  bytes 483959 (483.9 KB)
        RX errors 0  dropped 2146  overruns 0  frame 0
        TX packets 1183  bytes 273129 (273.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 51  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.999.111  netmask 255.255.255.0  broadcast 192.168.999.255
        inet6 fe80::42ce:c2cc:c392:887  prefixlen 64  scopeid 0x20<link>
        ether 34:be:2d:72:c9:52  txqueuelen 1000  (Ethernet)
        RX packets 11  bytes 2704 (2.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 18  bytes 1588 (1.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

### 3-3. 여기에 표시된 ip 는 새로 지정하기 전의 ip 이므로 재부팅 해야 한다.
```
$ sudo reboot
[sudo] password for orangepi:
Connection to 192.168.999.104 closed by remote host.
Connection to 192.168.999.104 closed.
```

## 4. 다른 PC 에서 로그인

### 4-1. orangePi 를 재부팅 해서 연결이 끊어졌으므로, 다른 PC 에서 다시 로그인 한다.
```
$ ssh orangepi@192.168.999.104
  ----------------------------
ssh: connect to host 192.168.999.104 port 22: No route to host
$
```
ip 가 바뀌었으므로 이전의 ip 를 지정하면 위와 같이 오류가 뜬다.

### 4-2. 새로 지정한 ip 로 로그인 한다.
```
$ ssh orangepi@192.168.999.133
  ----------------------------
The authenticity of host '192.168.999.133 (192.168.999.133)' can't be established.
ED25519 key fingerprint is SHA256:QWOWy0S9IhCbQN8YSjSXNym5U/mOnqp4Etbs3lQSoyY.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:14: 192.168.999.104
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.999.133' (ED25519) to the list of known hosts.
orangepi@192.168.999.133's password: 
  ___  ____ ___   _____             ______        __
 / _ \|  _ \_ _| |__  /___ _ __ ___|___ \ \      / /
| | | | |_) | |    / // _ \ '__/ _ \ __) \ \ /\ / / 
| |_| |  __/| |   / /|  __/ | | (_) / __/ \ V  V /  
 \___/|_|  |___| /____\___|_|  \___/_____| \_/\_/   
                                                    
Welcome to Orange Pi 1.0.0 Jammy with Linux 6.1.31-sun50iw9

System load:   26%           	Up time:       4 min	Local users:   2            
Memory usage:  4% of 3.84G  	IP:	       192.168.999.33 192.168.999.133
CPU temp:      50°C           	Usage of /:    13% of 15G    	

[ 0 security updates available, 2 updates total: apt upgrade ]
Last check: 2023-10-14 03:41

[ General system configuration (beta): orangepi-config ]

Last login: Sat Oct 14 03:41:11 2023
orangepi@orangepizero2w:~$
```

### 4-3. 네트워크를 확인한다.
```
$ ifconfig
  --------
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.999.33  netmask 255.255.255.0  broadcast 192.168.999.255
        inet6 fe80::76da:c6b2:a4d4:c905  prefixlen 64  scopeid 0x20<link>
        ether f2:db:79:7a:c6:84  txqueuelen 1000  (Ethernet)
        RX packets 289  bytes 29111 (29.1 KB)
        RX errors 0  dropped 114  overruns 0  frame 0
        TX packets 133  bytes 15269 (15.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 51  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.999.133  netmask 255.255.255.0  broadcast 192.168.999.255
        inet6 fe80::42ce:c2cc:c392:887  prefixlen 64  scopeid 0x20<link>
        ether 34:be:2d:72:c9:52  txqueuelen 1000  (Ethernet)
        RX packets 4  bytes 328 (328.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 972 (972.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
ip 가 지정해준 대로 되어있다.

### 4-4. 다음과 같이 "tm" 이란 문자가 있는 줄만 표시할수도 있다.
```
$ ifconfig | grep -B1 tm
  ----------------------
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.999.33  netmask 255.255.255.0  broadcast 192.168.999.255
--
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
--
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.999.133  netmask 255.255.255.0  broadcast 192.168.999.255
orangepi@orangepizero2w:~$ 
```

### 4-5. 비밀번호를 변경해준다.
```
$ sudo passwd orangepi
  --------------------
[sudo] password for orangepi: 
New password: 
Retype new password: 
passwd: password updated successfully
orangepi@orangepizero2w:~$ 
```

## 5. ip 주소 대신 이름 사용하기

위와 같이 ip 주소를 고정으로 해 놓았으면, 이 장비에 로그인하려는 PC 쪽에서는 다음과 같이 지정하면 ip 주소 대신에 이름을 쓸 수 있다.

### 5-1. Linux:

`/etc/hosts` 파일에 다음과 같이 `ip 주소`와 `이름`을 기록한다.
첫칸에 샤프`#`표시가 있는 줄은 참고 설명이다.
```
sudo vi /etc/hosts
...
192.168.999.133 opw
#-------------- ===
#-- ip 주소----- ==이름(Orange pi zero 2w wifi)==
...
```

위와 같이 지정하면, 다음의 두가지 방법으로 로그인 할 수 있다.
```
$ ssh orangepi@192.168.999.133
  ----------------------------
  또는,
$ ssh orangepi@opw
  ----------------
```

### 5-2. Windows:

`C:\Windows\etc\hosts` 파일에 위 Linux 와 같은 방법으로 ip 주소와 이름을 기록한다.

