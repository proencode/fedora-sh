/* 3주 달력 cusr19.1318-02. popup.js */

// --- 설정값 및 상수 ---
const YEAR = 2025;
const WEEKS = 3;
const DAYS_PER_WEEK = 7;
const WEEKDAY_KO = ['일', '월', '화', '수', '목', '금', '토'];
const WEEKDAY_CLASS = ['sunday', 'weekday', 'weekday', 'weekday', 'weekday', 'weekday', 'saturday'];
const MEMO_KEY = 'calendar-memo-2025';
const FILENAME_KEY = 'calendar-memo-2025-filename';
const MAX_SHORT = 34;

// --- 상태 변수 ---
let today = new Date();
let startDate = getStartOfWeek(today);
let memoData = {};
let memoMode = 'short'; // 'short' or 'detail'
let loadedFilename = '';

// --- DOM 요소 ---
const calendarTable = document.getElementById('calendar-table');
const memoModal = document.getElementById('memo-modal');
const memoInput = document.getElementById('memo-input');
const memoSaveBtn = document.getElementById('memo-save-btn');
const memoCancelBtn = document.getElementById('memo-cancel-btn');
const memoFilename = document.getElementById('memo-filename');
const toggleMemoModeBtn = document.getElementById('toggle-memo-mode');
const memoShortSpan = document.getElementById('memo-short');
const memoDetailSpan = document.getElementById('memo-detail');

let selectedCellDate = null;

// --- 초기화 ---
window.addEventListener('DOMContentLoaded', () => {
  loadMemoFromStorage();
  renderCalendar();
  updateMemoModeBtn();
  updateFilename();
  // nav-btn을 사각형으로 만들기 위해 클래스 제거
  document.getElementById('prev-week').classList.remove('nav-btn');
  document.getElementById('next-week').classList.remove('nav-btn');
  document.getElementById('prev-week').classList.add('action-btn');
  document.getElementById('next-week').classList.add('action-btn');
  // 이벤트 바인딩
  document.getElementById('prev-week').onclick = () => moveWeek(-1);
  document.getElementById('next-week').onclick = () => moveWeek(1);
  toggleMemoModeBtn.onclick = toggleMemoMode;
  document.getElementById('save-memo').onclick = saveMemoToFile;
  document.getElementById('load-memo').onclick = loadMemoFromFile;
  memoSaveBtn.onclick = saveMemoInput;
  memoCancelBtn.onclick = closeMemoModal;
  memoModal.onclick = (e) => { if (e.target === memoModal) closeMemoModal(); };
  // 시작 시 메모파일 불러오기 모달 자동 표시
  setTimeout(() => document.getElementById('load-memo').click(), 300);
});

// --- 달력 렌더링 ---
function renderCalendar() {
  calendarTable.innerHTML = '';
  let today = new Date();
  let rows = [];
  let date = new Date(startDate);
  for (let w = 0; w < WEEKS; w++) {
    let row = [];
    for (let d = 0; d < DAYS_PER_WEEK; d++) {
      let key = getDateKey(date);
      let memo = memoData[key] || '';
      row.push({ date: new Date(date), memo, key });
      date.setDate(date.getDate() + 1);
    }
    rows.push(row);
  }
  for (let w = 0; w < WEEKS; w++) {
    let tr = document.createElement('tr');
    if (memoMode === 'detail') tr.classList.add('detail-mode');
    for (let d = 0; d < DAYS_PER_WEEK; d++) {
      let {date, memo, key} = rows[w][d];
      let td = document.createElement('td');
      if (isSameDay(date, today)) td.classList.add('today');
      td.classList.add(WEEKDAY_CLASS[date.getDay()]);
      let dateStr = getDateDisplay(date, d === 0);
      let dateDiv = document.createElement('span');
      dateDiv.className = 'cell-date';
      dateDiv.textContent = dateStr;
      td.appendChild(dateDiv);
      let memoDiv = document.createElement('span');
      memoDiv.className = 'cell-memo';
      memoDiv.style.color = '#000'; // 메모 글자색 검정
      if (memoMode === 'short' && memo.length > MAX_SHORT) {
        memoDiv.textContent = memo.slice(0, MAX_SHORT) + '...';
      } else {
        memoDiv.textContent = memo;
      }
      td.appendChild(memoDiv);
      td.onclick = () => openMemoModal(key, dateStr, memo);
      // 단축모드 셀 높이 고정
      if (memoMode === 'short') {
        td.style.height = '5.5em';
        td.style.verticalAlign = 'top';
        td.style.padding = '0';
      } else {
        td.style.height = '';
        td.style.padding = '';
      }
      // 상세모드 좌측 정렬 차이 보정
      if (memoMode === 'detail') {
        td.style.paddingLeft = '0px';
      } else {
        td.style.paddingLeft = '0px';
      }
      tr.appendChild(td);
    }
    calendarTable.appendChild(tr);
  }
}

// --- 날짜 관련 함수 ---
function getStartOfWeek(date) {
  let d = new Date(date);
  d.setDate(d.getDate() - d.getDay());
  d.setHours(0,0,0,0);
  return d;
}
function getDateKey(date) {
  return date.toISOString().slice(0,10);
}
function getDateDisplay(date, forceMonth) {
  let m = date.getMonth() + 1;
  let d = date.getDate();
  let w = WEEKDAY_KO[date.getDay()];
  // 일요일 또는 월이 바뀌는 날
  if (date.getDay() === 0 || d === 1 || forceMonth) {
    return `${m} / ${d} (${w})`;
  } else {
    return `${d} (${w})`;
  }
}
function isSameDay(a, b) {
  return a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();
}

// --- 주 이동 ---
function moveWeek(dir) {
  startDate.setDate(startDate.getDate() + dir * 7);
  renderCalendar();
}

// --- 메모 모드 전환 ---
function toggleMemoMode() {
  memoMode = (memoMode === 'short') ? 'detail' : 'short';
  updateMemoModeBtn();
  renderCalendar();
}
function updateMemoModeBtn() {
  if (memoMode === 'short') {
    memoShortSpan.classList.add('selected');
    memoDetailSpan.classList.remove('selected');
  } else {
    memoShortSpan.classList.remove('selected');
    memoDetailSpan.classList.add('selected');
  }
}

// --- 메모 모달 ---
function openMemoModal(key, dateStr, memo) {
  selectedCellDate = key;
  memoInput.value = memo;
  memoModal.classList.remove('hidden');
  memoInput.focus();
}
function closeMemoModal() {
  memoModal.classList.add('hidden');
  selectedCellDate = null;
}
function saveMemoInput() {
  if (selectedCellDate) {
    memoData[selectedCellDate] = memoInput.value.trim();
    saveMemoToStorage();
    renderCalendar();
    closeMemoModal();
  }
}

// --- 저장/불러오기 (localStorage + 파일) ---
function saveMemoToStorage() {
  localStorage.setItem(MEMO_KEY, JSON.stringify(memoData));
  if (loadedFilename) localStorage.setItem(FILENAME_KEY, loadedFilename);
}
function loadMemoFromStorage() {
  const data = localStorage.getItem(MEMO_KEY);
  if (data) memoData = JSON.parse(data);
  else memoData = {};
  loadedFilename = localStorage.getItem(FILENAME_KEY) || '';
}
function saveMemoToFile() {
  const blob = new Blob([JSON.stringify(memoData, null, 2)], {type: 'application/json'});
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  const filename = `calendar-memo-2025-${new Date().toISOString().slice(0,10)}.json`;
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  loadedFilename = filename;
  updateFilename();
  saveMemoToStorage();
}
function loadMemoFromFile() {
  const input = document.createElement('input');
  input.type = 'file';
  input.accept = 'application/json';
  input.onchange = (e) => {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (ev) => {
      try {
        memoData = JSON.parse(ev.target.result);
        loadedFilename = file.name;
        updateFilename();
        saveMemoToStorage();
        renderCalendar();
      } catch {
        alert('메모 파일이 올바르지 않습니다.');
      }
    };
    reader.readAsText(file);
  };
  input.click();
}
function updateFilename() {
  memoFilename.textContent = `메모 파일: ${loadedFilename ? loadedFilename : '(없음)'}`;
} 
