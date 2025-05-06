// chatgpt05.1342-00
document.addEventListener('DOMContentLoaded', () => {
  const today = new Date(); // 오늘 날짜
  const yearTitle = document.getElementById('year-title');
  yearTitle.textContent = `${today.getFullYear()} 년`;

  const startPoints = [
    { date: parseDate('2025-03-31'), shift: '주간-1' },
    { date: parseDate('2025-05-05'), shift: '야간-1' }
    // 필요한 경우 추가 가능
  ];

  const calendarTable = document.getElementById('calendar-table');
  const rows = [];

  // 기준 주 시작: 오늘이 포함된 주의 일요일
  const startDate = new Date(today);
  startDate.setDate(today.getDate() - today.getDay() - 7); // 지난주 일요일

  for (let week = 0; week < 3; week++) {
    const dateRow = document.createElement('tr');
    const shiftRow = document.createElement('tr');

    for (let i = 0; i < 7; i++) {
      const date = new Date(startDate);
      date.setDate(date.getDate() + week * 7 + i);

      const isFirstDay = date.getDate() === 1 || date.getDay() === 0;
      const cellDate = formatDate(date, isFirstDay);
      const cellShift = getEffectiveShift(startPoints, date);

      const tdDate = document.createElement('td');
      tdDate.textContent = cellDate;
      const tdShift = document.createElement('td');
      tdShift.textContent = cellShift;

      dateRow.appendChild(tdDate);
      shiftRow.appendChild(tdShift);
    }

    calendarTable.appendChild(dateRow);
    calendarTable.appendChild(shiftRow);
  }
});
