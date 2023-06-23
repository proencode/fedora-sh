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

seqno="(1-1)"

cmdYenter "sudo dnf install httpd httpd-tools" "${seqno} httpd 패키지를 설치합니다."

seqno="(1-2)"

cmdRun "sudo httpd -v" "${seqno} 설치된 Apache 서버 버전을 확인합니다."
cat <<__EOF__

${cRed}${seqno} ${cCyan}위 내역이 다음과 같이 나오면, 정상입니다.${cGreen}
Server version: Apache/2.4.52 (Fedora Linux)
Server built:   Dec 22 2021 00:00:00

${cCyan}----> ${cRed}${seqno} ${cCyan}press Enter:${cReset}
__EOF__
read a

seqno="(1-3)"

cat <<__EOF__

${cRed}${seqno} ${cCyan}/etc/httpd/conf/httpd.conf 구성 파일을 열고 서버 이름을 다음과 같이 지정합니다.${cGreen}
ServerName wpress.vbox.jj:80${cYellow}
           ############## ##
           |||||||||||||| ++---- 포트번호 (80).
	   ++++++++++++++------- 서버의 이름을 지정 (wpress.vbox.jj)${cGreen}
...
<Directory "/var/www/html">
    ...
    AllowOverride All
    ...
</Directory>
...

__EOF__

cmdYenter "grep ServerName /etc/httpd/conf/httpd.conf" "${seqno} 기존의 ServerName 을 확인합니다.${cGreen}"

seqno="(1-4)"

cat <<__EOF__

${cRed}${seqno} ${cCyan}위 설명과 같이 ServerName 을 찾아서, 서버의 이름을 '직접' 지정합니다.

__EOF__

cmdYenter "sudo vi /etc/httpd/conf/httpd.conf ; reset" "${seqno}"
cmdRun "grep ServerName /etc/httpd/conf/httpd.conf" "${seqno} 바뀐 ServerName 을 확인합니다."

seqno="(1-5)"

cat <<__EOF__

${cRed}${seqno} ${cCyan}구성을 확인하여 오류가 있는지 확인하십시오.${cReset}

__EOF__

cmdRun "sudo apachectl configtest" "${seqno} 구성 확인."

cat <<__EOF__

${cRed}${seqno} ${cCyan}위 확인결과가 다음과 같이 ok 가 나와야 합니다.${cGreen}
Syntax OK

${cCyan}----> ${cRed}${seqno} ${cCyan}press Enter:${cReset}
__EOF__
read a

seqno="(1-6)"

cat <<__EOF__

${cRed}${seqno} ${cCyan}로컬 방화벽에서 (TCP 포트 80 = HTTP) 를 엽니다.${cReset}

__EOF__

cmdRun "sudo firewall-cmd --add-service=http --permanent" "${seqno}"
cmdRun "sudo firewall-cmd --reload" "${seqno}"

seqno="(1-7)"

cmdRun "sudo firewall-cmd --list-services" "${seqno} http 를 추가했으므로, 이 명령을 수행하면 'http' 가 표시돼야 합니다."
cat <<__EOF__
${cGreen}
dhcpv6-client http mdns samba-client ssh
${cReset}
__EOF__

seqno="(1-8)"

cmdYenter "sudo systemctl enable --now httpd" "${seqno} httpd 서비스를 활성화하고 시작합니다."

cat <<__EOF__

${cRed}${seqno} ${cCyan}이때, VirtualBox 에서 fedora 를 실행하는 경우에는,
host 의 VirtualBox 프로그램에서,
${cYellow}네트워크 > 어댑터1 > '어댑터에 브리지', 어탭터2 > '호스트 전용 어댑터' ${cCyan}로 지정합니다.
${cReset}
__EOF__


cmdRun "ifconfig | grep -B1 mask" "${seqno} 다음 명령으로 현재의 ip 를 확인합니다."

seqno="(1-9)"

cat <<__EOF__

${cRed}${seqno} ${cCyan}확인 결과:${cGreen}

enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.101  netmask 255.255.255.0  broadcast 192.168.56.255${cYellow}
             ##############
	     ++++++++++++++---- httpd 서버의 IP 주소가 (192.168.56.101 처럼) 되어야 합니다.${cGreen}
--
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0

${cCyan}----> ${cRed}${seqno} ${cCyan}press Enter:${cReset}
__EOF__
read a

seqno="(1-10)"

cat <<__EOF__

${cRed}${seqno} ${cCyan}IP 와 서버 이름을 지정합니다.${cGreen}

127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.219.101  wpress.vbox.jj${cYellow}
                 ##############
		 ++++++++++++++---- TLS 암호화를 하기위해 필요한 IP 와 서버이름${cCyan}

이제 웹 브라우저를 열고 주소 표시줄에 http://wpress.vbox.jj 또는 localhost 을 입력하십시오.
${cReset}
__EOF__

cmdCont "sudo vi /etc/hosts ; reset" "${seqno} httpd 서버의 IP 주소 지정."
cmdRun "sudo cat /etc/hosts" "${seqno} 확인${cGreen}"


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
