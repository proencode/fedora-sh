#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="Fedora LAMP WordPress 설치 방법"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cat <<__EOF__

${cRed}1. 아파치 HTTP 서버 설치${cReset}

__EOF__

cmdYenter "sudo dnf install httpd httpd-tools" "(1-1) httpd 패키지를 설치합니다."

cmdYenter "sudo httpd -v" "(1-2) 설치된 Apache 서버 버전을 확인합니다."
cat <<__EOF__

${cRed}(1-2) ${cCyan}위 내역이 다음과 같이 나오면, 정상입니다.
결과:${cReset}

Server version: Apache/2.4.52 (Fedora Linux)
Server built:   Dec 22 2021 00:00:00

${cCyan}----> ${cRed}(1-2) ${cCyan}press Enter:${cReset}
__EOF__
read a

cat <<__EOF__

${cRed}(1-3) ${cCyan}/etc/httpd/conf/httpd.conf 구성 파일을 열고 서버 이름을 다음과 같이 지정합니다.${cReset}

...
ServerName myirm.duckdns.org:2080${cYellow}
           ################# ####
           ||||||||||||||||| ++++---- 포트번호 (2080).
	   +++++++++++++++++--------- 서버의 이름을 지정 (myirm.duckdns.org)${cReset}
...
<Directory "/var/www/html">
    ...
    AllowOverride All
    ...
</Directory>
...

${cCyan}----> ${cRed}(1-3) ${cCyan}press Enter:${cReset}
__EOF__
read a

cmdRun "grep ServerName /etc/httpd/conf/httpd.conf" "(1-3) 기존의 ServerName 을 확인합니다."
cmdYenter "sudo vi /etc/httpd/conf/httpd.conf ; reset" "(1-3) 위 설명과 같이 서버의 이름을  직접  지정합니다."
cmdRun "grep ServerName /etc/httpd/conf/httpd.conf" "(1-3) 바뀐 ServerName 을 확인합니다."

cat <<__EOF__

${cRed}(1-4) ${cCyan}구성을 확인하여 오류가 있는지 확인하십시오.${cReset}

__EOF__

chdRun "sudo apachectl configtest" "(1-4) 구성 확인."

cat <<__EOF__

${cCyan}위 확인결과가 다음과 같이 ok 가 나와야 합니다.${cReset}

Syntax OK

${cCyan}----> ${cRed}(1-4) ${cCyan}press Enter:${cReset}
__EOF__
read a

cat <<__EOF__

${cRed}(1-5) ${cCyan}로컬 방화벽에서 TCP 포트 80(HTTP) 를 엽니다.${cReset}

__EOF__

cmdRun "sudo firewall-cmd --add-service=http --permanent" "(1-5)"
cmdRun "sudo firewall-cmd --reload" "(1-5)"
cmdRun "sudo firewall-cmd --list-services" "(1-5)"

cat <<__EOF__

${cRed}(1-6) ${cCyan}결과: 방화벽에 http 가 추가되었습니다${cReset}

dhcpv6-client http mdns samba-client ssh

__EOF__

cmdYenter "sudo systemctl enable --now httpd" "(1-7) httpd 서비스를 활성화하고 시작합니다."

cat <<__EOF__

${cRed}(1-7) ${cCyan}이때, VirtualBox 에서 fedora 를 실행하는 경우에는,
host 의 VirtualBox 프로그램에서,
네트워크 > 어댑터1 > '어댑터에 브리지', 어탭터2 > '호스트 전용 어댑터' 로 지정합니다.
${cReset}
__EOF__


cmdRun "ifconfig | grep -B1 mask" "(1-8) 다음 명령으로 현재의 ip 를 확인합니다."

cat <<__EOF__

${cRed}(1-8) ${cCyan}확인 결과:${cReset}

enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.219.101  netmask 255.255.255.0  broadcast 192.168.219.255${cYellow}
             ###############
	     +++++++++++++++---- httpd 서버의 IP 주소 (= 192.168.219.101)${cReset}
--
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0

${cCyan}----> ${cRed}(1-8) ${cCyan}press Enter:${cReset}
__EOF__
read a

cat <<__EOF__

${cRed}(1-9) ${cCyan}IP 와 서버 이름을 지정합니다.${cReset}

127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.219.101  myirm.duckdns.org${cYellow}
                 #################
		 +++++++++++++++++---- TLS 암호화를 하기위해 필요한 IP 와 서버이름${cCyan}

이제 웹 브라우저를 열고 주소 표시줄에 http://myirm.duckdns.org 또는 localhost 을 입력하십시오.

${cCyan}----> ${cRed}(1-9) ${cCyan}press Enter:${cReset}
__EOF__
read a

cmdCont "sudo vi /etc/hosts ; reset" "(1-9) httpd 서버의 IP 주소 지정."
cmdCont "sudo cat /etc/hosts" "(1-10) 확인"


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
