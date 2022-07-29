#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cCyan}$1 ${cBlue}$2${cReset}"
}

exam_dir=exam_projects
if [ ! -d ${HOME}/${exam_dir} ]; then
	cat_and_run "mkdir ${HOME}/${exam_dir}"
fi

git_host=github.com/dilipsundarraj1
git_dir=kotlin-springboot

if [ -d ${HOME}/${exam_dir}/${git_dir} ]; then
	rm -rf ${HOME}/${exam_dir}/${git_dir}
fi

cat_and_run "git clone https://${git_host}/${git_dir}.git ${HOME}/${exam_dir}/${git_dir}"

ls --color ; cat_and_run "du -sh ${HOME}/${exam_dir}/* | grep --color ${exam_dir}" "#-- ${0}"
