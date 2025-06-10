const schedule = {
  19: 'meeting',
  21: 'movie: 007',
  24: 'drive to customer'
};

function displayWeekCalendar() {
  const today = new Date();
  const dayOfWeek = today.getDay();
  const currentDate = today.getDate();
  const currentMonth = today.getMonth();
  const currentYear = today.getFullYear();

  const calendarTable = document.getElementById("calendar");
  const headerRow = calendarTable.rows[0];
  const memoRow = calendarTable.rows[1];

  headerRow.innerHTML = "";
  memoRow.innerHTML = "";

  const startDate = new Date(currentYear, currentMonth, currentDate - dayOfWeek);

  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate);
    date.setDate(startDate.getDate() + i);

    const day = date.getDate();
    const dayName = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];
    const month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더함

    let dateText = `${day} (${dayName})`;

    // 일요일이거나 다음 달로 넘어가는 경우 월 표시
    if (date.getDay() === 0 || (i > 0 && date.getDate() === 1)) {
      dateText = `${month} / ${day} (${dayName})`;
    }

    const headerCell = document.createElement("th");
    headerCell.textContent = dateText;

    if (
      date.getFullYear() === currentYear &&
      date.getMonth() === currentMonth &&
      date.getDate() === currentDate
    ) {
      headerCell.classList.add("today");
    }

    headerRow.appendChild(headerCell);

    if (schedule[day]) {
      const memoCell = document.createElement("td");
      memoCell.textContent = schedule[day];
      memoRow.appendChild(memoCell);
    } else {
      const emptyCell = document.createElement("td");
      memoRow.appendChild(emptyCell);
    }
  }
}

displayWeekCalendar();
