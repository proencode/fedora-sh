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
  const headerRow = calendarTable.rows[0];
  const memoRow = calendarTable.rows[1];

  // 헤더 행 초기화
  headerRow.innerHTML = "";
  memoRow.innerHTML = "";

  const startDate = new Date(currentYear, currentMonth, currentDate - dayOfWeek);

  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate);
    date.setDate(startDate.getDate() + i);

    const day = date.getDate();
    const dayName = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];

    // 헤더 행에 날짜 표시
    const headerCell = document.createElement("th");
    headerCell.textContent = `${day} (${dayName})`;

    if (
      date.getFullYear() === currentYear &&
      date.getMonth() === currentMonth &&
      date.getDate() === currentDate
    ) {
      headerCell.classList.add("today");
    }

    headerRow.appendChild(headerCell);

    // 메모가 있는 경우 메모 행에 메모 표시
    if (schedule[day]) {
      const memoCell = document.createElement("td");
      memoCell.textContent = schedule[day];
      memoRow.appendChild(memoCell);
    } else {
      // 메모가 없는 경우 빈 셀 추가
      const emptyCell = document.createElement("td");
      memoRow.appendChild(emptyCell);
    }
  }
}

displayWeekCalendar();
