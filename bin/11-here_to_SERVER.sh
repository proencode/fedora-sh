#/bin/sh

echo "#-- "; echo "#-- From: here"; ls -l [2a]*
echo "#-- "
echo "#-- ======= V V V V V V V ======= 이곳의 날짜가 더 오래돼야 합니다."
echo "#-- To: S E R V E R"; ssh -p 15922 orangepi@pi ls -l qna*/[2a]*
echo "#-- ======= ^ ^ ^ ^ ^ ^ ^ ======= 이곳의 날짜가 더 오래돼야 합니다."

echo "#-- "; echo "####  to  write  's' E R V E R"
read a
if [ "x$a" = "xs" ]; then
	echo "#--- rsync -avzr -e 'ssh -p 22'  [2a]*  >>>  my@host:dir*/"
	echo "#--- press Enter:"
	read a
	rsync -avzr -e 'ssh -p 15922' [2a]* orangepi@pi:qna*/
fi
