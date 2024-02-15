#!/bin/sh

if [ ! -d ~/bin ]; then
	echo "----> mkdir ~/bin"
	mkdir ~/bin
fi
echo "----> cp ~/git-projects/fedora-sh/bin-original/[7ad]* ~/bin/"
cp ~/git-projects/fedora-sh/bin-original/[7ad]* ~/bin/
echo "----> cp ~/git-projects/fedora-sh/rclone-all-list/[ilry]* ~/bin/"
cp ~/git-projects/fedora-sh/rclone-all-list/[ilry]* ~/bin/
echo "----> ls -al ~/bin"
ls -al ~/bin
