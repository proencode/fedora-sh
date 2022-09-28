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
# ..... user 3x:글자색 4x:바탕색 0회 1빨 2초 3노 4청 5보 6파 7흰
# 00 01 02 흐림 03 이탤릭 04 밑줄 05 깜빡거림 06 07 반전 08 09 글자에 줄긋기 10
# PS1='\e[0;32m\t\e[0m \e[0;33m\D{%a}\e[0;36m \D{%Y-%m-%d} \e[0;45;30m\u\e[0;33m@\e[0;42;30m\h\e[0m \e[0;33m\w\e[0m\n\W $ '
PS1='\e[0;36m\t\e[0m\e[0;33m\D{%a}\e[0;35m\D{%y}\e[0;36m\D{%m}\e[0;31m\D{%d} \e[0;32m\u\e[0;33m@\e[0;32m\h\e[0m \e[0;36m\w\e[0m\n\W $ '
# ------------------------------------------------------------------------------- ^^ !! --- ^^ ! --- ^^ !! --------- ^^ !!
# ------------------------------------------------------------------------------- user ---- @ ------ host_name ----- dir

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)
export EDITOR=vi

# ----------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
