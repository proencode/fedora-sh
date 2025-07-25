#!/bin/bash

#-- 요일 문자열
yoil="일월화수목금토"

#---------.0...1...2...3...4...5..---
work_tab="주1 주2 야1 야2 휴1 휴2 " #-- 4글자씩 x 6종류
#---------:.|.:.|.:.|.:.|.:.|.:.|----
#---------:.|.:.|.:.|.:.111.111.1----
#---------0.123.456.789.012.345.6---- 한글 1 글자의 폭은 영문 2 글자의 폭을 차지한다.
hyu_day=4 #-- 휴 시작 번째
work_cnt=6 #-- 갯수 = 주야휴*2
todays_week=$(date +%w) #-- %w .... day of week (0..6); 0 is Sunday

cat <<__EOF__
#-- ${work_tab}
#--   0   1   2   3   4   5 ----> ($(date +"%Y-%m-%d") ${yoil:${todays_week}:1}) 오늘의 작업종류 번호를 선택하세요.
__EOF__
read today_job
if [ $today_job -lt 0 ] && [ $today_job -gt x5 ]; then
        echo "#-- 입력한 값이 0 .. 5 범위를 벗어나므로 작업을 중단합니다."
        exit -1
fi
cat <<__EOF__
^^^ [ ${today_job} ] "${work_tab:$(( today_job * 3 )):2}": 오늘의 작업
__EOF__

sunday_job=$(( today_job - todays_week ))
if [ ${sunday_job} -lt 0 ]; then
        sunday_job=$(( sunday_job + work_cnt ))
fi
job_cnt=$((sunday_job * 3)) #-- 빈칸포함 3글자로 된 work_tab 에서 일요일의 해당작업 시작위치

#// 이번주 일요일은 "${work_tab:${job_cnt}:2}" 로 시작합니다. xxx
cat <<__EOF__
#--
#-- 표시할 주의 갯수를 입력하세요. Enter 만 입력하면 [ 2 ] 주간 을 표시합니다.
__EOF__
read total_ju
if [ "x${total_ju}" == "x" ]; then
        total_ju=2
fi
cat <<__EOF__
^^^ [ ${total_ju} ]: 표시할 주간 수입니다.


__EOF__

#-- 이번주 일요일 (last Sun)
if [[ todays_week -ne 0 ]]; then #-- %w .... day of week (0..6); 0 is Sunday
	yy=$(date +%y --date='TZ="Asia/Seoul" 09:00 last Sun')
	mm=$(date +%m --date='TZ="Asia/Seoul" 09:00 last Sun')
	dd=$(date +%d --date='TZ="Asia/Seoul" 09:00 last Sun')
else
	yy=$(date +%y --date='TZ="Asia/Seoul" 09:00  Sun')
	mm=$(date +%m --date='TZ="Asia/Seoul" 09:00  Sun')
	dd=$(date +%d --date='TZ="Asia/Seoul" 09:00  Sun')
fi
y2=${yy}; m2=${mm}; d2=${dd} #-- 1..9일의 경우 01..09일로 바꾼 날짜 보관
y3="" ; m3="" #-- 년도, 월 바뀐 1일자에만 표시하기 위한것

today_work=$(( today_job * 3 ))
cat <<__EOF__
# $(date +%y%m%d) ${yoil:${todays_week}:1}
 ${work_tab:${today_work}:2} / 1639.2653 / 100.

__EOF__

#-- 다음주 일요일 (next Sun)

#-- 주야휴 (갯수 - 1)
work_cnt_minus_1=$(( ${work_cnt} * 3 - 1 ))

#-- 이달의 마지막 날
last_dd=$(date -d "$(date +%Y-%m-01) + 1 month - 1 day" +%d)

#-- XXX for all_week in {1..${total_ju}}
while [ $total_ju -gt 0 ]
do
        total_ju=$((total_ju - 1))
        this_job=""
        this_week=""
        for week in {0..6} #-- 일..토
        do
                #--
                if [ $job_cnt -ge 12 ]; then
                        this_job="${this_job}| \`${work_tab:${job_cnt}:2}\` "
                else
                        this_job="${this_job}| ${work_tab:${job_cnt}:2} "
                fi
                job_cnt=$(( job_cnt + 3 ))
                if [ $job_cnt -gt $work_cnt_minus_1 ]; then
                        job_cnt=0
                fi
                #--
                if [ $week -eq 0 ]; then
                        this_week="${this_week}| ${y3}${m3}${d2} \`(${yoil:${week}:1})\` "
                else
                        this_week="${this_week}| ${y3}${m3}${d2} (${yoil:${week}:1}) "
                fi
                y3="" ; m3=""
                #--
                if [ $dd -eq $last_dd ]; then #-- 말일인 경우.
                        dd=1
                        if [ $mm -eq 12 ]; then #-- 다음달의 년도가 바뀌어야 하면,
                                mm=1
                                if [ $yy -eq 99 ]; then
                                        yy=0
                                else
                                        yy=$(( $yy + 1 ))
                                fi
                                if [ $yy -lt 10 ]; then
                                        y2="0${yy}"
                                else
                                        y2=$yy
                                fi
                                y3="${y2}/"
                        else #-- 다음달 처리
                                mm=$(( $mm + 1 ))
                        fi
                        if [ $mm -lt 10 ]; then
                                m2="0${mm}"
                        else
                                m2=$mm
                        fi
                        m3="${m2}/"
                        #-- 이달의 마지막 날
                        last_dd=$(date -d "$(date +${y2}-${m2}-01) + 1 month - 1 day" +%d)
                else #// 말일이 아닌 경우.
                        dd=$(( $dd + 1 ))
                fi

                if [ $dd -lt 10 ]; then
                        d2="0${dd}"
                else
                        d2=$dd
                fi
        done
        this_week="${this_week}|"
        this_job="${this_job}|"
        cat <<__EOF__
${this_week}
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
${this_job}

__EOF__
done
