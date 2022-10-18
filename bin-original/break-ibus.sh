#!/bin/sh

echo "" ; echo "" ; echo ""
echo "#-- (3) 화면에 EN 또는 한 이나 ko 표시가 없는 경우에 사용합니다."
# echo "#----> press Enter:" ; read a
echo "#-- (3-1) ibus exit --> 한글입력 프로그램을 종료합니다."
ibus exit
# echo "#----> press Enter:" ; read a
echo "#-- (3-2) ibus-daemon & --> 한글입력 프로그램을 백그라운드로 실행합니다."
ibus-daemon &
