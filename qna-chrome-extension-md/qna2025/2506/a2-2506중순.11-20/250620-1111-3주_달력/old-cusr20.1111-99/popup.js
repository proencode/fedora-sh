/* 3주 달력 cusr20.1111-05 popup.js */

// --- 상수 및 상태 ---
const WEEK_DAYS = ['일', '월', '화', '수', '목', '금', '토'];
const WEEKDAY_CLASS = ['sunday', 'weekday', 'weekday', 'weekday', 'weekday', 'weekday', 'saturday'];
const STORAGE_KEY = 'calendar-memos-v1';
let memoMode = 'short'; // 'short' or 'detail'
let calendarStartDate = null; // 3주 시작일 (Date)
let memos = {}; // { 'YYYY-MM-DD': '메모내용' }
let loadedFileName = '';

// --- 유틸 함수 ---
function pad(n) { return n < 10 ? '0' + n : n; }
function dateToKey(date) {
  return `${date.getFullYear()}-${pad(date.getMonth()+1)}-${pad(date.getDate())}`;
}
function getToday() {
  const now = new Date();
  now.setHours(0,0,0,0);
  return now;
}
function cloneDate(date) {
  return new Date(date.getTime());
}
function getWeekStart(date) {
  const d = cloneDate(date);
  d.setDate(d.getDate() - d.getDay());
  return d;
}
function get3WeekStart(today) {
  // 오늘이 포함된 주의 시작(일요일)부터 3주
  return getWeekStart(today);
}
function get3WeekDates(startDate) {
  const days = [];
  for (let w = 0; w < 3; w++) {
    const week = [];
    for (let d = 0; d < 7; d++) {
      const date = new Date(startDate);
      date.setDate(startDate.getDate() + w*7 + d);
      week.push(date);
    }
    days.push(week);
  }
  return days;
}
function getDayColorClass(dayIdx) {
  return WEEKDAY_CLASS[dayIdx];
}
function getDateLabel(date, prevDate) {
  const m = date.getMonth() + 1;
  const d = date.getDate();
  const w = WEEK_DAYS[date.getDay()];
  // 일요일이거나 월이 바뀌는 날
  if (date.getDay() === 0 || (prevDate && prevDate.getMonth() !== date.getMonth())) {
    return `${m} / ${d} (${w})`;
  }
  return `${d} (${w})`;
}
function isToday(date) {
  const t = getToday();
  return date.getFullYear() === t.getFullYear() && date.getMonth() === t.getMonth() && date.getDate() === t.getDate();
}
function getCharsPerLine(cell) {
  // 셀의 실제 width에서 평균 글자폭(9px)으로 나눔
  const style = window.getComputedStyle(cell);
  const width = cell.clientWidth - (parseInt(style.paddingLeft)||0) - (parseInt(style.paddingRight)||0) - 12; // 여유값
  return Math.max(8, Math.floor(width / 9)); // 최소 8자
}
// --- 렌더링 ---
function renderCalendar() {
  const tbody = document.getElementById('calendar-body');
  tbody.innerHTML = '';
  const weeks = get3WeekDates(calendarStartDate);
  let maxMemoLines = [1,1,1];
  let cellRefs = [[],[],[]];
  // 1차로 테이블을 그리고, 셀 참조를 저장
  weeks.forEach((week, rowIdx) => {
    const tr = document.createElement('tr');
    week.forEach((date, colIdx) => {
      const td = document.createElement('td');
      cellRefs[rowIdx][colIdx] = td;
      // 날짜 표시
      const prevDate = colIdx > 0 ? week[colIdx-1] : null;
      const dateLabel = getDateLabel(date, prevDate);
      const dateDiv = document.createElement('div');
      dateDiv.className = 'date-area ' + getDayColorClass(date.getDay());
      dateDiv.textContent = dateLabel;
      if (isToday(date)) td.classList.add('today');
      const key = dateToKey(date);
      const memoDiv = document.createElement('div');
      memoDiv.className = 'memo-area';
      let memo = memos[key] || '';
      if (memoMode === 'short' && memo.length > 26) {
        memo = memo.slice(0, 26) + '...';
      }
      memoDiv.textContent = memo;
      td.addEventListener('click', e => {
        openMemoModal(date, key);
        e.stopPropagation();
      });
      td.appendChild(dateDiv);
      td.appendChild(memoDiv);
      tr.appendChild(td);
    });
    tbody.appendChild(tr);
  });
  // 상세메모 모드에서 각 셀의 실제 폭에 따라 줄수 계산
  if (memoMode === 'detail') {
    weeks.forEach((week, rowIdx) => {
      let max = 1;
      week.forEach((date, colIdx) => {
        const td = cellRefs[rowIdx][colIdx];
        const key = dateToKey(date);
        if (memos[key]) {
          const charsPerLine = getCharsPerLine(td);
          const lines = memos[key].split('\n').map(line => Math.ceil(line.length / charsPerLine)).reduce((a,b)=>a+b,0);
          if (lines > max) max = lines;
        }
      });
      // 각 셀 높이 조정
      week.forEach((date, colIdx) => {
        const td = cellRefs[rowIdx][colIdx];
        td.style.height = (max*1.5 + 3) + 'em';
      });
    });
  } else {
    // 단축메모 모드: 고정 높이
    weeks.forEach((week, rowIdx) => {
      week.forEach((date, colIdx) => {
        const td = cellRefs[rowIdx][colIdx];
        td.style.height = '5.5em';
      });
    });
  }
}
function updateYearDisplay() {
  const year = calendarStartDate.getFullYear();
  document.getElementById('year-display').textContent = year + ' 년';
}
function updateMemoModeButton() {
  const short = document.getElementById('memo-short');
  const detail = document.getElementById('memo-detail');
  if (memoMode === 'short') {
    short.classList.add('memo-mode-active');
    detail.classList.remove('memo-mode-active');
  } else {
    short.classList.remove('memo-mode-active');
    detail.classList.add('memo-mode-active');
  }
}
function updateFileInfo() {
  document.getElementById('file-info').textContent = loadedFileName ? loadedFileName : '파일 없음';
}
// --- 메모 모달 ---
function openMemoModal(date, key) {
  const modal = document.getElementById('memo-modal');
  const input = document.getElementById('memo-input');
  input.value = memos[key] || '';
  modal.classList.remove('hidden');
  input.focus();
  // 저장
  document.getElementById('modal-save').onclick = () => {
    memos[key] = input.value.trim();
    saveMemosToStorage();
    renderCalendar();
    modal.classList.add('hidden');
  };
  // 취소
  document.getElementById('modal-cancel').onclick = () => {
    modal.classList.add('hidden');
  };
}
// --- 메모 저장/불러오기 ---
function saveMemosToStorage() {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(memos));
}
function loadMemosFromStorage() {
  const data = localStorage.getItem(STORAGE_KEY);
  if (data) {
    try { memos = JSON.parse(data) || {}; } catch { memos = {}; }
  } else {
    memos = {};
  }
}
function saveMemosToFile() {
  const blob = new Blob([JSON.stringify(memos, null, 2)], {type: 'application/json'});
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = loadedFileName || 'calendar-memos.json';
  document.body.appendChild(a);
  a.click();
  setTimeout(() => {
    document.body.removeChild(a);
    URL.revokeObjectURL(a.href);
  }, 100);
}
function loadMemosFromFile(file) {
  const reader = new FileReader();
  reader.onload = function(e) {
    try {
      memos = JSON.parse(e.target.result) || {};
      saveMemosToStorage();
      renderCalendar();
      loadedFileName = file.name;
      updateFileInfo();
    } catch {
      alert('파일 형식이 올바르지 않습니다.');
    }
  };
  reader.readAsText(file);
}
// --- 이벤트 바인딩 ---
document.addEventListener('DOMContentLoaded', () => {
  // 오늘 기준 3주 시작일 계산
  const today = getToday();
  calendarStartDate = get3WeekStart(today);
  loadMemosFromStorage();
  renderCalendar();
  updateYearDisplay();
  updateMemoModeButton();
  updateFileInfo();
  // 주 이동
  document.getElementById('prev-week').onclick = () => {
    calendarStartDate.setDate(calendarStartDate.getDate() - 7);
    updateYearDisplay();
    renderCalendar();
  };
  document.getElementById('next-week').onclick = () => {
    calendarStartDate.setDate(calendarStartDate.getDate() + 7);
    updateYearDisplay();
    renderCalendar();
  };
  // 메모 모드 토글
  document.getElementById('toggle-memo-mode').onclick = () => {
    memoMode = memoMode === 'short' ? 'detail' : 'short';
    updateMemoModeButton();
    renderCalendar();
  };
  // 저장
  document.getElementById('save-memo').onclick = () => {
    saveMemosToFile();
  };
  // 불러오기
  document.getElementById('load-memo').onclick = () => {
    document.getElementById('file-loader').click();
  };
  document.getElementById('file-loader').onchange = (e) => {
    const file = e.target.files[0];
    if (file) {
      loadMemosFromFile(file);
    }
  };
}); 
