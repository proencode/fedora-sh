// chatgpt05.1342-01 jpopup.js
document.addEventListener('DOMContentLoaded', async () => {
  const today = new Date();
  const yearTitle = document.getElementById('year-title');
  yearTitle.textContent = `${today.getFullYear()} 년`;

  const stored = localStorage.getItem('startPoints');
  const rawPoints = stored ? JSON.parse(stored) : [
    { date: '2025-03-31', shift: '주간-1' },
    { date: '2025-05-05', shift: '야간-1' }
  ];
  const startPoints = rawPoints.map(p => ({
    date: parseDate(p.date),
    shift: p.shift
  }));

  const calendarTable = document.getElementById('calendar-table');
  const startDate = new Date(today);
  startDate.setDate(today.getDate() - today.getDay() - 7);

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

  document.getElementById('open-editor').onclick = () => {
    window.open('editor.html', 'chatgpt05.1342-01 jpopup.js 근무편집기', 'width=400,height=300');
  };
});
