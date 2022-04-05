#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

MEMO="VirtualBox 설치"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"


cat_and_run "sudo dnf -y install fedora-workstation-repositories" "3rd Party 저장소 설치"

cat_and_run "sudo dnf -y install @development-tools" "1: Install Dependencies"
cat_and_run "sudo dnf -y install kernel-headers kernel-devel elfutils-libelf-devel qt5-qtx11extras" "1:"

cat <<__EOF__ | sudo tee /etc/yum.repos.d/virtualbox.repo
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/35/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
__EOF__

cat_and_run "ls -l /etc/yum.repos.d/virtualbox.repo" "2: Add VirtualBox RPM repository"
cat_and_run "sudo dnf -y install virtualbox" "3: Import VirtualBox GPG Key ----> Press “y” when prompted."
cat_and_run "sudo dnf -y install VirtualBox-6.1" "4: Install VirtualBox 6 on Fedora 35"
cat_and_run "sudo usermod -a -G vboxusers $USER ; newgrp vboxusers ; id $USER" "5: Add your user to the vboxusers group"

echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
