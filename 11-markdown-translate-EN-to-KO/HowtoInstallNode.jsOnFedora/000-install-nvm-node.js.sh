#!/bin/sh

source ${HOME}/lib/color_base #-- (0) 화면에 색상표시
MEMO="nvm node.js 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"

cat_and_run "curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash" "(1) nvm 설치"
cat_and_run "source ~/.bashrc ; nvm install v16.17" "(1) node.js 설치"

echo "${cGreen}----> ${cYellow}cat > http_demo_server.js <<__EOF__ ${cCyan}#-- (2) 데모 http 서버를 위한 파일을 만듭니다.${cReset}"
cat > http_demo_server.js <<__EOF__
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('안녕하세요! Welcome to Node.js ! Korean characters are broken. ~ 에 오신것을 환영합니다~');
}).listen(3001, "127.0.0.1");
console.log('Server running at http://127.0.0.1:3001/');
__EOF__
cat <<__EOF__
${cYellow}__EOF__${cGreen}

웹 서버는 포트 3001 에서 시작되었습니다. 이제 브라우저에서 ${cYellow}http://127.0.0.1:3001/${cGreen} URL에 액세스합니다.
중단하려면, Ctrl + C 를 누르세요.${cReset}

__EOF__
cat_and_run "node --inspect http_demo_server.js" "(3) 데모 http 서버 실행"

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
