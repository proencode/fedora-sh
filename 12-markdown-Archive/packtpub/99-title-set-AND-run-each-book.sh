#!/bin/sh

# https://zetawiki.com/wiki/Bash_2%EC%B0%A8%EC%9B%90_%EB%B0%B0%EC%97%B4

declare -A  r0=([Code]="00"    [Name]="Preface")
declare -A  r1=([Code]="01.p1" [Name]="Part-1")
declare -A  r2=([Code]="02.c1" [Name]="Chapter-1")
declare -A  r3=([Code]="03.c2" [Name]="Cha   pter-2")
declare -A  r4=([Code]="04.c3" [Name]="Chapter-3")
declare -A  r5=([Code]="05.p2" [Name]="Part-2")
declare -A  r6=([Code]="06.c4" [Name]="Chap ter-4")
declare -A  r7=([Code]="07.p3" [Name]="Part-3")
declare -A  r8=([Code]="08.c5" [Name]="Chap ter-5")
declare -A  r9=([Code]="09.c6" [Name]="Chapter-6")
declare -A r10=([Code]="10.c7" [Name]="Ch ap ter-7")
declare -A tabCont

for i in {0..10}
do
	for c in Code Name
	do
		ref="r$i[$c]"
		tabCont[$i,$c]=${!ref}
	done
#--
	echo "----> ${tabCont[$i,Code]} : ${tabCont[$i,Name]}"
done
