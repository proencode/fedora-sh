
Ubuntu 20.04에 Docker Compose를 설치하는 방법 | 단계별 만타 스 레비나스 2022년 11월 15일 https://www.cherryservers.com/blog/how-to-install-and-use-docker-compose-on-ubuntu-20-04

## Docker Compose 란

Docker Compose는 다중 컨테이너 앱을 정의하기 위한 Docker의 공식 도구입니다. Compose는 YAML 구성 파일을 사용하여 앱 서비스와 docker compose서비스를 시작하고 중지하는 명령을 정의합니다.

Docker Compose는 단일 호스트에서 여러 컨테이너를 실행해야 하는 애플리케이션에 유용합니다. 예를 들어 compose를 사용하여 호스트에 있는 LAMP 스택 의 모든 구성 요소를 그룹화할 수 있습니다 . Compose는 최소한의 오버헤드로 개발 및 테스트 환경을 신속하게 확장 및 축소하는 데에도 유용합니다.

#Docker Compose를 사용하는 방법은 무엇입니까?
일반적으로 컨테이너, 특히 Docker는 최신 Linux 시스템 관리 및 DevOps 워크플로 의 핵심 측면입니다 . 많은 경우 팀은 컨테이너화된 여러 앱을 함께 실행해야 합니다. Docker Compose는 이 사용 사례를 해결하는 데 도움이 됩니다.

특히 Docker Compose는 Linux 관리자가 일반 텍스트 YAML 구성 파일과 Docker CLI를 사용하여 다중 컨테이너 애플리케이션을 만들고 실행하는 프로세스를 단순화하는 데 도움이 됩니다.

# Docker Compose 설치

이제 Docker Compose가 무엇인지 알았으니 Ubuntu에 최신 Docker Compose를 설치하는 방법을 살펴보겠습니다. 공식 Docker Compose Linux 설치 문서 에서 차용할 예정 이지만 여기에서는 이 데모 프로젝트를 성공적으로 실행할 수 있도록 프로세스를 간소화하겠습니다. Docker Compose가 Ubuntu 20.04 시스템에 설치되면 이를 사용하여 간단한 다중 서비스 데모 앱을 실행합니다.

## 1. Docker 저장소 추가

Docker에서 Docker Compose 및 관련 패키지를 설치하는 데 권장되는 방법은 Docker의 저장소를 시스템의 저장소 목록에 추가하는 것입니다. Docker의 저장소를 추가하면 패키지 관리자를 사용하여 최신 패키지를 다운로드하고 업데이트할 수 있습니다 apt.

시작하려면 패키지 목록을 업데이트하세요.
```
sudo apt update -y
```
apt다음으로 HTTPS 기반 리포지토리를 사용 하려면 다음 네 가지 패키지가 필요합니다.

- ca-certificates- SSL/TLS 인증서를 확인하는 패키지입니다.
- curl- HTTPS를 포함한 여러 프로토콜을 지원하는 널리 사용되는 데이터 전송 도구입니다.
- gnupg- PGP(Pretty Good Privacy) 암호화 도구 제품군의 오픈 소스 구현입니다.
- lsb-release- LSB(Linux Standard Base) 버전을 보고하기 위한 유틸리티입니다.

해당 패키지를 설치하려면 다음 명령을 사용하십시오.
```
sudo apt install ca-certificates curl gnupg lsb-release
```

Docker의 GPG 키용 디렉터리를 만듭니다.
```
sudo mkdir /etc/apt/demokeyrings
```

curlDocker의 키링을 다운로드하고 이를 파이프하여 gpgGPG 파일을 생성하여 aptDocker의 저장소를 신뢰하는 데 사용합니다 .
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/demokeyrings/demodocker.gpg
```

다음 명령을 사용하여 시스템에 Docker 저장소를 추가합니다.
```
 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/demokeyrings/demodocker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
```

## 2. Docker Compose 설치

이제 Docker의 저장소를 추가했으므로 패키지 목록을 다시 업데이트하십시오.
```
sudo apt update -y
```

그런 다음 다음 명령을 사용하여 Docker-CE(Community Edition), Docker-CE CLI, Containerd 런타임 및 Docker Compose를 설치합니다.
```
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

다음 명령을 사용하여 해당 버전을 확인하여 Docker-CE, Docker-CE CLI, Containerd 및 Docker Compose가 설치되어 있는지 확인할 수 있습니다.
```
sudo docker --version
sudo docker compose version
sudo ctr version
```

## 3. YAML 파일 생성

Docker Compose가 시스템에 설치되어 있으면 docker-compose.yml다중 서비스 앱을 정의하는 파일을 만들 수 있습니다. 이 예에서는 Docker의 Compose 및 WordPress 빠른 시작을 기반으로 WordPress 설치를 생성합니다 . 필요에 따라 다른 이미지로 대체할 수 있습니다.

먼저 데모 앱용 디렉터리를 만듭니다.
```
mkdir ~/composedemo
```

cd새 디렉터리로 이동합니다.
```
cd ~/composedemo
```

nano 또는 vim 같은 텍스트 편집기를 사용하여 이 콘텐츠가 포함된 docker-compose.yml 파일을 만듭니다. (구성의 기능을 설명하는 인라인 주석 참고).
```
cat <<__EOF__ | tee docker-compose.yml
# Define services for our configuration. Parameters are similar to those defined by Docker at https://docs.docker.com/samples/wordpress/
# 구성에 대한 서비스를 정의합니다. 매개변수는 https://docs.docker.com/samples/wordpress/ 에서 Docker가 정의한 매개변수와 유사합니다.

services:
  # Create the MariaDB service
  db:
    # Specify the image version to pull from Docker Hub
    image: mariadb:10.6.4-focal
    # Run the command below to configure MariaDB to use the mysql_native_password authentication method
    command: '--default-authentication-plugin=mysql_native_password'
    # Define a storage volume for the database
    volumes:
      - database_data:/var/lib/mysql
    # Always restart the container 
    restart: always
    # Define environment variables for the MariaDB root password, database name, user, and user password
    environment:
      - MYSQL_ROOT_PASSWORD=yourstrongrootpassword
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=cherry
      - MYSQL_PASSWORD=pepperandegg
    # Define the ports to expose to other containers on the same Docker network
    # These ports are NOT exposed externally to the host
    expose:
      - 3306
      - 33060
  # Create the MariaDB service
  wordpress:
    # Use the latest WordPress image from Docker Hub
    image: wordpress:latest
    # Create a storage volume for the WordPress site
    volumes:
      - wordpress_data:/var/www/html
    # Map port 8081 on the host to port 80 on the container
    ports:
      - 8081:80
    # Always restart the container
    restart: always
    # Use environment variables to allow WordPress to communicate with the database service
    environment:
      - WORDPRESS_DB_HOST=db
      - WORDPRESS_DB_USER=cherry
      - WORDPRESS_DB_PASSWORD=pepperandegg
      - WORDPRESS_DB_NAME=wordpress
# Define the top level volumes
volumes:
    database_data:
    wordpress_data:
__EOF__
```
## 4. Docker Compose 실행

이제 다음 명령을 사용하여 다중 서비스 앱을 실행할 수 있습니다.
```
sudo docker compose up -d
```

## 5. 앱 테스트

이제 다음 명령을 사용하여 WordPress 및 MySQL 컨테이너가 실행되고 있는지 확인할 수 있습니다.
```
sudo docker compose ps
```

호스트의 IP 주소로 이동하여 데모 WordPress 인스턴스를 볼 수도 있습니다.

## 6. Docker Compose 중지

데모 Docker Compose 앱에서 실행 중인 컨테이너를 일시 중지하면 실행 중인 프로세스가 일시 중지됩니다. 컨테이너를 일시 중지하려면 다음 명령을 사용하십시오.
```
sudo docker compose pause
```

컨테이너 일시중지를 해제하려면 다음 명령어를 실행하세요.
```
sudo docker compose unpause
```

컨테이너를 일시 중지하는 대신 중지하려면(예: SIGTERM 전송) 다음 명령을 실행하세요.
```
docker compose stop
```

컨테이너를 중지해도 연결된 Docker 네트워크는 제거되지 않습니다. 컨테이너를 중지하고 연결된 네트워크를 제거하려면 다음 명령을 사용합니다.
```
sudo docker compose down
```

## 7. 데모 구성 삭제

데모 앱으로 테스트를 마친 후에는 구성 파일을 삭제할 수 있습니다.
```
rm docker-compose.yml
```

## 8. 결론

그게 다야! 이제 Docker Compose의 기본 사항을 알았으므로 QA 환경에서 자동화된 테스트 생성과 같은 보다 복잡한 워크플로로 넘어갈 수 있습니다. Docker Compose로 가능한 작업에 대해 더 자세히 알아보려면 공식 문서를 확인하세요 .

