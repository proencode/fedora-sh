/* 250304-05 */
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
  const row = calendarTable.rows[1]; // 두 번째 행

  const startDate = new Date(currentYear, currentMonth, currentDate - dayOfWeek);

  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate);
    date.setDate(startDate.getDate() + i);

    const day = date.getDate();
    const dayName = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];

    const cell = row.insertCell(i); // 셀 생성
    cell.textContent = `${day} (${dayName})`;

    if (
      date.getFullYear() === currentYear &&
      date.getMonth() === currentMonth &&
      date.getDate() === currentDate
    ) {
      cell.classList.add("today");
    }

    if (schedule[day]) {
      cell.textContent += ` - ${schedule[day]}`;
    }
  }
}

displayWeekCalendar();
