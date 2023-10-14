# Orange Pi zero 2W 에서 인터넷 설정

## 1. zero 2W 의 ip 확인하기

zero 2W 에 모니터,키보드를 연결하지 않고 다른 PC 에서 연결하려면, zero 2W 에는 유선을 연결해 놓고, 다른 PC 에서 다음과 같이 zero 의 ip 를 확인하는 스크립트를 만든다.
```
$ cat ping2.sh 
  ------------
#!/bin/sh

for i in {11..199}
do
	ping -c 1 192.168.219.${i}  | grep "시간=" &
done
```

스크립트를 실행한다.
```
$ sh ping2.sh 
  -----------
64 바이트 (192.168.219.13에서): icmp_seq=1 ttl=64 시간=0.038 ms
11:30:15토231014 yos@yscart ~/git-projects/fedora-sh
fedora-sh $ 64 바이트 (192.168.219.108에서): icmp_seq=1 ttl=64 시간=97.9 ms
64 바이트 (192.168.219.104에서): icmp_seq=1 ttl=64 시간=0.232 ms
64 바이트 (192.168.219.106에서): icmp_seq=1 ttl=64 시간=112 ms
64 바이트 (192.168.219.112에서): icmp_seq=1 ttl=64 시간=0.042 ms
64 바이트 (192.168.219.105에서): icmp_seq=1 ttl=64 시간=408 ms
```

ip 를 하나씩 연결해 본다.
```
$ sh orangepi@192.168.219.104
  ---------------------------
The authenticity of host '192.168.219.104 (192.168.219.104)' can't be established.
ED25519 key fingerprint is SHA256:QWOWy0S9IhCbQN8YSjSXNym5U/mOnqp4Etbs3lQSoyY.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.219.104' (ED25519) to the list of known hosts.
orangepi@192.168.219.104's password: 
  ___  ____ ___   _____             ______        __
 / _ \|  _ \_ _| |__  /___ _ __ ___|___ \ \      / /
| | | | |_) | |    / // _ \ '__/ _ \ __) \ \ /\ / / 
| |_| |  __/| |   / /|  __/ | | (_) / __/ \ V  V /  
 \___/|_|  |___| /____\___|_|  \___/_____| \_/\_/   
                                                    
Welcome to Orange Pi 1.0.0 Jammy with Linux 6.1.31-sun50iw9

System load:   27%           	Up time:       3 min	Local users:   2            
Memory usage:  4% of 3.84G  	IP:	       192.168.219.104
CPU temp:      47°C           	Usage of /:    13% of 15G    	

[ 0 security updates available, 2 updates total: apt upgrade ]
Last check: 2023-10-14 02:28

Last login: Wed Sep 13 04:29:06 2023
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

orangepi@orangepizero2w:~$
```
무사히 로그인이 되었다.

네트웍을 관리하는 텍스트 ui 프로그램 nmtui 를 실행한다.
```
$ nmtui
  -----
```

연결을 활성화한다.
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

Wired (유선)이 활성화 된것을 비활성화 시키려면, <Deactivate> 를 클릭하면 비활성 된다.
```
┌──────────────────────────────────────────────────────────┐
│ ┌─────────────────────────────────────────┐              │
│ │ Wired                                 ↑ │ <Deactivate> │ <---- 유선 취소할떄만
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

상하 화살표 키를 눌러서 와이파이 중에서 쓸수 있는 공유기를 엔터키를 눌러서 선택한다.
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

공유기에 지정된 와이파이 비번을 입력한다.
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

무선이 선택 되었으므로 (*) 표시가 된다. 이를 취소하려면 <Deactivate> 를 누른다.
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
와이파이 설정이 다 됐으므로, <Back> 을 눌러서 나간다.

이제, ip 등을 지정해야 하므로 연결수정 으로 간다.
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

유선을 선택하고 수정으로 들어간다.
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

~ ~ ~ ~

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

~ ~ ~ ~

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

~ ~ ~ ~

│ ═ ETHERNET                                    <Show>    │
│                                                         │
│ ═ IPv4 CONFIGURATION <Manual>                 <Show>    │ <---- Show 선택
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │

~ ~ ~ ~

│ ╤ IPv4 CONFIGURATION <Manual>                 <Hide>    │
│ │          Addresses <Add...>                           │ <---- Add 선택
│ │            Gateway _________                          │
│ │        DNS servers <Add...>                           │
│ │     Search domains <Add...>                           │

~ ~ ~ ~

│ ═ ETHERNET                                    <Show>    │
│                                                         │
│ ╤ IPv4 CONFIGURATION <Manual>                 <Hide>    │
│ │          Addresses 192.168.219.59___________ <Remove> │ <---- 유선 ip 지정
│ │                    <Add...>                           │
│ │            Gateway 192.168.219.1____________          │ <---- 게이트웨이
│ │        DNS servers 8.8.8.8__________________ <Remove> │ <---- 구글 서버
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

유선을 선택하고 수정으로 들어간다.
```
│ ┌─────────────────────────┐           │
│ │ Ethernet              ↑ │ <Add>     │
│ │   Wired connection 1  ▒ │           │
│ │ Wi-Fi                 ▒ │ <Edit...> │
│ │   U+Net5A21           ▒ │           │ <---- Wi-Fi에 놓고 Edit 선택
│ │                       ▒ │ <Delete>  │

~ ~ ~ ~

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

~ ~ ~ ~

│ └                   ┌────────────┐                      │
│                     │ Disabled   │                      │
│ ═ IPv4 CONFIGURATION│ Automatic  │            <Show>    │
│ ═ IPv6 CONFIGURATION│ Link-Local │            <Show>    │
│                     │ Manual     │                      │ <---- Manual 선택
│ [X] Automatically co│ Shared     │                      │
│ [X] Available to all└────────────┘                      │

~ ~ ~ ~

│ ═ IPv4 CONFIGURATION <Manual>                 <Show>    │ <---- Show 선택
│ ═ IPv6 CONFIGURATION <Automatic>              <Show>    │

~ ~ ~ ~

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
│ │          Addresses 192.168.219.159___ <Remove>        ▒│ <---- 무선 ip 지정
│ │                    <Add...>                           ▒│
│ │            Gateway 192.168.219.1_____                 ▒│ <---- 게이트웨이
│ │        DNS servers 8.8.8.8___________ <Remove>        ▒│ <---- 구글 서버
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

~ ~ ~ ~

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

연결의 등록이 끝났으므로 활성화 작업으로 들어간다.
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

~ ~ ~ ~

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

~ ~ ~ ~

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

ip 가 제대로 지정됐는지 확인한다.
```
$ ifconfig
  --------
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.219.104  netmask 255.255.255.0  broadcast 192.168.219.255
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
        inet 192.168.219.111  netmask 255.255.255.0  broadcast 192.168.219.255
        inet6 fe80::42ce:c2cc:c392:887  prefixlen 64  scopeid 0x20<link>
        ether 34:be:2d:72:c9:52  txqueuelen 1000  (Ethernet)
        RX packets 11  bytes 2704 (2.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 18  bytes 1588 (1.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

여기에 표시된 ip 는 새로 지정하기 전의 ip 이므로 재부팅 해야 한다.
```
$ sudo reboot
[sudo] password for orangepi:
Connection to 192.168.219.104 closed by remote host.
Connection to 192.168.219.104 closed.
```

다시 로그인 한다.
```
$ ssh orangepi@192.168.219.104
  ----------------------------
ssh: connect to host 192.168.219.104 port 22: No route to host
```
ip 가 바뀌었으므로 이전의 ip 를 지정하면 오류가 뜬다.

새로 지정한 ip 로 로그인 한다.
```
$ ssh orangepi@192.168.219.159
  ----------------------------
The authenticity of host '192.168.219.159 (192.168.219.159)' can't be established.
ED25519 key fingerprint is SHA256:QWOWy0S9IhCbQN8YSjSXNym5U/mOnqp4Etbs3lQSoyY.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:14: 192.168.219.104
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.219.159' (ED25519) to the list of known hosts.
orangepi@192.168.219.159's password: 
  ___  ____ ___   _____             ______        __
 / _ \|  _ \_ _| |__  /___ _ __ ___|___ \ \      / /
| | | | |_) | |    / // _ \ '__/ _ \ __) \ \ /\ / / 
| |_| |  __/| |   / /|  __/ | | (_) / __/ \ V  V /  
 \___/|_|  |___| /____\___|_|  \___/_____| \_/\_/   
                                                    
Welcome to Orange Pi 1.0.0 Jammy with Linux 6.1.31-sun50iw9

System load:   26%           	Up time:       4 min	Local users:   2            
Memory usage:  4% of 3.84G  	IP:	       192.168.219.59 192.168.219.159
CPU temp:      50°C           	Usage of /:    13% of 15G    	

[ 0 security updates available, 2 updates total: apt upgrade ]
Last check: 2023-10-14 03:41

[ General system configuration (beta): orangepi-config ]

Last login: Sat Oct 14 03:41:11 2023
orangepi@orangepizero2w:~$
```

네트워크를 확인한다.
```
$ ifconfig
  --------
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.219.59  netmask 255.255.255.0  broadcast 192.168.219.255
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
        inet 192.168.219.159  netmask 255.255.255.0  broadcast 192.168.219.255
        inet6 fe80::42ce:c2cc:c392:887  prefixlen 64  scopeid 0x20<link>
        ether 34:be:2d:72:c9:52  txqueuelen 1000  (Ethernet)
        RX packets 4  bytes 328 (328.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 972 (972.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
ip 가 지정해준 대로 되어있다.

다음과 같이 "tm" 이란 문자가 있는 줄만 표시할수도 있다.
```
$ ifconfig | grep -B1 tm
  ----------------------
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.219.59  netmask 255.255.255.0  broadcast 192.168.219.255
--
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
--
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.219.159  netmask 255.255.255.0  broadcast 192.168.219.255
orangepi@orangepizero2w:~$ 
```

비밀번호를 변경해준다.
```
$ sudo passwd orangepi
  --------------------
[sudo] password for orangepi: 
New password: 
Retype new password: 
passwd: password updated successfully
orangepi@orangepizero2w:~$ 
```
