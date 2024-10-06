#!/bin/sh

isok () {
	ls_file=$(ls ${1} 2>&1) #-- fedora-37-iso
	if [ "x$ls_file" = "x" ]; then
		ls_file=$(ls ${2} 2>&1) #-- "*37-iso"
		if [ "x$ls_file" = "x" ]; then
			echo "...... ($2) 파일 또는 폴더가 없습니다."
		else
			echo "#..... ($2) 파일 또는 폴더와 다릅니다."
			ls $2
		fi
	# else
		# echo "찾았으면 표시할 필요가 없습니다.  echo  ${ls_file} is ok"
	fi
}


echo "#----> from $(pwd)"

isok 02.21-VBox7_TO_C-Downloads-230320-1057.bat "02.*.bat"
isok 7zr.exe 7zr.exe
isok 99.03a.VC_redist.x64_Install-230216-1059.bat "99.93a.*"

bb=backup-files
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok 37-vdi-fedora-37 "37-vdi*"
isok fedora-36-iso
isok fedora-36-vdi-etc
isok fedora-37-iso "*37-iso"
isok windows-iso
isok yosjfedora37.33-studio-idea-dnf.conf-230328-1742.7z.001

bb=37-vdi-fedora-37
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok fedora37.12-00-init-230125-1401.7z.001
isok yosjfedora37.26-01-terminal-230306-204711.7z.001
isok yosjfedora37.35-kaosorder-230331-1426.7z.001

bb=../fedora-36-iso
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok fedora.gpg
isok Fedora-Workstation-36-1.5-x86_64-CHECKSUM
isok Fedora-Workstation-Live-x86_64-36-1.5.iso
isok run.sh

bb=../fedora-36-vdi-etc
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok Oracle_VM_VirtualBox_Extension_Pack-6.1.40.vbox-extpack
isok Users-VirtualBox_6.08-FWU-221101-1145.7z.001
isok VirtualBox-6.1.40-154048-Win.exe
isok yosjfedora36.16-LAST-old-ssh-ok-221117-1626.7z.001
isok ZZ...6-VirtualBox_6_TO_C-Downloads-bada-221117-1707.bat

bb=../fedora-37-iso
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok fedora.gpg
isok Fedora-Workstation-37-1.7-x86_64-CHECKSUM
isok Fedora-Workstation-Live-x86_64-37-1.7.iso

bb=../vdi-windows
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok win10.01-cleverpdf-230316-0834.7z.001
isok win10.01-cleverpdf-230316-0834.7z.002
isok win11.00-init-230309-2317.7z.001

bb=../windows-iso
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok Win10_22H2_Korean_x64.7z.001
isok Win10_22H2_Korean_x64.7z.002
isok Win10_22H2_Korean_x64.iso

bb=../../my-programs
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok android-studio-2022.1.1.21-linux.tar.gz
isok android-studio-2022.1.1.21-windows.exe
isok BraveBrowserSetup-DWS000.exe
isok ChromeSetup.exe
isok cleverpdf-v300-201219.exe
isok gimp-2.10.34-setup.exe
isok ideaIC-2023.1.exe
isok ideaIC-2023.1.tar.gz
isok pencil-3.1.0.ga-1.x86_64.rpm
isok pycharm-community-2022.3.3.exe
isok pycharm-community-2022.3.3.tar.gz
isok sha256sum.zip
isok SlackSetup.exe
isok winrar-6.11-installer_t-sNz01.exe
isok WinSCP-5.21.7-Setup.exe

bb=../vdi-files
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok 4Git
isok 600-inux-VirtualBox-6.1-6.1.42_155177_fedora36-1.x86_64.rpm
isok 600-Oracle_VM_VirtualBox_Extension_Pack-6.1.42.vbox-extpack
isok 600-VirtualBox-6.1.42-155177-Win.exe
isok 7z2201-x64.exe
isok Git-2.39.1-64-bit.exe
isok Linux-VirtualBox-7.0-7.0.6_155176_fedora36-1.x86_64.rpm
isok Oracle_VM_VirtualBox_Extension_Pack-7.0.6a-155176.vbox-extpack
isok Users-VBox7...05-f36-f37-u2204-w10-230331-1206.7z.001
isok VC_redist.x64.exe
isok VirtualBox-7.0.6-155176-Win.exe
isok yosjfedora37.3601-rclone-keepass-sdk-snapd-kaos-230405-1314.7z.001
isok yosjfedora37.3601-rclone-keepass-sdk-snapd-kaos-230405-1314.7z.002

bb=4Git
echo "#----> cd $(pwd) to ${bb}" ; cd ${bb}

isok D2Coding.ttc
isok D2Coding.ttf
isok D2CodingBold.ttf
isok usr

cd ../..
