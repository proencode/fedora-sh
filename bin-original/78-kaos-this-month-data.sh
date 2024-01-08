#!/bin/sh

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaos.kr ls -l /var/base/*base/$(date +%Y)/$(date +%m)/ /var/base_db/kaosorder2/$(date +%Y)/$(date +%m)/
