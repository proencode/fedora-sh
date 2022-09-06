#!/bin/sh

qqq=gate242_220826금-2201_g1ssd128.08wol.sql

zzz=gate242_*

for seq in 1 2 3 4 5 6 7 8 9 10
do
  cat <<__EOF__
----> time 7za a -mx=${seq} ${qqq}-mx${seq}.7z ${qqq}
mv ${qqq}-mx${seq}.7z ${qqq}-mx${seq}-
__EOF__
  time 7za a -mx=${seq} ${qqq}-mx${seq}.7z ${qqq}
  cat <<__EOF__
.7z
------------------------------
__EOF__
done

cat <<__EOF__
----> time 7za a ${qqq}-NON.7z ${qqq}
mv ${qqq}-NON.7z ${qqq}-NON-
__EOF__
time 7za a ${qqq}-NON.7z ${qqq}
cat <<__EOF__
.7z
------------------------------
__EOF__

cat <<__EOF__
__EOF__
ls -lSr ${zzz}

cat <<__EOF__
08:42:07토22-08-27 yosjn@g1ssd128 ~/backup
backup $ sh zip-test-gate242_220826-2201.sql.sh 
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx1.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx1-0m17.921s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx2.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx2-0m22.540s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx3.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx3-0m28.772s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx4.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx4-0m33.722s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx5.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx5-4m12.454s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx6.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx6-4m43.302s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx7.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx7-7m22.924s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx8.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx8-7m21.121s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx9.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx9-7m22.190s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-mx10.7z gate242_220826금-2201_g1ssd128.08wol.sql-mx10-7m21.058s.7z
mv gate242_220826금-2201_g1ssd128.08wol.sql-NON.7z gate242_220826금-2201_g1ssd128.08wol.sql-NON-4m11.476s.7z
09:26:29토22-08-27 yosjn@g1ssd128 ~/backup
backup $ ls -ltr gate242_22*
-rw-rw-r--. 1 yosjn yosjn   54076573  8월 27 09:14 gate242_220826금-2201_g1ssd128.08wol.sql-mx9-7m22.190s.7z
-rw-rw-r--. 1 yosjn yosjn   54076573  8월 27 09:07 gate242_220826금-2201_g1ssd128.08wol.sql-mx8-7m21.121s.7z
-rw-rw-r--. 1 yosjn yosjn   54076573  8월 27 09:00 gate242_220826금-2201_g1ssd128.08wol.sql-mx7-7m22.924s.7z
-rw-rw-r--. 1 yosjn yosjn   54076573  8월 27 09:22 gate242_220826금-2201_g1ssd128.08wol.sql-mx10-7m21.058s.7z

-rw-rw-r--. 1 yosjn yosjn   58484810  8월 27 08:52 gate242_220826금-2201_g1ssd128.08wol.sql-mx6-4m43.302s.7z

-rw-rw-r--. 1 yosjn yosjn   59009928  8월 27 08:48 gate242_220826금-2201_g1ssd128.08wol.sql-mx5-4m12.454s.7z
-rw-rw-r--. 1 yosjn yosjn   59009928  8월 27 09:26 gate242_220826금-2201_g1ssd128.08wol.sql-NON-4m11.476s.7z

-rw-rw-r--. 1 yosjn yosjn   70338905  8월 27 08:43 gate242_220826금-2201_g1ssd128.08wol.sql-mx4-0m33.722s.7z
-rw-rw-r--. 1 yosjn yosjn   73070317  8월 27 08:43 gate242_220826금-2201_g1ssd128.08wol.sql-mx3-0m28.772s.7z
-rw-rw-r--. 1 yosjn yosjn   76096866  8월 27 08:42 gate242_220826금-2201_g1ssd128.08wol.sql-mx2-0m22.540s.7z
-rw-rw-r--. 1 yosjn yosjn   77769839  8월 27 08:42 gate242_220826금-2201_g1ssd128.08wol.sql-mx1-0m17.921s.7z

-rw-rw-r--. 1 yosjn yosjn 1115312849  8월 26 22:01 gate242_220826금-2201_g1ssd128.08wol.sql
10:05:31토22-08-27 yosjn@g1ssd128 ~/backup
backup $
__EOF__
