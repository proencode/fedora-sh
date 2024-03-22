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
ls -al ~/bin
