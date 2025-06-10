// 250301-02
document.addEventListener('DOMContentLoaded', function() {
  const calendarDiv = document.getElementById('calendar');
  const today = new Date();
  const year = today.getFullYear();
  const month = today.getMonth();
  const date = today.getDate();
  const day = today.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일

  // 이번 주의 시작 날짜(일요일) 계산
  const startDate = new Date(year, month, date - day);

  let calendarHTML = '';
  for (let i = 0; i < 7; i++) {
    const currentDate = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate() + i);
    const currentDateStr = currentDate.getDate();
    const currentDay = currentDate.getDay();
    const dayNames = ['(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)'];
    const dayName = dayNames[currentDay];

    let dayBoxClass = 'day-box';
    if (currentDate.getDate() === date && currentDate.getMonth() === month && currentDate.getFullYear() === year) {
      dayBoxClass += ' today';
    }

    calendarHTML += `<div class="${dayBoxClass}">${currentDateStr} ${dayName}</div>`;
  }
  calendarDiv.innerHTML = calendarHTML;
});
