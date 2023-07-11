#!/bin/sh

cat <<__EOF__

for cn in jjedone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi ;do echo "----> \$cn:" ;rclone size \$cn: ;done

hn="ysw10mi" ; dn="tradepub" ; tim=\$(date +%y%m%d-%H%M) ; fn="out-rclone-ls-\${hn}_\${dn}-\${tim}.txt"
echo "#-- \${hn}:\${dn}" >> \${fn} ; rclone ls \${hn}:\${dn} >> \${fn} ; echo "#-- \${hn}:\${dn}" >> \${fn} ; cat \${fn}

fn="out-rclone-dir-size-\$(date +%y%m%d-%H%M).txt" ; sh ~/bin/rclone-size.sh >> \${fn} ; cat \${fn}

__EOF__


for cn in jjedone kaos1mi kaos2mi kaos3mi kaos4mi kaosngc swlibgc tpn1mi tpn2mi tpn3mi y5dnmi y5ncmi yosjgc ysw10mi
do
	echo "----> rclone lsd ${cn}:" ; rclone lsd ${cn}: ; echo "----> rclone size ${cn}:"; rclone size ${cn}:
done
echo ""
