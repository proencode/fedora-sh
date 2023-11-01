#!/bin/sh

tab_show () {
        col_name=$1
        col_code=$2
        cod1=${col_code:0:2}
        cod2=${col_code:2:2}
        cod3=${col_code:4:2}
        # xxx num1=$( echo "%d\NS" $(( 16#$cod1 )) )
        num1=$( printf %d 0x${cod1} )
        # xxx num2=$( echo "ibase=16; obase=10; $cod2" | bc )
        num2=$( printf %d 0x${cod2} )
        num3=$( printf %d 0x${cod3} )
        line1="${line1} ${col_name} |"
        line2="${line2} ${col_code} |"
        line3="${line3} ${num1}-${num2}-${num3} |"
##      for i in {2..16..2} 안됨.
##      do
##              col_irm=$$(( i ))
##              col_code=$$(( i + 1 ))
##              echo "col_irm ${col_irm}; col_code ${col_code};"
##              echo "\$(( 16#\$col_code )) = $(( 16#$col_code ));"
##      done
}
color_tab () {
        tab_show $1 $2
        tab_show $3 $4
        tab_show $5 $6
        tab_show $7 $8
        tab_show $9 ${10}
        tab_show ${11} ${12}
        tab_show ${13} ${14}
        tab_show ${15} ${16}
}

line1="|" ; line2="|" ; line3="|"
color_tab "검정" "000000" "빨강" "d42c3a" "초록" "1ca800" "노랑" "c0a000" "청색" "005dff" "보라" "b148c6" "파랑" "00a89a" "흰색" "bfbfbf"
echo "- Git-Bash"
echo ${line1}
echo "|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|"
echo ${line2}
echo ${line3}

echo "- putty"
line1="|" ; line2="|" ; line3="|"
color_tab "검정" "000000" "빨강" "bb0000" "초록" "00bb00" "노랑" "c1c100" "청색" "2b95ff" "보라" "de28de" "파랑" "00bbbb" "흰색" "bbbbbb"
echo ${line1}
echo "|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|"
echo ${line2}
echo ${line3}
