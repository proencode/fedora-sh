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
echo "----> ls -al ~/bin"
rsync -avzr ~/git-projects/fedora-sh/bin*/du-* ~/bin/
ls -altr ~/bin

echo "----> sh ~/bin/load-keepass.sh"
sh ~/bin/load-keepass.sh
echo "----> sh ~/bin/rclone-all-list.sh"
sh ~/bin/rclone-all-list.sh
echo "----> sh ~/bin/yesterday-rclone-lsl.sh"
sh ~/bin/yesterday-rclone-lsl.sh 
