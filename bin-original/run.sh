#!/bin/sh

source ${HOME}/lib/color_base

if [ "x$1" != "x" ]; then
	cat_and_run "$1" "$2"
fi
