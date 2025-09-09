#!/bin/sh

ls -lh | sed "s/ ${USER} ${USER}//" > ../11-last_big_files-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-lh
#-- ls -lh | sed 's/[[:space:]]\S\+[[:space:]]\S\+ //' > ../11-last_big_files-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-lh
#-- ls -lh | awk '{$3=""; $4=""; print $0}' | sed 's/  */ /g' > ../11-last_big_files-$(LC_TIME=C date +%y%m%d_%a.%H%M).ls-lh
#=== ls -lh | awk '{$3=$4=""; print}' | column -t
