
17:39:39월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $ sudo docker ps -a
[sudo] yosj 암호:
CONTAINER ID   IMAGE       COMMAND                   CREATED         STATUS         PORTS                                                    NAMES
f09a9c766af5   mysql:5.7   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp, 33060/tcp   kaosdb
17:39:47월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $ sudo docker stop kaosdb; sudo docker rm kaosdb; sudo rm -rf /home/docker-data/
kaosdb
kaosdb
17:40:35월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $ sh 14-mysql-kaosdb-kaosorder2-docker-run.sh
>>>>>>>>>> 14-mysql-kaosdb-kaosorder2-docker-run.sh ||| ---MySQL--- DB 서버를 도커에 설치하기 >>>>>>>>>>
----> sudo docker ps -a 운영중인 MySQL DB 도커들
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
<---- sudo docker ps -a 운영중인 MySQL DB 도커들

[ 1 ]....  kaosdb (kaosorder2)
  2  .... gatedb (gate242)
  3  .... ksammydb (ksam21)

----> /etc/host 에 지정하려는 도커이름: (1...3)  [ 1 ]
[ kaosdb ] -OK-
----> sudo mkdir -p /home/docker-data/database/kaosdb
<---- sudo mkdir -p /home/docker-data/database/kaosdb
----> ls -lZ /home/docker-data/database/kaosdb #-- (1) 디렉토리를 만들었습니다.
합계 0
<---- ls -lZ /home/docker-data/database/kaosdb #-- (1) 디렉토리를 만들었습니다.
sudo docker run --detach \
	--restart=always \
	# -it \
	--volume /home/docker-data/database/kaosdb:/var/lib/mysql \
	--env LANG=C.UTF-8 \
	--env LC_ALL=C.UTF-8 \
	--env MYSQL_RANDOM_ROOT_PASSWORD="true yes" \
	--character-set-server=utf8 \
	--collation-server=utf8_unicode_ci \
	--name kaosdb \
	--publish 3306:3306 \
	--network goodworld \
	mysql:5.7

c499e79f6517ea6cca72015a71c5a7aa722c28bc6ba0cbd629879c8ec4490a2a
#----> db 초기화 작업이 끝날때까지 최대 2 분간 기다립니다.
----> sudo docker logs kaosdb 2>&1 | grep --color PASSWORD # <---- (0) 위에 표시된 비밀번호를 복사합니다.
2025-03-31 08:40:52+00:00 [Note] [Entrypoint]: GENERATED ROOT PASSWORD: kukWM3KW2mQdafFMrS54nyygTWWMJSTS
<---- sudo docker logs kaosdb 2>&1 | grep --color PASSWORD # <---- (0) 위에 표시된 비밀번호를 복사합니다.
sudo docker exec -it kaosdb mysql -u root -p # <---- (1) Enter password: 가 나오면, GENERATED ROOT PASSWORD 를 여기에 붙여넣기 합니다.

alter user 'root'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'root'@'%' with grant option ; create database if not exists kaosorder2 character set utf8 ; create user 'kaosorder2'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'kaosorder2'@'%' with grant option ; exit ; # <>-<>-<> 자리에 비번을 넣습니다.

sudo docker exec -it kaosdb /bin/bash ; sudo docker restart kaosdb ; sudo docker ps -a ; ls --color . ; ls --color /home/yosj/zz00logs

echo "character-set-server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf ; tail -3 /etc/mysql/mysql.conf.d/mysqld.cnf ; exit
             |
             | 위와 같이 진행해야 설치가 끝납니다.
<<<<<<<<<< 14-mysql-kaosdb-kaosorder2-docker-run.sh ||| ---MySQL--- DB 서버를 도커에 설치하기 <<<<<<<<<<
17:40:59월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $ kukWM3KW2mQdafFMrS54nyygTWWMJSTS^C
17:43:16월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $ sudo docker stop kaosdb; sudo docker rm kaosdb; sudo rm -rf /home/docker-data/
kaosdb
kaosdb
17:43:29월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $ sh 14-mysql-kaosdb-kaosorder2-docker-run.sh
>>>>>>>>>> 14-mysql-kaosdb-kaosorder2-docker-run.sh ||| ---MySQL--- DB 서버를 도커에 설치하기 >>>>>>>>>>
----> sudo docker ps -a 운영중인 MySQL DB 도커들
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
<---- sudo docker ps -a 운영중인 MySQL DB 도커들

[ 1 ]....  kaosdb (kaosorder2)
  2  .... gatedb (gate242)
  3  .... ksammydb (ksam21)

----> /etc/host 에 지정하려는 도커이름: (1...3)  [ 1 ]
[ kaosdb ] -OK-
----> sudo mkdir -p /home/docker-data/database/kaosdb
<---- sudo mkdir -p /home/docker-data/database/kaosdb
----> ls -lZ /home/docker-data/database/kaosdb #-- (1) 디렉토리를 만들었습니다.
합계 0
<---- ls -lZ /home/docker-data/database/kaosdb #-- (1) 디렉토리를 만들었습니다.
sudo docker run --detach \
	--restart=always \
	# -it \
	--volume /home/docker-data/database/kaosdb:/var/lib/mysql \
	--env LANG=C.UTF-8 \
	--env LC_ALL=C.UTF-8 \
	--env MYSQL_RANDOM_ROOT_PASSWORD="true yes" \
	--character-set-server=utf8 \
	--collation-server=utf8_unicode_ci \
	--name kaosdb \
	--publish 3306:3306 \
	--network goodworld \
	mysql:5.7

779513648ff6635132c431caa0e19b0f060169dabe36124313cca70978f4ba38
#----> db 초기화 작업이 끝날때까지 최대 2 분간 기다립니다.
----> sudo docker logs kaosdb 2>&1 | grep --color PASSWORD # <---- (0) 위에 표시된 비밀번호를 복사합니다.
2025-03-31 08:43:42+00:00 [Note] [Entrypoint]: GENERATED ROOT PASSWORD: LRiccFQBvK00vU3Qw3B/+RlAg6DwaWnu
<---- sudo docker logs kaosdb 2>&1 | grep --color PASSWORD # <---- (0) 위에 표시된 비밀번호를 복사합니다.
sudo docker exec -it kaosdb mysql -u root -p # <---- (1) Enter password: 가 나오면, GENERATED ROOT PASSWORD 를 여기에 붙여넣기 합니다.

alter user 'root'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'root'@'%' with grant option ; create database if not exists kaosorder2 character set utf8 ; create user 'kaosorder2'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'kaosorder2'@'%' with grant option ; exit ; # <>-<>-<> 자리에 비번을 넣습니다.

sudo docker exec -it kaosdb /bin/bash ; sudo docker restart kaosdb ; sudo docker ps -a ; ls --color . ; ls --color /home/yosj/zz00logs

echo "character-set-server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf ; tail -3 /etc/mysql/mysql.conf.d/mysqld.cnf ; exit
             |
             | 위와 같이 진행해야 설치가 끝납니다.
<<<<<<<<<< 14-mysql-kaosdb-kaosorder2-docker-run.sh ||| ---MySQL--- DB 서버를 도커에 설치하기 <<<<<<<<<<
17:43:50월250331 yosj@gigamaster ~/git-projects/kaosorder/run_scripts_dir/71-docker-mysql-kaosorder-install-and-run
71-docker-mysql-kaosorder-install-and-run $

17:44:01월250331 yosj@gigamaster ~
~ $ sudo docker exec -it kaosdb mysql -u root -p # 
[sudo] yosj 암호: 
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.44 MySQL Community Server (GPL)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
mysql> 
mysql> 
mysql> alter user 'root'@'%' identified by 'ds2axa';
Query OK, 0 rows affected (0.00 sec)

mysql> grant all privileges on *.* to 'root'@'%' with grant option ; 
Query OK, 0 rows affected (0.00 sec)

mysql> create database if not exists kaosorder2 character set utf8 ;
Query OK, 1 row affected (0.00 sec)

mysql> create user 'kaosorder2'@'%' identified by 'zkdhtm2010';
Query OK, 0 rows affected (0.00 sec)

mysql> grant all privileges on *.* to 'kaosorder2'@'%' with grant option ;
Query OK, 0 rows affected (0.00 sec)

mysql> exit;
Bye
17:46:31월250331 yosj@gigamaster ~
~ $ sudo docker exec -it kaosdb /bin/bash ; sudo docker restart kaosdb ; sudo docker ps -a ; ls --color . ; ls --color /home/yosj/zz00logs
bash-4.2# echo "character-set-server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf ; tail -3 /etc/mysql/mysql.conf.d/mysqld.cnf ; exit
character-set-server=utf8
exit
kaosdb
CONTAINER ID   IMAGE       COMMAND                   CREATED         STATUS                  PORTS                                                    NAMES
779513648ff6   mysql:5.7   "docker-entrypoint.s…"   3 minutes ago   Up Less than a second   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp, 33060/tcp   kaosdb
 10-도서관-목록                          mylogin.cnf
 4linux-u24041desk-250108-0859.7z        project-kaosco-250116-1622.7z
 HDD-232G                                qna-chrome-extension
 MEGA                                    qqq
'VirtualBox VMs'                         snap
 archive                                 sort-ls-alR-Seagate-250102-0847
 bin                                     today-backup-yosjgc
 c.sh                                    u24041svr.00HOME-init-.config_VirtualBox-250126-1244.7z.001
 docker-compose-for-kaosorder-250326수   wind_bada
 error-250326                            y5ncmi
 fdisk-l-250215-211205                   zz00-logs
 find-windows.print                      zz00logs
 from-kaos-project-kaosco                zz_ping_list_250326수-081109
 git-projects                            공개
 kaosco                                  다운로드
 kaosco.ls-R                             문서
 kaospc-home-du-dh_sort-hr               바탕화면
 last-home_kaosco.ls-R                   비디오
 last_backup-kaosco_santa-250220-1626    사진
 ls-alR-Seagate-250102-0847              서식
 ls-alR-Seagate-250102-0847.7z           음악
250203-1101-가-히.ls-alR
250220-1920-가-히.ls-alR
250328
250329
250331
zz.250328-214346..12.-.Ubuntu2204.-.docker_N_compose-mysql-client.sh
zz.250328-214641__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250328-215345__15-reset-to-etc-hosts.sh
zz.250328-220528__15-reset-to-etc-hosts.sh
zz.250328-220706__16-login-path-setting.sh
zz.250328-220931__16-login-path-setting.sh
zz.250328-221053__16-login-path-setting.sh
zz.250328-221233__16-login-path-setting.sh
zz.250328-222031__16-login-path-setting.sh
zz.250331-113553__16-login-path-setting.sh
zz.250331-122117__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-123105__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-150318__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-154646__RUNNING_15-mysql-docker-run.sh
zz.250331-155935__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-160645__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-163709__RUNNING_15-mysql-docker-run.sh
zz.250331-170533__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-172901__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-173712__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-174059__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.250331-174350__14-mysql-kaosdb-kaosorder2-docker-run.sh
zz.home_yosj-250203월-110127
zz.home_yosj-250220목-192022
17:47:31월250331 yosj@gigamaster ~
~ $ sudo docker ps -a
CONTAINER ID   IMAGE       COMMAND                   CREATED         STATUS          PORTS                                                    NAMES
779513648ff6   mysql:5.7   "docker-entrypoint.s…"   4 minutes ago   Up 13 seconds   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp, 33060/tcp   kaosdb
17:47:44월250331 yosj@gigamaster ~
~ $ 

