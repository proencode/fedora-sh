# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
# ..... user 0회 1빨 2초 3노 4청 5보 6파 7흰
# export GRAILS_HOME=/usr/local/share/grails/latest # export PATH=${GRAILS_HOME}/bin:${PATH}
# export JAVA_HOME=/usr/local/share/java/latest # export JAVA_HOME=/usr/lib/jvm/java # export PATH=${JAVA_HOME}/bin:${PATH}
# export CLASSPATH=${JAVA_HOME}/lib/tools.jar:/usr/share/java/javax.mail.jar:/usr/share/java/mysql-connector-java.jar:.
# export PATH=${PATH}:${HOME}/bin:.
# # PS1='\e[01;32m\t\e[0m (\e[01;33m\D{%a}\e[0m\D{) %Y-%m-%d} \e[01;31m\u\e[0m@\e[01;36m\h\e[0m \w\n\W \$ '
# for g1 # PS1='\e[01;36m\t\e[0m \e[01;33m(\e[0m\e[01;32m\D{%a}\e[0m\e[01;33m)\e[0m \D{%Y-%m-%d} \e[01;36m\u\e[01;37m@\e[01;42m\h\e[0m \w\n\W $ '
# for candy # PS1='\e[01;36m\t\e[0m (\e[01;33m\D{%a}\e[0m\D{) %Y-%m-%d} \e[01;33m\u\e[0m@\e[01;44m\h\e[0m \w\n\W $ '
# for root 0회 1빨 2초 3노 4청 5보 6파 7흰 # PS1='3(\e[01;30m0\e[0m\e[01;31m1\e[0m\e[01;32m2\e[0m\e[01;33m3\e[0m\e[01;34m4\e[0m\e[01;35m5\e[0m\e[01;36m6\e[0m\e[01;37m7\e[0m\e[01;38m8\e[0m) 4(\e[01;40m0\e[0m\e[02;41m1\e[0m\e[03;42m2\e[0m\e[01;43m3\e[0m\e[01;44m4\e[0m\e[01;45m5\e[0m\e[01;46m6\e[0m\e[01;47m7\e[0m\e[01;48m8\e[0m) 5(\e[01;50m0\e[0m\e[01;51m1\e[0m\e[01;52m2\e[0m\e[01;53m3\e[0m\e[01;54m4\e[0m\e[01;55m5\e[0m\e[01;56m6\e[0m\e[01;57m7\e[0m\e[01;58m8\e[0m) 0(\e[01;00m0\e[0m\e[01;01m1\e[0m\e[01;02m2\e[0m\e[01;03m3\e[0m\e[01;04m4\e[0m\e[01;05m5\e[0m\e[01;06m6\e[0m\e[01;07m7\e[0m\e[01;08m8\e[0m \w\n\W $ '
# for G32 # PS1='\e[01;36m\t\e[0m \e[01;35m(\e[0m\e[01;32m\D{%a}\e[0m\e[01;35m)\e[0m \D{%Y-%m-%d} \e[01;31m\u\e[01;33m@\e[01;32m\h\e[0m \w\n\W $ '
# ..... user 3x:글자색 4x:바탕색 0회 1빨 2초 3노 4청 5보 6파 7흰
# 00 01 02 흐림 03 이탤릭 04 밑줄 05 깜빡거림 06 07 반전 08 09 글자에 줄긋기 10
### PS1='\e[01;36m\t\e[0m \e[01;35m(\e[0m\e[01;32m\D{%a}\e[0m\e[01;35m)\e[0m \D{%Y-%m-%d} \e[01;31m\u\e[01;33m@\e[01;32m\h\e[0m \w\n\W $ '
# PS1='\e[0;32m\t\e[0m \e[0;33m\D{%a}\e[0;36m \D{%Y-%m-%d} \e[0;32m\u\e[0;33m@\e[0;32m\h\e[0m \e[0;36m\w\e[0m\n\W $ '
# PS1='\e[0;32m\t\e[0m \e[0;33m\D{%a}\e[0;36m \D{%Y-%m-%d} \e[0;45;30m\u\e[0;33m@\e[0;42;30m\h\e[0m \e[0;33m\w\e[0m\n\W $ '
# PS1='\e[0;32m\t\e[0m\e[0;33m\D{%a}\e[0;36m\D{%y%m}\e[0;34m\D{%d} \e[0;35m\u\e[0;33m@\e[0;35m\h\e[0m \e[0;36m\w\e[0m\n\W $ '
PS1='\e[0;36m\t\e[0m\e[0;33m\D{%a}\e[0;35m\D{%y%m}\e[0;31m\D{%d} \e[0;32m\u\e[0;33m@\e[0;32m\h\e[0m \e[0;36m\w\e[0m\n\W $ '
# ------------------------------------------------------------------- ^^ !! --- ^^ ! --- ^^ !! --------- ^^ !!
# ------------------------------------------------------------------- user ---- @ ------ host_name ----- dir

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)
export EDITOR=vi

# ----------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
