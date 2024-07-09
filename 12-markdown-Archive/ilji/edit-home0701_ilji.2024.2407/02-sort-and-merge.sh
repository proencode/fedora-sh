#!/bin/sh

ls -l ; echo "#-- sort addtoSeqName-5* > base-sort-then-handmade_uniq-$(date +%y%m%d-%H%M).md"
sort addtoSeqName-5* > base-sort-then-handmade_uniq-$(date +%y%m%d-%H%M).md
ls -l
