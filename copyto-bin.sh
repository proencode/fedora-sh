#!/bin/sh

if [ ! -d ~/bin ]; then
	echo "----> mkdir ~/bin"
	mkdir ~/bin
fi
echo "----> rsync -avzr ~/git-projects/fedora-sh/bin-original/[7ad]* ~/bin/"
rsync -avzr ~/git-projects/fedora-sh/bin-original/[7ad]* ~/bin/
echo "----> rsync -avzr ~/git-projects/fedora-sh/rclone-all-list/[ilrsy]* ~/bin/"
rsync -avzr ~/git-projects/fedora-sh/rclone-all-list/[ilrsy]* ~/bin/
echo "----> rsync -avzr ~/git-projects/fedora-sh/copy* ~/bin/"
rsync -avzr ~/git-projects/fedora-sh/copy* ~/bin/
echo "----> rsync -avzr ~/git-projects/fedora-sh/cmdbox ~/bin/"
rsync -avzr ~/git-projects/fedora-sh/cmdbox ~/bin/
echo "----> ls -al ~/bin"
rsync -avzr ~/git-projects/fedora-sh/bin*/du-* ~/bin/
ls -altr ~/bin

echo "----> sh ~/bin/load-keepass.sh"
sh ~/bin/load-keepass.sh
rc_lsl=~/rclone-lsl
if [ ! -d ${rc_lsl} ]; then
	echo "----> mkdir ${rc_lsl}"
	mkdir ${rc_lsl}
fi
echo "----> cd ${rc_lsl}"
cd ${rc_lsl}
echo "----> /bin/bash ~/bin/rclone-all-list.sh"
/bin/bash ~/bin/rclone-all-list.sh
echo "----> sh ~/bin/yesterday-rclone-lsl.sh"
sh ~/bin/yesterday-rclone-lsl.sh 
