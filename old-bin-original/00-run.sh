#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 

if [ "x$1" != "x" ]; then
	cmdRun "$1" "$2"
fi
