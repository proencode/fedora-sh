#!/bin/sh

echo "----> ls -R /opt/backup/kaosdb/$(date +%Y)/*/$(date +%m)/ | grep $(date -d '1 day ago' +%y%m%d)"
ls -R /opt/backup/kaosdb/$(date +%Y)/*/$(date +%m)/ | grep $(date -d '1 day ago' +%y%m%d)
