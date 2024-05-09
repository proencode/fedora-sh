#!/bin/sh

rclsd () {
	rclone_name=$1
	cloud_is=$2
	cat <<__EOF__

#----> rclone lsd ${rclone_name}: #-- cloud: ${cloud_is}
__EOF__
	rclone lsd ${rclone_name}:
}
rclsd edone                onedrive
rclsd jjdrb                dropbox
rclsd jjone                onedrive
rclsd kaos1mi              mega
rclsd kaos2mi              mega
rclsd kaos3mi              mega
rclsd kaos4mi              mega
rclsd kaosngc              drive
rclsd swlibgc              drive
rclsd tpn1mi               mega
rclsd tpn2mi               mega
rclsd tpn3mi               mega
rclsd tpn4mi               mega
rclsd y5dnmi               mega
rclsd y5ncmi               mega
rclsd yosjgc               drive
rclsd ysw10mi              mega
rclsd yswone               onedrive
