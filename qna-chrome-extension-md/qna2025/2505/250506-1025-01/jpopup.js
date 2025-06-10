// gemini06.1025-01.  jpopup.js
document.addEventListener('DOMContentLoaded', function() {
  const calendarTable = document.getElementById('calendarTable');
  const today = new Date();
  const currentYear = today.getFullYear();
  const currentMonth = today.getMonth();
  const currentDate = today.getDate();
  const dayOfWeek = today.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일

  const 근무패턴 = ['주간-1', '주간-2', '야간-1', '야간-2', '휴무-1', '휴무-2'];
  const 근무시작정보 = [
    { 날짜: new Date(2025, 4, 4), 근무: '주간-1' } // 2025년 5월 4일부터 주간-1 시작
    // 필요에 따라 근무 시작 정보 추가 (예: { 날짜: new Date(2025, 5, 15), 근무: '야간-2' })
  ];

  function getDayInfo(date) {
    const year = date.getFullYear();
    const month = date.getMonth();
    const day = date.getDate();
    const dayIndex = date.getDay();
    const dayNames = ['일', '월', '화', '수', '목', '금', '토'];
    const dayName = dayNames[dayIndex];
    const monthDisplay = dayIndex === 0 || day === 1 ? `${month + 1} / ` : '';
    return `${monthDisplay}${day} (${dayName})`;
  }

  function get 근무형태(date) {
    let 근무 = '';
    let 최근시작 = { 날짜: new Date(0), 근무: '' };

    for (const 시작정보 of 근무시작정보) {
      if (date >= 시작정보.날짜 && 시작정보.날짜 >= 최근시작.날짜) {
        최근시작 = 시작정보;
      }
    }

    if (최근시작.근무) {
      const diffDays = Math.floor((date - 최근시작.날짜) / (1000 * 60 * 60 * 24));
      const 근무시작Index = 근무패턴.indexOf(최근시작.근무);
      if (근무시작Index !== -1) {
        const 근무Index = (근무시작Index + diffDays) % 근무패턴.length;
        근무 = 근무패턴[근무Index];
      }
    }
    return 근무;
  }

  function createCalendar() {
    const table = document.createElement('table');
    let row;

    // 년도 표시
    row = table.insertRow();
    const yearCell = row.insertCell();
    yearCell.colSpan = 7;
    yearCell.textContent = `${currentYear} 년`;

    const weeks = [];
    const firstDayOfCurrentWeek = new Date(today);
    firstDayOfCurrentWeek.setDate(currentDate - dayOfWeek); // 이번 주 일요일

    for (let i = -1; i <= 1; i++) { // 지난주, 이번주, 다음주
      const week = [];
      const firstDayOfWeek = new Date(firstDayOfCurrentWeek);
      firstDayOfWeek.setDate(firstDayOfCurrentWeek.getDate() + i * 7);

      for (let j = 0; j < 7; j++) {
        const date = new Date(firstDayOfWeek);
        date.setDate(firstDayOfWeek.getDate() + j);
        week.push(date);
      }
      weeks.push(week);
    }

    weeks.forEach(week => {
      // 날짜 표시
      row = table.insertRow();
      week.forEach(date => {
        const cell = row.insertCell();
        cell.textContent = getDayInfo(date);
      });

      // 근무 형태 표시
      row = table.insertRow();
      week.forEach(date => {
        const cell = row.insertCell();
        cell.textContent = get 근무형태(date);
      });
    });

    calendarTable.appendChild(table);
  }

  createCalendar();
});
