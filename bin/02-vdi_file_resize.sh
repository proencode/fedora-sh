lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdend () {
        echo "${bbb}#--///-- ${mmm}$1${xxx}"
}

cmdrun "df -h / ; df /" "(1) 현재 용량"
cmdrun "sudo dd if=/dev/zero of=/bigemptyfile bs=4096k" "(2) Ubuntu 터미널에서 실행할것 : 시간이 좀 걸립니다.(5분 정도)"
cmdrun "sudo ls -l /bigemptyfile; sudo ls -lh /bigemptyfile; sudo rm -fr /bigemptyfile; df -h / ; df /" "(3) 정리끝난 용량"

cmdend "11-1. Ubuntu terminal 에서 vbox 파일축소 실행"

cat <<__EOF__
${bbb}
lll=\$(tput bold)\$(tput setaf 0); rrr=\$(tput bold)\$(tput setaf 1); ggg=\$(tput bold)\$(tput setaf 2); yyy=\$(tput bold)\$(tput setaf 3); bbb=\$(tput bold)\$(tput setaf 4); mmm=\$(tput bold)\$(tput setaf 5); ccc=\$(tput bold)\$(tput setaf 6); www=\$(tput bold)\$(tput setaf 7); xxx=\$(tput bold)\$(tput sgr0); uuu=\$(tput cuu 2)

cmdrun () {
        echo "\${yyy}#-- \${ccc}\$1 \${mmm}#-- \${bbb}\$2\${xxx}"; echo "\$1" | bash
        echo "\${bbb}#// \$1 #-- \$2\${xxx}"
}
cmdend () {
        echo "\${bbb}#--///-- \${mmm}\$1\${xxx}"
}

cmdrun "ls -lh /c/Users/user/VirtualBox\ VMs/; ls -l /c/Users/user/VirtualBox\ VMs/" "(4-1) 저장소 확인"
# ff="u24041desk"
if [ "x\$ff" != "xu24041desk" ]; then
  ff="u24041svr"
fi
echo "#-- (4-2) ff=''\$ff'' VMs NAME, OR just Enter to [ \$ff ]:"
read a
if [ "x\$a" != "x" ]; then
  ff=\$a
fi
echo "#-- [ \$ff ], press Enter:"
read a
#--
cmdrun "ls -lh /c/Users/user/VirtualBox\ VMs/\${ff}/; ls -l /c/Users/user/VirtualBox\ VMs/\${ff}/" "(4-3) 처음 파일크기"
cmdrun "cd /c/Program\ Files/Oracle/VirtualBox; ./vboxmanage.exe modifyhd /c/Users/user/VirtualBox\ VMs/\${ff}/\${ff}.vdi --compact" "(4-4) 파일 압축작업"
cmdrun "ls -lh /c/Users/user/VirtualBox\ VMs/\${ff}/; ls -l /c/Users/user/VirtualBox\ VMs/\${ff}/" "(4-5) 압축한 파일크기"

cmdend "11-4. 또는, 윈도우의 Git Bash 프로그램으로 실행하는 경우."${xxx}
#--
#--
#--
__EOF__
#--
#--
#--
