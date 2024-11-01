
우분투에 도커 엔진 설치 https://docs.docker.com/engine/install/ubuntu/
241024목1350

전제 조건
방화벽 제한
OS 요구 사항
우분투 노블 24.04 (LTS)
이전 버전 제거
```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

설치 방법

1.  도커 설정 apt 저장소
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Docker 패키지를 설치
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. 다음을 실행하여 hello-world 이미지 Docker Engine 설치가 성공적인지 확인
```
sudo docker run hello-world
```


```
echo "#---- 1. 충돌하는 모든 패키지 제거"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
echo "#<<<< 1. 충돌하는 모든 패키지 제거"
echo "#<<<< 우분투에 도커 엔진 설치 https://docs.docker.com/engine/install/ubuntu/"
```

```
echo "#---- 2. 도커 설정 apt 저장소"
echo "#---- (2-1) Add Docker's official GPG key:"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "#<<<< (2-1) Add Docker's official GPG key:"
echo "#<<<< 우분투에 도커 엔진 설치 https://docs.docker.com/engine/install/ubuntu/"

echo "#---- (2-2) Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
echo "#<<<< (2-2) Add the repository to Apt sources:
echo "#<<<< 2. 도커 설정 apt 저장소"
echo "#<<<< 우분투에 도커 엔진 설치 https://docs.docker.com/engine/install/ubuntu/"
```

```
echo "#---- 3. Docker 패키지를 설치"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "#<<<< 3. Docker 패키지를 설치"
echo "#<<<< 우분투에 도커 엔진 설치 https://docs.docker.com/engine/install/ubuntu/"
```

```
echo "#---- 4. 다음을 실행하여 Docker Engine 설치가 성공적인지 확인"
sudo docker run hello-world
echo "#<<<< 4. 다음을 실행하여 Docker Engine 설치가 성공적인지 확인"
echo "#<<<< 우분투에 도커 엔진 설치 https://docs.docker.com/engine/install/ubuntu/"
```

