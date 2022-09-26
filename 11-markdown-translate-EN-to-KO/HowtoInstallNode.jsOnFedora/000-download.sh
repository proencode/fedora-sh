#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {

cat_and_run "curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash" "(1) nvm 설치"
cat_and_run "source ~/.bashrc" "(2) 환경변수 설정"
cat_and_run "source ~/.bashrc ; nvm install v16.17" "(3) node.js 설치"
cat <<__EOF__

${cCyan}----> (4) '${cYellow}y${cCyan}' 를 누르면, 데모 http 서버를 실행힙니다.
----> press Enter:${cReset}
__EOF__
#|  read a
#|  if [ "x$a" != "xy" ]; then
#|  	exit 1
#|  fi
#|  cat <<__EOF__
#|  ${cUp}${cRed}[ ${cYellow}y ${cRed}]${cReset}
#|  
#|  __EOF__

cat > http_demo_server.js <<__EOF__
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('안녕하세요! Welcome to Node.js ! Korean characters are broken. ~ 에 오신것을 환영합니다~');
}).listen(3001, "127.0.0.1");
console.log('Server running at http://127.0.0.1:3001/');
__EOF__

cat <<__EOF__

${cGreen}웹 서버는 포트 3001 에서 시작되었습니다. 이제 브라우저에서 ${cYellow}http://127.0.0.1:3001/${cGreen} URL에 액세스합니다.
중단하려면, Ctrl + C 를 누르세요.${cReset}

__EOF__
cat_and_run "source ~/.bashrc ; node --inspect http_demo_server.js" "(5) 데모 http 서버 실행"
