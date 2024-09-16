#!/bin/sh

#-- play -q ${bin_fs}/play-1-pbong.wav & #-- 91926__tim-kahn__ding.wav & #-- 0.3M 딩~
#-- play -q ${bin_fs}/play-2-castanets.wav & #-- 411459__inspectorj__castanets-multi-a-h1.wav & #-- 2.0M 캐스터네츠~
#-- play -q ${bin_fs}/play-3-ddenng.wav & #-- 339816__inspectorj__hand-bells-f-single.wav & #-- 1.5M 뗅-
#-- play -q ${bin_fs}/play-4-tiiill.wav & #-- 212541__misstickle__indian-bell-chime.wav & #-- 1.0M 띠일~
#-- play -q ${bin_fs}/play-5-gguuuung.wav & #-- 411090__inspectorj__wind-chime-gamelan-gong-a.wav & #-- 4.2M 데에엥~~
#-- play -q ${bin_fs}/play-6-ddeeeng.wav & #-- 513865__wormletter__chime-c.wav & #-- 1.7M 교회 뎅-

ding_val=$1
if [[ "x${ding_val}" < "x1" || "x${ding_val}" > "x6" ]]; then ding_val="1" ; fi

wavbox=(play-1-pbong.wav play-2-castanets.wav play-3-ddenng.wav play-4-tiiill.wav play-5-gguuuung.wav play-6-ddeeeng.wav)
wavhan=(1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회_뎅-)

bin_fs="${HOME}/bin/freesound"

ding_val0=$(($ding_val - 1))

play -q ${bin_fs}/${wavbox[$ding_val0]} &
echo "play -q ${wavhan[$ding_val0]} #-- ${wavhan[@]}"
