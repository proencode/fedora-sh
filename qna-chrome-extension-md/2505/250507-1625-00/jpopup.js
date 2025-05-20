// gemini07.1625-00.  jpopup.js

document.addEventListener('DOMContentLoaded', function() {
  const calendarYearElement = document.getElementById('calendar-year');
  const lastWeekDays = [
    document.getElementById('last-sun'), document.getElementById('last-mon'), document.getElementById('last-tue'),
    document.getElementById('last-wed'), document.getElementById('last-thu'), document.getElementById('last-fri'),
    document.getElementById('last-sat')
  ];
  const thisWeekDays = [
    document.getElementById('this-sun'), document.getElementById('this-mon'), document.getElementById('this-tue'),
    document.getElementById('this-wed'), document.getElementById('this-thu'), document.getElementById('this-fri'),
    document.getElementById('this-sat')
  ];
  const nextWeekDays = [
    document.getElementById('next-sun'), document.getElementById('next-mon'), document.getElementById('next-tue'),
    document.getElementById('next-wed'), document.getElementById('next-thu'), document.getElementById('next-fri'),
    document.getElementById('next-sat')
  ];
  const lastWeekWorks = [
    document.getElementById('last-sun-work'), document.getElementById('last-mon-work'), document.getElementById('last-tue-work'),
    document.getElementById('last-wed-work'), document.getElementById('last-thu-work'), document.getElementById('last-fri-work'),
    document.getElementById('last-sat-work')
  ];
  const thisWeekWorks = [
    document.getElementById('this-sun-work'), document.getElementById('this-mon-work'), document.getElementById('this-tue-work'),
    document.getElementById('this-wed-work'), document.getElementById('this-thu-work'), document.getElementById('this-fri-work'),
    document.getElementById('this-sat-work')
  ];
  const nextWeekWorks = [
    document.getElementById('next-sun-work'), document.getElementById('next-mon-work'), document.getElementById('next-tue-work'),
    document.getElementById('next-wed-work'), document.getElementById('next-thu-work'), document.getElementById('next-fri-work'),
    document.getElementById('next-sat-work')
  ];

  const today = new Date();
  const currentYear = today.getFullYear();
  calendarYearElement.textContent = `${currentYear} 년`;

  function getDayOfWeek(date) {
    const days = ['일', '월', '화', '수', '목', '금', '토'];
    return days[date.getDay()];
  }

  function formatDate(date) {
    const day = date.getDate();
    const month = date.getMonth() + 1;
    const dayOfWeek = getDayOfWeek(date);
    if (dayOfWeek === '일' || day === 1) {
      return `${month} / ${day} (${dayOfWeek})`;
    }
    return `${day} (${dayOfWeek})`;
  }

  function getDatesFor3Weeks() {
    const dates = [];
    const firstDayOfThisWeek = new Date(today);
    const dayOfWeek = firstDayOfThisWeek.getDay(); // 0 for Sunday, 1 for Monday, etc.
    firstDayOfThisWeek.setDate(today.getDate() - dayOfWeek); // Go back to Sunday of this week

    for (let i = -7; i < 14; i++) {
      const date = new Date(firstDayOfThisWeek);
      date.setDate(firstDayOfThisWeek.getDate() + i);
      dates.push(date);
    }
    return dates;
  }

  const allDates = getDatesFor3Weeks();

  for (let i = 0; i < 7; i++) {
    lastWeekDays[i].textContent = formatDate(allDates[i]);
    thisWeekDays[i].textContent = formatDate(allDates[i + 7]);
    nextWeekDays[i].textContent = formatDate(allDates[i + 14]);
  }

  // (250315,'주간-1') 와 같은 형식의 근무 데이터 배열
  const workScheduleData = [
    { date: new Date(2025, 2, 15), work: '주간-1' },
    { date: new Date(2025, 2, 17), work: '휴무-2' }
  ];

  // 시작 날짜와 시작 근무 형태를 prompt 로 입력 받음
  const startDateInput = prompt("근무 시작 년월일을 입력하세요 (YYYY-MM-DD):");
  const startWorkInput = prompt("시작일의 근무 형태를 입력하세요 (주간-1, 주간-2, 야간-1, 야간-2, 휴무-1, 휴무-2):");

  let startDate;
  try {
    startDate = new Date(startDateInput);
    if (isNaN(startDate)) {
      alert("잘못된 날짜 형식입니다.");
      return;
    }
  } catch (error) {
    alert("잘못된 날짜 형식입니다.");
    return;
  }

  const workTypes = ['주간-1', '주간-2', '야간-1', '야간-2', '휴무-1', '휴무-2'];
  let startIndex = workTypes.indexOf(startWorkInput);
  if (startIndex === -1) {
    alert("잘못된 근무 형태입니다.");
    return;
  }

  function getWorkType(date, initialStartDate, initialStartIndex, scheduleData) {
    // 특정 날짜에 대한 재정의된 근무 일정이 있는지 확인
    const override = scheduleData.find(item =>
      item.date.getFullYear() === date.getFullYear() &&
      item.date.getMonth() === date.getMonth() &&
      item.date.getDate() === date.getDate()
    );
    if (override) {
      return override.work;
    }

    // 최초 시작일을 기준으로 근무 형태 계산
    if (!initialStartDate) {
      return ''; // 시작일 이전은 빈칸
    }

    const diffInDays = Math.floor((date - initialStartDate) / (1000 * 60 * 60 * 24));
    if (diffInDays < 0) {
      return ''; // 시작일 이전은 빈칸
    }
    const workIndex = (initialStartIndex + diffInDays) % 6;
    return workTypes[workIndex];
  }

  for (let i = 0; i < allDates.length; i++) {
    const workType = getWorkType(allDates[i], startDate, startIndex, workScheduleData);
    if (i < 7) {
      lastWeekWorks[i].textContent = workType;
    } else if (i < 14) {
      thisWeekWorks[i - 7].textContent = workType;
    } else {
      nextWeekWorks[i - 14].textContent = workType;
    }
  }

  // 칸 너비 자동 조정 (가장 긴 문자열을 기준으로)
  function adjustColumnWidth() {
    const allCells = document.querySelectorAll('th, td');
    let maxWidth = 0;
    allCells.forEach(cell => {
      maxWidth = Math.max(maxWidth, cell.textContent.length);
    });
    const columnWidth = maxWidth * 10 + 20; // 대략적인 너비 계산 (글자 수 * 픽셀 + 여백)
    allCells.forEach(cell => {
      cell.style.width = `${columnWidth}px`;
    });
  }

  // setTimeout 으로 렌더링 이후에 실행하여 정확한 너비 계산
  setTimeout(adjustColumnWidth, 100);
});
