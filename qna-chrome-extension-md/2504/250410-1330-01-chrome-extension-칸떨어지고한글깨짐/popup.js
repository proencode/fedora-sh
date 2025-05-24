document.addEventListener('DOMContentLoaded', function() {
  const calendarDiv = document.getElementById('calendar');
  const today = new Date();
  const dayOfWeek = today.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
  const date = today.getDate();

  const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
  let calendarHTML = '';

  // 첫 번째 줄 (날짜와 요일)
  calendarHTML += '<div class="calendar-row">';
  for (let i = 0; i < 7; i++) {
    const currentDate = new Date(today);
    currentDate.setDate(today.getDate() - dayOfWeek + i);
    calendarHTML += `<div class="calendar-cell">${currentDate.getDate()}                   (${daysOfWeek[currentDate.getDay()]})</div>`;
  }
  calendarHTML += '</div>';

  // 두 번째 줄 (메모 및 오늘 강조)
  calendarHTML += '<div class="calendar-row">';
  for (let i = 0; i < 7; i++) {
    if (i === dayOfWeek) {
      calendarHTML += `<div class="calendar-cell yellow-background">노란바탕</div>`;
    } else {
      calendarHTML += '<div class="calendar-cell"></div>';
	}
  }
  calendarHTML += '</div>';

  calendarDiv.innerHTML = calendarHTML;
});
