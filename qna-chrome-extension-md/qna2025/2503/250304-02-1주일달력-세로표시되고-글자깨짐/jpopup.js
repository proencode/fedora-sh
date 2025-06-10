/* 250304-02 */
function displayWeekCalendar() {
  const today = new Date();
  const dayOfWeek = today.getDay(); // 0 (일요일) ~ 6 (토요일)
  const currentDate = today.getDate();
  const currentMonth = today.getMonth();
  const currentYear = today.getFullYear();

  const calendarDiv = document.getElementById("calendar");
  calendarDiv.innerHTML = ""; // 기존 내용 초기화

  // 현재 주의 시작일 (일요일) 계산
  const startDate = new Date(currentYear, currentMonth, currentDate - dayOfWeek);

  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate);
    date.setDate(startDate.getDate() + i);

    const day = date.getDate();
    const dayName = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];

    const dayDiv = document.createElement("div");
    dayDiv.className = "day";
    dayDiv.textContent = `${day} (${dayName})`;

    // 오늘 날짜인 경우 배경색 변경
    if (
      date.getFullYear() === currentYear &&
      date.getMonth() === currentMonth &&
      date.getDate() === currentDate
    ) {
      dayDiv.classList.add("today");
    }

    calendarDiv.appendChild(dayDiv);
  }
}

displayWeekCalendar();
