document.addEventListener('DOMContentLoaded', function() {
  const dateCells = document.querySelectorAll('.dates .day');
  const memoCells = document.querySelectorAll('.memos .memo');
  const today = new Date();
  const dayOfWeek = today.getDay(); // 0 (일) ~ 6 (토)
  const currentDate = new Date(today);
  const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];

  const initialMemos = {
    "2025-05-20": "친구생일 선물준비",
    "2025-05-22": "시험"
  };

  function formatDate(date) {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month} / ${day}`;
  }

  function formatDateWithDay(date) {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const dayOfWeekStr = daysOfWeek[(new Date(date)).getDay()];
    return `${month} / ${day} (${dayOfWeekStr})`;
  }

  function formatDateForMemo(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  for (let i = 0; i < 7; i++) {
    const displayDate = new Date(currentDate);
    const dayCell = dateCells[(dayOfWeek + i) % 7];
    const memoCell = memoCells[(dayOfWeek + i) % 7];

    const formattedDate = formatDate(displayDate);
    const formattedDateWithDay = formatDateWithDay(displayDate);
    const memoDateKey = formatDateForMemo(displayDate);

    if (i === 0 || displayDate.getDate() === 1) {
      dayCell.textContent = formattedDateWithDay;
    } else {
      dayCell.textContent = displayDate.getDate() + ` (${daysOfWeek[(displayDate).getDay()]})`;
    }

    if (initialMemos.hasOwnProperty(memoDateKey)) {
      memoCell.textContent = initialMemos[`${memoDateKey}`];
    } else {
      memoCell.textContent = '';
    }

    currentDate.setDate(currentDate.getDate() + 1);
  }
});
