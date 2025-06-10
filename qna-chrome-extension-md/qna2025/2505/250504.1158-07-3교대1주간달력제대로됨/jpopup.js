/* 250504.1158-07. */
document.addEventListener('DOMContentLoaded', function() {
    const yearDiv = document.getElementById('year');
    const weekdaysDiv = document.getElementById('weekdays');
    const memoAreaDiv = document.getElementById('memoArea');

    const today = new Date();
    const currentYear = today.getFullYear();

    yearDiv.textContent = `${currentYear} 년`;

    const daysOfWeekKor = ['일', '월', '화', '수', '목', '금', '토'];
    let weekDaysHTML = '';
    let memoHTML = '';

    // 이번 주 시작 날짜 계산 (일요일)
    const startOfWeek = new Date(today);
    const diff = startOfWeek.getDay();
    startOfWeek.setDate(startOfWeek.getDate() - diff);

    const workSchedule = {
        '주간-1': 0,
        '주간-2': 1,
        '야간-1': 2,
        '야간-2': 3,
        '휴무-1': 4,
        '휴무-2': 5
    };
    const workTypes = ['주간-1', '주간-2', '야간-1', '야간-2', '휴무-1', '휴무-2'];

    // 근무 시작 정보 (날짜와 근무 형태)
    const start_date_roll = {
        '250501': '주간-2'
    };

    for (let i = 0; i < 7; i++) {
        const date = new Date(startOfWeek);
        date.setDate(startOfWeek.getDate() + i);
        const day = date.getDate();
        const month = date.getMonth() + 1;
        const dayOfWeekIndex = date.getDay();
        const dayOfWeek = daysOfWeekKor[dayOfWeekIndex];
        const formattedDate = `${day} (${dayOfWeek})`;

        let displayDate = formattedDate;
        if (dayOfWeekIndex === 0 || day === 1) {
            displayDate = `${month} / ${formattedDate}`;
        }

        weekDaysHTML += `<div class="day ${date.toDateString() === today.toDateString() ? 'today' : ''}">${displayDate}</div>`;

        let memoText = '';
        const currentDateStr = `${String(date.getFullYear()).slice(2)}${String(month).padStart(2, '0')}${String(day).padStart(2, '0')}`;

        // 특정 날짜에 근무 형태 변경이 있는지 확인
        let currentWorkIndex = -1;
        let foundOverride = false;
        const sortedStartDates = Object.keys(start_date_roll).sort((a, b) => new Date(2000 + parseInt(a.slice(0, 2)), parseInt(a.slice(2, 4)) - 1, parseInt(a.slice(4, 6))) - new Date(2000 + parseInt(b.slice(0, 2)), parseInt(b.slice(2, 4)) - 1, parseInt(b.slice(4, 6))));

        for (const startDateStr of sortedStartDates) {
            const startDateOverride = new Date(2000 + parseInt(startDateStr.slice(0, 2)), parseInt(startDateStr.slice(2, 4)) - 1, parseInt(startDateStr.slice(4, 6)));
            if (date >= startDateOverride) {
                const daysSinceOverride = Math.floor((date - startDateOverride) / (1000 * 60 * 60 * 24));
                const overrideWorkType = start_date_roll[startDateStr];
                const overrideWorkIndex = workSchedule[overrideWorkType];
                currentWorkIndex = (overrideWorkIndex + daysSinceOverride) % 6;
                foundOverride = true;
            }
        }

        if (foundOverride && currentWorkIndex !== -1) {
            memoText = workTypes[currentWorkIndex];
        }

        memoHTML += `<div class="memo ${date.toDateString() === today.toDateString() ? 'today memo' : 'memo'}">${memoText}</div>`;
    }

    weekdaysDiv.innerHTML = weekDaysHTML;
    memoAreaDiv.innerHTML = memoHTML;
});
