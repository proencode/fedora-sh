document.addEventListener('DOMContentLoaded', function() {
    const yearDiv = document.getElementById('year');
    const weekdaysDiv = document.getElementById('weekdays');
    const memoAreaDiv = document.getElementById('memoArea');

    const today = new Date();
    const currentYear = today.getFullYear();
    const currentMonth = today.getMonth() + 1;
    const currentDate = today.getDate();
    const currentDayOfWeek = today.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일

    yearDiv.textContent = `${currentYear} 년`;

    const daysOfWeekKor = ['일', '월', '화', '수', '목', '금', '토'];
    let weekDaysHTML = '';
    let memoHTML = '';

    // 이번 주 시작 날짜 계산 (일요일)
    const startOfWeek = new Date(today);
    const diff = startOfWeek.getDay();
    startOfWeek.setDate(startOfWeek.getDate() - diff);

    const memos = {
        '250501': '노동절',
        '250505': '어린이날',
        '250506': '대체휴일'
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

        const memoKey = `${String(date.getFullYear()).slice(2)}${String(month).padStart(2, '0')}${String(day).padStart(2, '0')}`;
        const memoText = memos[memoKey] || '';
        memoHTML += `<div class="memo ${date.toDateString() === today.toDateString() ? 'today' : ''}">${memoText}</div>`;
    }

    weekdaysDiv.innerHTML = weekDaysHTML;
    memoAreaDiv.innerHTML = memoHTML;
});
