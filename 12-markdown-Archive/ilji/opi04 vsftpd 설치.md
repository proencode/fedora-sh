240307 목 1040 푸른숲

출처: Ubuntu에서 사용자 디렉토리의 vsftpd를 설정하는 방법 20.04 - 211002 dioc: https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-20-04

# 1. vsftpd 프로그램 설치

```
sudo apt update && sudo apt upgrade -y
echo "♬---- sudo apt update && sudo apt upgrade -y"
sudo apt install vsftpd ufw
echo "♬---- sudo apt install vsftpd ufw"
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig #-- 수정 하기전 원본을 백업한다.
echo "♬---- sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig #-- 수정 하기전 원본을 백업한다."
touch ~/dioc-1._vsftpd_설치-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

# 2. 방화벽 열기

```
sudo ufw status #-- 방화벽 상태를 확인한다.
echo "♬---- sudo ufw status #-- 방화벽 상태를 확인한다."
sudo ufw enable #-- 방화벽을 실행한다
echo "♬---- sudo ufw enable #-- 방화벽을 실행한다"
sudo ufw allow OpenSSH
echo "♬---- sudo ufw allow OpenSSH"
sudo ufw allow 20,21,990/tcp #-- 포트를 열어서 20,21,990 TLS 를 활성화 한다.
echo "♬---- sudo ufw allow 20,21,990/tcp #-- 포트를 열어서 20,21,990 TLS 를 활성화 한다."
#--
#-- 55810:55812
#-- 56510:56512
#-- 58910:58912
#-- 59510:59512
#--
sudo ufw allow 55810:55812/tcp #-- 수동 포트를 설정한다.
#-- -----------^||^^-^||^^
echo "♬---- sudo ufw allow 55810:55812/tcp #-- 수동 포트를 설정한다."
#-- --♬--------------------^||^^-^||^^
sudo ufw status
echo "♬---- sudo ufw status"
touch ~/dioc-2.방화벽_열기-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

# 3. ftp 사용자 만들기

```
sudo adduser filebada #-- ftp 전용 사용자 만들기
echo "♬---- sudo adduser filebada #-- ftp 전용 사용자 만들기"
sudo mkdir /home/filebada/ftp #-- ftp 폴더 추가
echo "♬---- sudo mkdir /home/filebada/ftp #-- ftp 폴더 추가"
sudo chown nobody:nogroup /home/filebada/ftp #-- 소유권 설정
echo "♬---- sudo chown nobody:nogroup /home/filebada/ftp #-- 소유권 설정"
sudo chmod a-w /home/filebada/ftp #-- 쓰기 권한 제거
echo "♬---- sudo chmod a-w /home/filebada/ftp #-- 쓰기 권한 제거"
sudo mkdir /home/filebada/ftp/upload #-- 업로드 디렉토리 추가
echo "♬---- sudo mkdir /home/filebada/ftp/upload #-- 업로드 디렉토리 추가"
sudo chown filebada:filebada /home/filebada/ftp/upload #-- 소유권 지정
echo "♬---- sudo chown filebada:filebada /home/filebada/ftp/upload #-- 소유권 지정"
echo "vsftpd test file" | sudo tee /home/filebada/test.txt #-- 테스트에 쓸 파일
echo "♬---- echo \"vsftpd test file\" | sudo tee /home/filebada/test.txt #-- 테스트에 쓸 파일"
sudo ls -alR /home/filebada #-- 권한 등 확인
echo "♬---- sudo ls -alR /home/filebada #-- 권한 등 확인"
touch ~/dioc-3.사용자_디렉토리_준비-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

# 4. ftp 사용 조건을 설정하는 파일: vsftpd.conf

다음 명령으로 vsftpd 의 configure (구성) 파일을 수정한다.
```
sudo vi /etc/vsftpd.conf
touch ~/dioc-4._vsftpd_액세스_구성-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

수정한 내용을 `grep -B1 dioc /etc/vsftpd.conf` 명령으로 확인하였다.
`dioc-vsftpd.conf-01-install-ok` 와 뒤의 `:` 콜론 까지가 파일 이름이고,
`:` 콜론 의 뒷부분은 찾은 내용이다.
`:` 콜론 대신 `-` 마이너스 로 표시된 것은, 위 명령에서 `-B1` 조건을 줘서, 찾은줄의 윗줄 `1` 줄까지 보여주도록 했기 때문에, 추가로 보여주는 줄임을 나타내기 위한 것이다.
```
anonymous_enable=NO
#--dioc: https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-20-04

local_enable=YES
#--dioc:

write_enable=YES
#--dioc: #write_enable=YES

chroot_local_user=YES
#--dioc: #chroot_local_user=YES
user_sub_token=$USER
#--dioc:
local_root=/home/$USER/ftp
#--dioc:
#--
#-- 55810:55812
#-- 56510:56512
#-- 58910:58912
#-- 59510:59512
#--
pasv_min_port=55810
#-- ----------^||^^
#--dioc: 추가
pasv_max_port=55812
#-- ----------^||^^
#--dioc: 추가
userlist_enable=YES
#--dioc: 추가
userlist_file=/etc/vsftpd.userlist
#--dioc: 추가
userlist_deny=NO
#--dioc: 추가
```

# 5. 만든 ftp 사용자를 vsftpd 에 등록한다.

1. 사용자 등록

```
echo "filebada" | sudo tee -a /etc/vsftpd.userlist #-- 이 사용자로만 접속할수 있다.
echo "♬---- echo \"filebada\" | sudo tee -a /etc/vsftpd.userlist #-- 이 사용자로만 접속할수 있다."
sudo cat /etc/vsftpd.userlist #-- 맞는지 확인
echo "♬---- sudo cat /etc/vsftpd.userlist #-- 맞는지 확인"
sudo systemctl restart vsftpd #-- 변경한 구성으로 동작하기 위해 데몬을 다시 시작한다.
echo "♬---- sudo systemctl restart vsftpd #-- 변경한 구성으로 동작하기 위해 데몬을 다시 시작한다."
touch ~/dioc-5.ftp_접속_사용자_지정-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

2. 설정파일을 클라우드 디렉토리에 백업한다.

`rclone lsl yswone:vsftpd/`
```
     5850 2024-03-07 13:20:46.000000000 dioc-vsftpd.conf-00-origin
     6380 2024-03-07 13:37:17.000000000 dioc-vsftpd.conf-01-install-ok
        9 2024-03-07 13:37:35.000000000 dioc-vsftpd.userlist
```

3. WinSCP 등의 프로그램으로 ftp 접속을 확인한다.

# 6. 보안 연결

다음과 같이 2048 비트 RSA 키를 -days 1년간 쓸수 있도록 새 인증서를 만든다.
-keyout 과 -out 을 같은것으로 지정하면 개이키와 인증서가 같은 파일에 있도록 만든다.
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
echo "♬---- sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem"
touch ~/dioc-8.보안_연결-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

주소등의 정보는 자신에게 맞게 입력한다.
```
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:NY
Locality Name (eg, city) []:New York City
Organization Name (eg, company) [Internet Widgits Pty Ltd]:DigitalOcean
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []: your_server_ip
Email Address []:
```

이 경우, 설정파일로 들어가서,
```
sudo vi /etc/vsftpd.conf
touch ~/dioc-8-2.설정파일로_들어가서-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

원래의 내용을, 앞에 `#` 샵 기호를 붙여서 리마크로 바꾸어 주고,
```
# rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
# rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
```

앞에서 새로 만든 인증서와 개인 키 파일을 지정하도록 다음과 같이 추가한다.
```
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
```

이제 SSL을 강제로 사용하면 TLS를 처리 할 수없는 클라이언트가 연결되지 않는다.

이러한 모든 변경 사항이 적용된 후 파일의이 섹션이 표시되는 방법은 다음과 같다.
```
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
#rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
#rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH
```

변경 사항이 적용되도록 서버를 다시 시작한다.
```
sudo systemctl restart vsftpd
touch ~/dioc-8-2.서버를_다시_시작-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

# 7. 쉘 액세스 비활성화 (선택 사항)

1. 사용자에게 로그인 할 수 없는 이유를 알려주는 메시지를 추가한다.
```
cat <<__EOF__ | sudo tee -a /bin/ftponly
#!/bin/sh
echo "이 사용자는 FTP 만 쓰도록 지정돼 있습니다."
echo "This account is limited to FTP access only."
__EOF__
sudo chmod a+x /bin/ftponly
sudo cat /bin/ftponly
sudo chmod a+x /bin/ftponly
echo "/bin/ftponly" | sudo tee -a /etc/shells
sudo usermod filebada -s /bin/ftponly
touch ~/dioc-9.쉘_액세스_비활성화-$(date +%y%m%d%a-%H%M) ; ls -1 ~/dioc-*
```

2. WinSCP 등의 프로그램으로 ftp 접속을 확인한다.

딩동댕♪♭♬

# 8. winscp 로 vsftpd 연결

## 1. winscp 찾기

![ winscp 찾기 ](/ilji/2404/240402-01-wins-찾기.png =600x)

## 2. 로그인

![ 로그인 ](/ilji/2404/240402-02-login.png =600x)

## 3. FTP 선택

![ FTP 선택 ](/ilji/2404/240402-03-ftp-선택.png =600x)

## 4. TLS/SSL 선택

![ TLS/SSL 선택 ](/ilji/2404/240402-04-tls-ssl-선택.png =600x)

## 5. 호스트이름, 포트번호, 사용자이름

![ 호스트이름, 포트번호, 사용자이름 ](/ilji/2404/240402-05-호스트-포트-사용자.png =600x)

## 6. 비밀번호 입력

![ 비밀번호 입력 ](/ilji/2404/240402-06-비번.png =600x)

## 7. vsftpd 서버로 들어감

![ vsftpd 서버로 들어감 ](/ilji/2404/240402-07-vsftpd-in.png =600x)

