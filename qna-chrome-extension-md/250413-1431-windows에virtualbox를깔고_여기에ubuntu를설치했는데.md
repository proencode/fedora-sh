
windows 에 virtualbox 를 깔고 여기에 ubuntu 를 설치했는데, ubuntu 에서 windows 의 폴더를 연결하려면 어떻게 하지?



Windows의 폴더를 VirtualBox의 Ubuntu에 연결하는 방법은 크게 두 가지가 있습니다.

1. VirtualBox 공유 폴더 기능 사용
VirtualBox의 공유 폴더 기능을 사용하면 Windows의 특정 폴더를 Ubuntu에서 직접 접근할 수 있습니다.

1단계: VirtualBox 설정
VirtualBox 관리자에서 Ubuntu 가상 머신을 선택하고 '설정'을 클릭합니다.
'공유 폴더' 탭으로 이동합니다.
오른쪽 상단의 폴더 추가 아이콘을 클릭합니다.
'폴더 경로'에서 Windows에서 공유할 폴더를 선택합니다.
'폴더 이름'에 Ubuntu에서 사용할 폴더 이름을 입력합니다.
'자동 마운트' 및 '영구 설정'을 체크합니다. (선택 사항)
'확인'을 클릭합니다.
2단계: Ubuntu 설정
Ubuntu 가상 머신을 시작합니다.

터미널을 열고 다음 명령어를 입력하여 VirtualBox Guest Additions를 설치합니다.

Bash

sudo apt update
sudo apt install virtualbox-guest-utils virtualbox-guest-x11
다음 명령어를 입력하여 공유 폴더를 마운트합니다. (폴더 이름은 1단계에서 설정한 이름으로 변경)

Bash

sudo mount -t vboxsf [폴더 이름] [마운트할 경로]
예시: sudo mount -t vboxsf share /mnt/share
/etc/fstab 파일을 수정하여 부팅 시 자동으로 마운트되도록 설정할 수 있습니다.

2. Samba 서버 사용
Samba 서버를 사용하면 Windows와 Ubuntu 간에 네트워크 공유 폴더를 설정할 수 있습니다.

1단계: Windows 설정
Windows에서 공유할 폴더를 선택하고 마우스 우클릭하여 '속성'을 클릭합니다.
'공유' 탭으로 이동하고 '고급 공유'를 클릭합니다.
'선택한 폴더 공유'를 체크하고 '권한'을 클릭합니다.
Ubuntu에서 접근할 사용자를 추가하고 권한을 설정합니다.
'확인'을 클릭합니다.
2단계: Ubuntu 설정
Ubuntu 가상 머신을 시작합니다.

터미널을 열고 다음 명령어를 입력하여 Samba 서버를 설치합니다.

Bash

sudo apt update
sudo apt install samba
/etc/samba/smb.conf 파일을 수정하여 공유 설정을 추가합니다.

다음 명령어를 입력하여 Samba 서비스를 재시작합니다.

Bash

sudo systemctl restart smbd
파일 탐색기에서 smb://[Windows IP 주소]/[공유 폴더 이름]으로 접근합니다.

참고 사항
공유 폴더를 사용할 때 권한 문제로 인해 파일 접근이 제한될 수 있습니다. 필요에 따라 권한을 조정해야 합니다.
Samba 서버를 사용할 경우 네트워크 설정이 필요합니다.
VirtualBox Guest Additions를 설치하면 Ubuntu에서 마우스 커서 통합, 화면 크기 자동 조정 등 다양한 기능을 사용할 수 있습니다.

VirtualBox 공유 폴더 기능 사용 으로 하니 windows 폴더가 연결이 되네. 그런데 ubuntu 에서 ls share 를 하면, 디렉토리인 경우에는 그 디렉토리 이름이 반전이 돼서 나오네. 그래서 ls -l 로 보니 디렉토리들이 drwxr-xr-x 로 돼있어야 하는데 drwxrwxrwx 로 돼있네. 파일들은 -rw-rw-r-- 가 아니고 -rwxrwxrwx 로 돼있고 말이야. 이걸 조정할 방법은 없나?




VirtualBox 공유 폴더를 통해 Windows 폴더를 Ubuntu에 연결했을 때 파일 및 디렉토리 권한이 drwxrwxrwx 또는 -rwxrwxrwx로 설정되는 문제는 VirtualBox의 공유 폴더 구현 방식 때문에 발생하는 일반적인 현상입니다. VirtualBox 공유 폴더는 Windows 파일 시스템과 Linux 파일 시스템 간의 권한 모델 차이를 완벽하게 매핑하지 못하기 때문에 모든 파일 및 디렉토리에 최대 권한을 부여하는 방식으로 작동합니다.

이 문제를 해결하기 위한 몇 가지 방법은 다음과 같습니다.

1. 마운트 옵션 사용
mount 명령어를 사용하여 공유 폴더를 마운트할 때 권한 관련 옵션을 지정하여 문제를 해결할 수 있습니다.

Bash

sudo mount -t vboxsf -o uid=$(id -u $USER),gid=$(id -g $USER),dmode=755,fmode=644 [폴더 이름] [마운트할 경로]
uid=$(id -u $USER): 현재 사용자의 UID를 사용하여 파일 소유자를 설정합니다.
gid=$(id -g $USER): 현재 사용자의 GID를 사용하여 파일 그룹을 설정합니다.
dmode=755: 디렉토리 권한을 755로 설정합니다.
fmode=644: 파일 권한을 644로 설정합니다.
이 명령어를 사용하면 공유 폴더의 파일 및 디렉토리 권한이 원하는 대로 설정됩니다. /etc/fstab 파일에 해당 마운트 옵션을 추가하여 부팅 시 자동으로 적용되도록 설정할 수도 있습니다.

2. umask 설정
umask 명령어를 사용하여 파일 및 디렉토리 생성 시 기본 권한을 설정할 수 있습니다.

Bash

umask 022
이 명령어를 실행하면 이후 생성되는 파일은 644 권한을, 디렉토리는 755 권한을 갖게 됩니다. 이 설정을 영구적으로 적용하려면 ~/.profile 또는 ~/.bashrc 파일에 해당 명령어를 추가해야 합니다. 하지만 이 방법은 기존 파일의 권한을 변경하지는 않습니다.

3. VirtualBox Guest Additions 재설치
VirtualBox Guest Additions가 제대로 설치되지 않았거나 오래된 버전인 경우 권한 문제가 발생할 수 있습니다. VirtualBox Guest Additions를 최신 버전으로 재설치하여 문제를 해결해 보세요.

4. Samba 서버 사용
VirtualBox 공유 폴더 대신 Samba 서버를 사용하여 Windows 폴더를 공유하면 파일 및 디렉토리 권한을 보다 세밀하게 제어할 수 있습니다. Samba 서버를 사용하면 Windows와 Linux 간의 권한 매핑을 사용자 정의할 수 있습니다.

위 방법들을 통해 공유 폴더의 권한 문제를 해결하고 원하는 대로 파일 및 디렉토리를 사용할 수 있습니다.


