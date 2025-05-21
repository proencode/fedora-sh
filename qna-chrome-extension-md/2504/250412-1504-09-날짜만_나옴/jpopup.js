/* 250412.1504-09. 1주간 달력 */
function displayCalendar() {
  const today = new Date();
  const dayOfWeek = today.getDay();
  const firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

  const days = [];
  for (let i = 0; i < 7; i++) {
    const date = new Date(today);
    date.setDate(today.getDate() - dayOfWeek + i);
    days.push(date);
  }

  const dayNames = ["일", "월", "화", "수", "목", "금", "토"];
  const calendarCells = [
    document.getElementById("sun"),
    document.getElementById("mon"),
    document.getElementById("tue"),
    document.getElementById("wed"),
    document.getElementById("thu"),
    document.getElementById("fri"),
    document.getElementById("sat"),
  ];

  for (let i = 0; i < 7; i++) {
    const day = days[i];
    let cellText = `${day.getDate()} (${dayNames[i]})`;

    if (i === 0 || day.getDate() === 1) {
      cellText = `${day.getMonth() + 1} / ${day.getDate()} (${dayNames[i]})`;
    }

    calendarCells[i].textContent = cellText;

    if (day.toDateString() === today.toDateString()) {
      calendarCells[i].classList.add("today");
    }
  }
}

displayCalendar();
