#!/bin/sh

echo "for val in 1 3 5 7 9"
for val in 1 3 5 7 9
do
	echo "----> time 7za a -ptest -mx=${val} Big_programs-mx${val}-220905.7z [LW]*"
	time 7za a -ptest -mx=${val} Big_programs-mx${val}-220905.7z [LW]*
	echo "----> time 7za a -ptest -mx=${val} Download-bada-mx${val}-220905.7z bada"
	time 7za a -ptest -mx=${val} Download-bada-mx${val}-220905.7z bada
done
echo "val=\"NONE\"" 2>&1 >> 7za-a-220905.log
val="NONE"
echo "----> time 7za a -ptest Big_programs-mx${val}-220905.7z [LW]*"
time 7za a -ptest Big_programs-mx${val}-220905.7z [LW]*
echo "----> time 7za a -ptest Download-bada-mx${val}-220905.7z bada"
time 7za a -ptest Download-bada-mx${val}-220905.7z bada
