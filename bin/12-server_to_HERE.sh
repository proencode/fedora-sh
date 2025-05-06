#/bin/sh

echo "#-- "
echo "#-- V V V V V V V ------- 이곳의 날짜가 더 오래돼야 합니다."
echo "#-- From: S E R V E R"; ssh -p 15922 orangepi@pi ls -l qna*/[2a]*
echo "#-- ^ ^ ^ ^ ^ ^ ^ ------- 이곳의 날짜가 더 오래돼야 합니다."
echo "#-- "; echo "#-- To: here"; ls -l [2a]*

echo "#-- "; echo "####  to  write  'h' E R E"
read a
if [ "x$a" = "xh" ]; then
	echo "#--- rsync -avzr -e 'ssh -p 22' my@host:dir*/[2a]*  >>  HERE"
	echo "#--- press Enter:"
	read a
	rsync -avzr -e 'ssh -p 15922' orangepi@pi:qna*/[2a]* .
fi
