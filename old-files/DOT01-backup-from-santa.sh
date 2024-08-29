#!/bin/sh

from_dir=/var/backup-var-files

time rsync -avzr --delete --rsh="/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${from_dir} .
# time rsync -avzr --delete --rsh="/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${from_dir} .
