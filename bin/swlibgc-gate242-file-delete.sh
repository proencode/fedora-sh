#--      122 2023/01_53ju/gate242_230101일-2201_g1ssd128.52ju.sql.7z
#--      122 2023/01_53ju/gate242_230108일-2201_g1ssd128.01ju.sql.7z
#--      122 2023/01_53ju/gate242_230115일-2201_g1ssd128.02ju.sql.7z
#--      122 2023/01_53ju/gate242_230119목-2201_g1ssd128.03ju.sql.7z
#--      122 2023/1_7yoil/gate242_230113금-2201_g1ssd128.6yoil.sql.7z
#--      122 2023/1_7yoil/gate242_230114토-2201_g1ssd128.7yoil.sql.7z
#--      122 2023/1_7yoil/gate242_230115일-2201_g1ssd128.8yoil.sql.7z
#--      122 2023/1_7yoil/gate242_230116월-2201_g1ssd128.2yoil.sql.7z
#--      122 2023/1_7yoil/gate242_230117화-2201_g1ssd128.3yoil.sql.7z
#--      122 2023/1_7yoil/gate242_230118수-2201_g1ssd128.4yoil.sql.7z
#--      122 2023/1_7yoil/gate242_230119목-2201_g1ssd128.5yoil.sql.7z
echo "#-- rclone delete swlibgc:gate242/2023/01_53ju/ --include \"gate242*7z\""
rclone delete swlibgc:gate242/2023/01_53ju/ --include "gate242*7z"
echo "#// rclone delete swlibgc:gate242/2023/01_53ju/ --include \"gate242*7z\""
date; echo "#---- After 1 minute, Enter:"; read a

echo "#-- rclone delete swlibgc:gate242/2023/1_7yoil/ --include \"gate242*7z\""
rclone delete swlibgc:gate242/2023/1_7yoil/ --include "gate242*7z"
echo "#// rclone delete swlibgc:gate242/2023/1_7yoil/ --include \"gate242*7z\""
date; echo "#---- After 1 minute, Enter:"; read a

#--
#-- 58745627 gate242_211129-150243_g1ssd128.sql.7z
#--
#-- 59009840 2022/1_7yoil/gate242_220821일-2210_g1ssd128.1yoil.sql.7z
#-- 59009858 2022/01_53ju/gate242_220828일-2201_g1ssd128.34ju.sql.7z
#-- 59009858 2022/01_53ju/gate242_220904일-2201_g1ssd128.35ju.sql.7z
#-- 59009858 2022/01_53ju/gate242_220911일-2201_g1ssd128.36ju.sql.7z
#-- 59005394 2022/01_53ju/gate242_220918일-2201_g1ssd128.37ju.sql.7z
#-- 59005394 2022/01_53ju/gate242_220925일-2201_g1ssd128.38ju.sql.7z
#-- 59005394 2022/01_53ju/gate242_221002일-2201_g1ssd128.39ju.sql.7z
#-- 59005394 2022/01_53ju/gate242_221009일-2201_g1ssd128.40ju.sql.7z
#-- 59005394 2022/01_53ju/gate242_221011화-2201_g1ssd128.41ju.sql.7z
#--
#-- 59006595 2022/gate242_220731일-2210_g1ssd128.07wol.sql.7z
#-- 59009858 2022/gate242_220831수-2201_g1ssd128.08wol.sql.7z
#-- 59005394 2022/gate242_220930금-2201_g1ssd128.09wol.sql.7z
#-- 59005394 2022/gate242_221011화-2201_g1ssd128.10wol.sql.7z
#--
#--  xxx 59006595 wol-copy-2022/gate242_220731일-2210_g1ssd128.07wol.sql.7z
#--  xxx 59009858 wol-copy-2022/gate242_220831수-2201_g1ssd128.08wol.sql.7z
#--  xxx 59005394 wol-copy-2022/gate242_220930금-2201_g1ssd128.09wol.sql.7z
#--  xxx 59005394 wol-copy-2022/gate242_221011화-2201_g1ssd128.3yoil.sql.7z
echo "#-- rclone delete swlibgc:gate242/wol-copy-2022/ --include \"gate242*7z\""
rclone delete swlibgc:gate242/wol-copy-2022/ --include "gate242*7z"
echo "#// rclone delete swlibgc:gate242/wol-copy-2022/ --include \"gate242*7z\""
date; echo "#---- After 1 minute, Enter:"; read a
#--
#--  xxx 53968394 mx9_8m3.567s_gate242_221011화-2201_g1ssd128.3yoil.sql.7z
echo "#-- rclone delete swlibgc:gate242/mx9_8m3.567s_gate242_221011화-2201_g1ssd128.3yoil.sql.7z"
rclone delete swlibgc:gate242/mx9_8m3.567s_gate242_221011화-2201_g1ssd128.3yoil.sql.7z
echo "#// rclone delete swlibgc:gate242/mx9_8m3.567s_gate242_221011화-2201_g1ssd128.3yoil.sql.7z"
date; echo "#---- After 1 minute, Enter:"; read a
rclone lsl swlibgc:gate242/ | sort -k4 | awk '{print $1" "$2" "$4}'
