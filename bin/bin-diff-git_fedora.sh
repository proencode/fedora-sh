#!/bin/sh

for i in *.sh; do diff $i ~/git-projects/fedora-sh/bin/$i; echo "#^^ $i"; done
cat <<__EOF__
#-- for i in *.sh; do diff ~/bin/\$i ~/git-projects/fedora-sh/bin/\$i; done
#^^ ///////
__EOF__
