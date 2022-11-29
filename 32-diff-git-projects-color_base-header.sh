#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi

diff_file () {
	echo "----> diff ${HOME}/lib/color_base ${HOME}/git-projects/${1}/for-HOME-lib/color_base"
	diff ${HOME}/lib/color_base ${HOME}/git-projects/${1}/for-HOME-lib/color_base
	echo "----> diff ${HOME}/lib/header ${HOME}/git-projects/${1}/for-HOME-lib/header"
	diff ${HOME}/lib/header ${HOME}/git-projects/${1}/for-HOME-lib/header
}

diff_file fedora-sh
diff_file gate242/run_sh
diff_file kaosorder/run_scripts_dir
diff_file ubuntu-sh
