#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="Apache HTTP 서버에 TLS 암호화 추가"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

seqno="(2-1)"
cat <<__EOF__

2. Apache HTTP 서버에 TLS 암호화 추가

${seqno} 먼저 mod_ssl 모듈을 설치해야 합니다. 이 모듈은 SSL(Secure Sockets Layer) 및 TLS(Transport Layer Security) 프로토콜을 통해 Apache HTTP 서버에 강력한 암호화를 제공합니다.

__EOF__
cmdCont "sudo dnf install mod_ssl" "${seqno}"

seqno="(2-2)"
cat <<__EOF__

${seqno} 그런 다음 openssl 명령줄 도구를 사용하여 자체 서명된 TLS 인증서를 생성하여 HTTPS 연결을 활성화해야 합니다. 아래 명령을 사용하여 개인 키와 공개 인증서를 생성하십시오.

__EOF__
cmdCont "sudo dnf install openssl" "${seqno}"

seqno="(2-3)"
cat <<__EOF__

${seqno} 설정에 따라 질문에 답하고 정보를 제공하십시오. 일반 이름을 입력하라는 메시지가 표시되면 서버 이름을 (이 예에서는 wpress.vbox.jj) 제공합니다.

Generating a RSA private key
..............................................++++
......................................++++
writing new private key to '/etc/pki/tls/private/wpress.vbox.jj.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:KR
                                  ##-- 국가 이름 2자리
State or Province Name (full name) []:gyeonggi-do
                                      ###########-- 도 이름
Locality Name (eg, city) [Default City]:Namyangju
                                        #########-- 시 이름
Organization Name (eg, company) [Default Company Ltd]:Proen
                                                      #####-- 회사이름
Organizational Unit Name (eg, section) []:WebDev
                                          ######-- 조직 이름
Common Name (eg, your name or your server's hostname) []:wpress.vbox.jj
                                                         ##############-- 서버 이름
Email Address []:jjedu@outlook.kr
                 ################-- 이메일

__EOF__
cmdCont "sudo openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -out /etc/pki/tls/certs/wpress.vbox.jj.crt -keyout /etc/pki/tls/private/wpress.vbox.jj.key" "${seqno}"

seqno="(2-4)"
cat <<__EOF__

${seqno} 새로 생성된 인증서를 검토합니다.

__EOF__
cmdCont "sudo openssl x509 -text -noout -in /etc/pki/tls/certs/wpress.vbox.jj.crt" "${seqno}"

seqno="(2-5)"
cat <<__EOF__

${seqno} /etc/httpd/conf.d/ssl.conf 파일을 열고 다음 줄을 편집/추가합니다.

__EOF__
cmdCont "sudo vim /etc/httpd/conf.d/ssl.conf" "${seqno}"

seqno="(2-6)"
cat <<__EOF__

${seqno} 서버 이름을 끼워넣는다.

...
<VirtualHost _default_:443>
    ...
    ServerName wpress.vbox.jj:443
               ##################
    SSLCertificateFile /etc/pki/tls/certs/wpress.vbox.jj.crt
                                          ##################
    SSLCertificateKeyFile /etc/pki/tls/private/wpress.vbox.jj.key
                                               ##################
    ...
</VirtualHost>

<VirtualHost *:80>
    ServerName wpress.vbox.jj
               ##############
    Redirect permanent / https://wpress.vbox.jj
                                 ##############
</VirtualHost>

위 설정파일에서

지시문 <VirtualHost default:443> 은 HTTPS 서버 이름과 TLS 인증서의 위치를 지정합니다.
지시문 <VirtualHost \*:80> 은 주소가 HTTP로 지정된 경우 서버가 HTTPS 로 리디렉션하도록 지시합니다.
이제 로컬 방화벽에서 TCP 포트 443 (HTTPS) 를 엽니다.

__EOF__

cmdCont "sudo firewall-cmd --add-service=https --permanent" "${seqno}"
cmdCont "sudo firewall-cmd --reload" "${seqno}"
cmdCont "sudo firewall-cmd --list-services" "${seqno} 결과: dhcpv6-client http https mdns samba-client ssh"

seqno="(2-7)"
cat <<__EOF__

${seqno} httpd 서비스를 다시 시작하십시오.

__EOF__

cmdCont "sudo systemctl restart httpd" "${seqno}"

cat <<__EOF__

웹 브라우저를 열고 이제 https://wpress.vbox.jj 로 주소 표시줄에 입력하여 HTTPS 연결로 웹 페이지를 엽니다.

자체 서명된 인증서를 사용하고 있으므로 경고 메시지가 표시됩니다. 괜찮아요; 단순히 위험을 감수하고 계속하십시오.
__EOF__


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
