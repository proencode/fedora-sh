
## Fedora LAMP WordPress 설치 방법

LAMP 스택을 사용하여 Fedora에 WordPress를 설치하는 방법

마두 데 사이2022년 8월 19일 업데이트 https://sysguides.com/install-wordpress-on-fedora/

![install-wordpress-on-fedora-apache-fi](/ilji/2023-05/00-install-wordpress-on-fedora-apache-fi.png)

### 1. 아파치 HTTP 서버 설치

httpd 패키지를 설치합니다.
```
sudo dnf install httpd httpd-tools
```

설치된 Apache 서버 버전을 확인합니다.
```
sudo httpd -v
```
결과:
```
Server version: Apache/2.4.52 (Fedora Linux)
Server built:   Dec 22 2021 00:00:00
```

/etc/httpd/conf/httpd.conf 구성 파일을 열고 서버 이름을 설정
```
sudo vi /etc/httpd/conf/httpd.conf
```
서버 이름 지정
```
...
ServerName wpress.vbox.jj:80
...
<Directory "/var/www/html">
    ...
    AllowOverride All
    ...
</Directory>
...
```

구성을 확인하여 오류가 있는지 확인하십시오.
```
sudo apachectl configtest
```
다음과 같이 ok 가 나와야 한다.
```
Syntax OK
```

로컬 방화벽에서 TCP 포트 80(HTTP) 를 엽니다.
```
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-services
```
결과: (방화벽에 http 가 추가되었다)
```
dhcpv6-client http mdns samba-client ssh
```

httpd 서비스를 활성화하고 시작합니다.
```
sudo systemctl enable --now httpd
```

이때, VirtualBox 에서 fedora 를 실행하는 경우에는,
host 의 VirtualBox 프로그램에서, 네트워크 > 어댑터1 > '어댑터에 브리지', 어탭터2 > '호스트 전용 어댑터' 로 지정한다.

다음 명령으로 현재의 ip 를 확인한다.
```
ifconfig | grep -B1 netm
```
결과:
```
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.219.101  netmask 255.255.255.0  broadcast 192.168.219.255
--
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
```

httpd 서버의 IP 주소 (위의 경우: 192.168.219.101) 를 설정합니다.
```
sudo vi /etc/hosts
```
IP 와 서버 이름을 지정한다.
```
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.219.101  wpress.vbox.jj
                 ##############-- TLS 암호화를 하기위해 필요한 IP 와 서버이름
```

이제 웹 브라우저를 열고 주소 표시줄에 http://wpress.vbox.jj 또는 localhost 을 입력하십시오.

### 2. Apache HTTP 서버에 TLS 암호화 추가

먼저 mod_ssl 모듈을 설치해야 합니다. 이 모듈은 SSL(Secure Sockets Layer) 및 TLS(Transport Layer Security) 프로토콜을 통해 Apache HTTP 서버에 강력한 암호화를 제공합니다.
```
sudo dnf install mod_ssl
```

그런 다음 openssl 명령줄 도구를 사용하여 자체 서명된 TLS 인증서를 생성하여 HTTPS 연결을 활성화해야 합니다. 아래 명령을 사용하여 개인 키와 공개 인증서를 생성하십시오.
```
sudo dnf install openssl
sudo openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes \
  -out /etc/pki/tls/certs/wpress.vbox.jj.crt \
  -keyout /etc/pki/tls/private/wpress.vbox.jj.key
```
설정에 따라 질문에 답하고 정보를 제공하십시오. 일반 이름을 입력하라는 메시지가 표시되면 서버 이름을 (이 예에서는 wpress.vbox.jj) 제공합니다.
```
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
```
새로 생성된 인증서를 검토합니다.
```
sudo openssl x509 -text -noout \
  -in /etc/pki/tls/certs/wpress.vbox.jj.crt
```

/etc/httpd/conf.d/ssl.conf 파일을 열고 다음 줄을 편집/추가합니다.
```
sudo vim /etc/httpd/conf.d/ssl.conf
```
서버 이름을 끼워넣는다.
```
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
```
위 설정파일에서
- 지시문 `<VirtualHost default:443>` 은 HTTPS 서버 이름과 TLS 인증서의 위치를 지정합니다.
- 지시문 `<VirtualHost \*:80>` 은 주소가 HTTP로 지정된 경우 서버가 HTTPS 로 리디렉션하도록 지시합니다.
이제 로컬 방화벽에서 TCP 포트 443 (HTTPS) 를 엽니다.
```
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-services
```
결과:
```
dhcpv6-client http https mdns samba-client ssh
```
httpd 서비스를 다시 시작하십시오.
```
sudo systemctl restart httpd
```
웹 브라우저를 열고 이제 https://wpress.vbox.jj 로 주소 표시줄에 입력하여 HTTPS 연결로 웹 페이지를 엽니다. 자체 서명된 인증서를 사용하고 있으므로 경고 메시지가 표시됩니다. 괜찮아요; 단순히 위험을 감수하고 계속하십시오.

### 3. MariaDB 데이터베이스 서버 설치

MariaDB에 사용 가능한 모듈 스트림을 나열합니다.
```
sudo dnf module list mariadb
```
결과:
```
Fedora Modular 35 - x86_64
Name      Stream   Profiles                             Summary
mariadb   10.3     client, devel, galera, server [d]    MariaDB: a very fast and robust SQL database server
mariadb   10.4     client, devel, galera, server [d]    MariaDB: a very fast and robust SQL database server
mariadb   10.5     client, devel, galera, server [d]    MariaDB: a very fast and robust SQL database server

Fedora Modular 35 - x86_64 - Updates
Name      Stream   Profiles                             Summary
mariadb   10.3     client, devel, galera, server [d]    MariaDB: a very fast and robust SQL database server
mariadb   10.4     client, devel, galera, server [d]    MariaDB: a very fast and robust SQL database server
mariadb   10.5     client, devel, galera, server [d]    MariaDB: a very fast and robust SQL database server
mariadb   10.6     client, devel, galera, server        MariaDB: a very fast and robust SQL database server
mariadb   10.7     client, devel, galera, server        MariaDB: a very fast and robust SQL database server

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
```

MariaDB 10.7 모듈 스트림을 활성화합니다.
```
sudo dnf module enable mariadb:10.7
```

이제 MariaDB 데이터베이스 서버를 설치합니다.
```
sudo dnf install mariadb-server
```

설치된 버전을 확인합니다.
```
sudo mariadb -V
```
결과:
```
mariadb  Ver 15.1 Distrib 10.7.1-MariaDB, for Linux (x86_64) using  EditLine wrapper
```

mariadb 서비스를 활성화하고 시작합니다.
```
sudo systemctl enable --now mariadb
```

이제 mariadb-secure-installation쉘 스크립트를 실행하여 MariaDB 설치를 보호하십시오. 스크립트에 대한 자세한 내용은 보안 설치 (https://mariadb.com/kb/en/mysql_secure_installation/) 에 대한 MariaDB 기술 자료 페이지를 참조하십시오 . 루트 사용자에 대해 암호가 없는 보안 메커니즘인 unix_socket (https://mariadb.com/kb/en/authentication-plugin-unix-socket/) 인증을 사용하겠습니다 . unix_socket 인증 플러그인을 사용하면 root로컬 Unix 소켓 파일을 통해 MariaDB에 연결할 때 운영 체제 자격 증명을 사용할 수 있습니다.
```
sudo mariadb-secure-installation
```
다음과 같이 지정한다.
```
    Enter current password for root (enter for none):
                                                      #-- Enter
    Switch to unix_socket authentication [Y/n] Y
                                               #
    Change the root password? [Y/n] n
                                    #
    Remove anonymous users? [Y/n] Y
                                  #
    Disallow root login remotely? [Y/n] Y
                                        #
    Remove test database and access to it? [Y/n] Y
                                                 #
    Reload privilege tables now? [Y/n] Y    
                                       #
```

MariaDB 설치가 완료되었습니다. 남은 것은 데이터베이스 파일을 만들 때 데이터베이스 파일에서 CoW를 비활성화하는 것입니다. 이는 BTRFS 파일 시스템이 있는 경우에만 적용됩니다.
```
sudo systemctl stop mariadb
sudo chattr -R +C /var/lib/mysql/
sudo systemctl start mariadb
```

### 4. PHP 스크립팅 언어 설치

LAMP 스택에 설치될 마지막 구성 요소는 PHP입니다. PHP는 특히 웹 개발에 적합한 널리 사용되는 범용 스크립팅 언어입니다.
워드프레스는 PHP 7.4 이상을 권장합니다. 작성 당시 PHP 버전 8.0은 Fedora 리포지토리에서 사용할 수 있습니다.
몇 가지 권장 확장 기능을 사용하여 PHP 8.0을 설치해 보겠습니다. 이러한 확장에 대한 자세한 내용은 PHP 확장 페이지 (https://www.php.net/manual/en/extensions.alphabetical.php) 를 참조하십시오.

```
sudo dnf install php php-fpm php-mysqlnd php-opcache php-gd \
  php-xml php-mbstring php-curl php-pecl-imagick php-pecl-zip libzip
php -v
```
확인:
```
PHP 8.0.17 (cli) (built: Mar 15 2022 08:24:20) ( NTS gcc x86_64 )
Copyright (c) The PHP Group
Zend Engine v4.0.17, Copyright (c) Zend Technologies
    with Zend OPcache v8.0.17, Copyright (c), by Zend Technologies
```

기본적으로 게시/업로드 크기, 실행/입력 시간 및 RAM 제한은 모두 매우 작게 설정됩니다.
/etc/php.ini 파일을 열고 다음 줄을 수정합니다. 설정된 새 크기가 적절하지만 필요한 경우 필요에 맞게 조정할 수 있습니다.
```
sudo vi /etc/php.ini
```
내용:
```
max_execution_time = 300 
max_input_time = 300 
memory_limit = 512M 
post_max_size = 256M 
upload_max_filesize = 256M
```
php-fpm 서비스를 활성화하고 시작합니다.
```
sudo systemctl enable --now php-fpm
```
httpd service 다시 시작.
```
sudo systemctl restart httpd
```
PHP 및 해당 확장의 구성을 테스트하는 작은 PHP 스크립트를 만듭니다.
```
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
```
root 권한이 아닌 경우에는, 다음과 같이 한다.
```
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php
```
이제 웹 브라우저를 열고 주소 표시줄에 (https://wpress.vbox.jj/phpinfo.php) 를 입력하여 PHP 및 해당 확장에 대한 모든 정보를 확인합니다.

### 5. WordPress 콘텐츠 관리 시스템 설치

이제 LAMP 스택에 모든 구성 요소를 설치했으므로 WordPress CMS를 설치하고 구성할 차례입니다.

/var/www/html/ 디렉토리로 이동하여 최신 WordPress 버전을 다운로드합니다.
```
cd /var/www/html/
sudo wget https://www.wordpress.org/latest.tar.gz
```
latest.tar.gz 파일을 추출합니다.
```
sudo tar -xvf latest.tar.gz --strip-components=1
sudo ls -lh
```
결과:
```
-rw-r--r--. 1 nobody nobody  405 Feb  6  2020 index.php
-rw-r--r--. 1 root   root    18M Mar 11 06:10 latest.tar.gz
-rw-r--r--. 1 nobody nobody  20K Jan  1 05:45 license.txt
-rw-r--r--. 1 root   root     20 Mar 21 18:38 phpinfo.php
-rw-r--r--. 1 nobody nobody 7.3K Dec 28 23:08 readme.html
-rw-r--r--. 1 nobody nobody 7.0K Jan 21  2021 wp-activate.php
drwxr-xr-x. 1 nobody nobody 2.8K Mar 11 06:09 wp-admin
-rw-r--r--. 1 nobody nobody  351 Feb  6  2020 wp-blog-header.php
-rw-r--r--. 1 nobody nobody 2.3K Nov 10 04:37 wp-comments-post.php
-rw-r--r--. 1 nobody nobody 3.0K Dec 14 14:14 wp-config-sample.php
drwxr-xr-x. 1 nobody nobody   44 Mar 11 06:09 wp-content
-rw-r--r--. 1 nobody nobody 3.9K Aug  3  2021 wp-cron.php
drwxr-xr-x. 1 nobody nobody 8.9K Mar 11 06:09 wp-includes
-rw-r--r--. 1 nobody nobody 2.5K Feb  6  2020 wp-links-opml.php
-rw-r--r--. 1 nobody nobody 3.9K May 15  2021 wp-load.php
-rw-r--r--. 1 nobody nobody  47K Jan  4 14:00 wp-login.php
-rw-r--r--. 1 nobody nobody 8.4K Sep 23 02:31 wp-mail.php
-rw-r--r--. 1 nobody nobody  23K Nov 30 23:02 wp-settings.php
-rw-r--r--. 1 nobody nobody  32K Oct 25 05:53 wp-signup.php
-rw-r--r--. 1 nobody nobody 4.7K Oct  9  2020 wp-trackback.php
-rw-r--r--. 1 nobody nobody 3.2K Jun  9  2020 xmlrpc.php```
```

이제 latest.tar.gz 파일을 삭제할 수 있습니다. 더 이상 필요하지 않습니다.
```
sudo rm latest.tar.gz
```

어떤 이유로 업로드 디렉토리가 wp-content 디렉토리 내에 없습니다. 그래서 그것을 만드십시오.
```
sudo mkdir wp-content/upload
```

WordPress 구성을 시작하려면 먼저 WordPress에서 사용할 데이터베이스를 만들어야 합니다. 따라서 MariaDB 명령줄 셸을 시작합니다.
```
sudo mariadb
```
시작:
```
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 3
Server version: 10.7.1-MariaDB MariaDB Server
Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
MariaDB [(none)]> 
```
데이터베이스를 생성합니다. 이름을 wpressdb로 지정하겠습니다. 그러나 원하는 대로 이름을 지정할 수 있습니다.
```
MariaDB [(none)]> CREATE DATABASE wpressdb;
                  #########################
```
```
Query OK, 1 row affected (0.002 sec)
```

wpressdb 데이터베이스에 액세스할 수 있는 사용자를 만듭니다. 간단하게 하기 위해 비밀번호로 'bimilnumber'를 사용하겠습니다. 그러나 강력한 암호를 사용해야 합니다.
```
MariaDB [(none)]> CREATE USER 'santa'@'wpress.vbox.jj'
                  ####################################
    -> IDENTIFIED BY 'bimilnumber';
       ############################
Query OK, 0 rows affected (0.268 sec)
```

사용자 santa 에게 wpressdb 데이터베이스에 대한 전체 액세스 권한을 부여하십시오.
```
MariaDB [(none)]> GRANT ALL PRIVILEGES ON wpressdb.*
                  ##################################
    -> TO 'santa'@'wpress.vbox.jj'
       ###########################
    -> IDENTIFIED BY 'bimilnumber';
       ############################
Query OK, 0 rows affected (0.092 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
                  #################
Query OK, 0 rows affected (0.002 sec)
```

사용자 santa 가 wpressdb 데이터베이스에 액세스할 수 있는지 확인하십시오.
```
MariaDB [(none)]> SELECT Host,Db,User FROM mysql.db WHERE Db='wpressdb';
                  ######################################################
+----------------+----------+-------+
| Host           | Db       | User  |
+----------------+----------+-------+
| wpress.vbox.jj | wpressdb | santa |
+----------------+----------+-------+
1 row in set (0.001 sec)
```

MariaDB 셸을 종료합니다.
```
MariaDB [(none)]> EXIT
                  ####
Bye
```

WordPress 구성을 계속합니다. wp-config-sample.php의 사본을 wp-config.php로 만듭니다.
```
sudo cp wp-config-sample.php wp-config.php
```

WordPress salt들을 생성하십시오. WordPress salt들은 8개의 변수로 구성된 임의의 코드 문자열이며 로그인 정보를 암호화하는 데 사용됩니다. WordPress 로그인 자격 증명을 더욱 안전하게 보호하기 위해 암호에 추가됩니다. 이렇게 하면 무차별 공격 및 기타 해킹 전술로부터 자격 증명을 보호할 수 있습니다.
```
sudo curl -S https://api.wordpress.org/secret-key/1.1/salt/
```
결과:
```
define('AUTH_KEY',         'Sbnq;5sI|,5^bP}s-I^-SiIE!Chxvvr%fx*)>5PB6_%0E:FtqJSZ*#GCMLF5t3r?');
define('SECURE_AUTH_KEY',  'Ex-OIFpY.N~U0d(w?z-tT;Ramd]wNU/>m#X@Z!-eaIFH[@`sRGbfL[Y)V[FE[*J+');
define('LOGGED_IN_KEY',    '-kpGsx#jjgY5f<mV-c|HXgE}nG&)XG`;m<5.4m[~Q+*/oImiX9s*-HdS> RW&M+s');
define('NONCE_KEY',        '6:}@+8+p|>BPv.{Ckwva4mAK]vMDi5Kn$PV+)frMY=RP/s[,(+-}^NfVs(7ngV|w');
define('AUTH_SALT',        '>u*`Xf{Y_7w#ML?3~3-6LIg<TZ%p=E#?nl$x}dG0^U3Xc3~L-:,87kt^|^ZytfEH');
define('SECURE_AUTH_SALT', 'G]wR(0<{:U|]n8|DYrJBn1B[fv6j5L*F]vK.aBYIPy%m=_+`+pf)#z,j(nsSr1@,');
define('LOGGED_IN_SALT',   '2w,&/E[qUIZmp-A6v`rfVl:B^BJ9K_L:aIyPY+v(4T~1M5[!U<L~IRsR~h}(}6pJ');
define('NONCE_SALT',       ',X*GpyfGV|i4_%|w_r+uzhEW_oruK-|CvV=QM6+UBGopXh*@e>Nn:48o;yXVS7;G');
Copy all the generated salts, open the wp-config.php file and replace this,
```

생성된 salt들을 모두 복사하고 wp-config.php 파일을 열고, 다음처럼 되어있는 것을,
```
define( 'AUTH_KEY',         'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
define( 'NONCE_KEY',        'put your unique phrase here' );
define( 'AUTH_SALT',        'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
define( 'NONCE_SALT',       'put your unique phrase here' );
```
위 내용을 다음처럼 붙여넣기 합니다.
```
define('AUTH_KEY',         'Sbnq;5sI|,5^bP}s-I^-SiIE!Chxvvr%fx*)>5PB6_%0E:FtqJSZ*#GCMLF5t3r?');
define('SECURE_AUTH_KEY',  'Ex-OIFpY.N~U0d(w?z-tT;Ramd]wNU/>m#X@Z!-eaIFH[@`sRGbfL[Y)V[FE[*J+');
define('LOGGED_IN_KEY',    '-kpGsx#jjgY5f<mV-c|HXgE}nG&)XG`;m<5.4m[~Q+*/oImiX9s*-HdS> RW&M+s');
define('NONCE_KEY',        '6:}@+8+p|>BPv.{Ckwva4mAK]vMDi5Kn$PV+)frMY=RP/s[,(+-}^NfVs(7ngV|w');
define('AUTH_SALT',        '>u*`Xf{Y_7w#ML?3~3-6LIg<TZ%p=E#?nl$x}dG0^U3Xc3~L-:,87kt^|^ZytfEH');
define('SECURE_AUTH_SALT', 'G]wR(0<{:U|]n8|DYrJBn1B[fv6j5L*F]vK.aBYIPy%m=_+`+pf)#z,j(nsSr1@,');
define('LOGGED_IN_SALT',   '2w,&/E[qUIZmp-A6v`rfVl:B^BJ9K_L:aIyPY+v(4T~1M5[!U<L~IRsR~h}(}6pJ');
define('NONCE_SALT',       ',X*GpyfGV|i4_%|w_r+uzhEW_oruK-|CvV=QM6+UBGopXh*@e>Nn:48o;yXVS7;G');
```

이제 동일한 wp-config.php 파일의 맨 위로 스크롤하고 아래 나열된 수정을 수행하십시오. 설정과 관련된 정보를 바꾸십시오.
```
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpressdb' );

/** Database username */
define ('DB_USER', 'santa');

/** Database password */
define( 'DB_PASSWORD', 'bimilnumber' );

/** Database hostname */
define( 'DB_HOST', 'wpress.vbox.jj' );
```

재귀적으로 /var/www/html 디렉토리의 소유권을 apache로 변경합니다.
```
sudo chown -R apache:apache *
```

.htaccess 파일에 대한 SELinux 쓰기 권한을 별도로 제공해야 합니다. .htaccess 파일은 Apache 웹 서버 소프트웨어를 실행하는 웹 서버용 구성 파일입니다.
```
sudo semanage fcontext -a -t httpd_sys_rw_content_t /var/www/html/.htaccess
```

/var/www/html 디렉토리의 기본 SELinux 보안 컨텍스트를 재귀적으로 복원합니다.
```
sudo restorecon -RFv *
```

httpd_can_network_connect SELinux 부울 값을 활성화합니다. 활성화되면 이 부울은 HTTP 스크립트 및 모듈이 네트워크 또는 원격 포트에 대한 연결을 시작할 수 있도록 허용합니다.
```
sudo setsebool -P httpd_can_network_connect on
```

이제 웹 브라우저를 열고 주소 표시줄에 https://wpress.vbox.jj 로 입력합니다. WordPress가 설치 프로세스를 시작합니다. 언어를 선택한 다음 계속하려면 계속을 누르십시오.

몇 가지 정보를 제공해야 합니다. 웹사이트에 적절한 제목과 사용자 이름/암호 및 이메일 주소를 지정하십시오. 그런 다음 계속 진행하려면 'WordPress 설치' 버튼을 클릭합니다.

모든 것이 순조롭게 진행되면 성공 메시지를 받게 됩니다. '로그인' 버튼을 누르세요.

로그인하려면 사용자 이름과 암호를 입력하십시오.

WordPress 대시보드 화면으로 이동합니다.

이제 WordPress CMS가 성공적으로 설치되었습니다. 이제 꿈에 그리던 웹사이트 구축을 시작할 수 있습니다.

