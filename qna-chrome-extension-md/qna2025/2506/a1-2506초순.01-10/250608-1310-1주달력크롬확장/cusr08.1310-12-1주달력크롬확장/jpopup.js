// 메모 데이터 객체
let memos = {};

// 요일 한글 표시
const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

// 날짜 포맷팅 함수
function formatDate(date) {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const weekday = weekdays[date.getDay()];
    
    if (day === 1 || date.getDay() === 0) {
        return `${month} / ${day} (${weekday})`;
    }
    return `${day} (${weekday})`;
}

// 날짜 문자열 포맷팅 (YYYY-MM-DD)
function formatDateString(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// 주 단위 달력 생성 함수
function createWeekCalendar(startDate) {
    const weekContainer = document.createElement('div');
    weekContainer.className = 'week-container';

    const dateRow = document.createElement('div');
    dateRow.className = 'calendar-row';
    
    const memoRow = document.createElement('div');
    memoRow.className = 'calendar-row';

    for (let i = 0; i < 7; i++) {
        const currentDate = new Date(startDate);
        currentDate.setDate(startDate.getDate() + i);
        
        const dateCell = document.createElement('div');
        dateCell.className = 'calendar-cell';
        const dateText = document.createElement('div');
        dateText.className = 'date';
        
        if (i === 0) dateText.classList.add('sunday');
        if (i === 6) dateText.classList.add('saturday');
        
        if (currentDate.toDateString() === new Date().toDateString()) {
            dateCell.classList.add('today');
        }
        
        dateText.textContent = formatDate(currentDate);
        dateCell.appendChild(dateText);
        dateRow.appendChild(dateCell);

        const memoCell = document.createElement('div');
        memoCell.className = 'calendar-cell';
        const memoText = document.createElement('div');
        memoText.className = 'memo';
        
        if (currentDate.toDateString() === new Date().toDateString()) {
            memoCell.classList.add('today');
        }
        
        const dateString = formatDateString(currentDate);
        memoText.textContent = memos[dateString] || '';
        memoCell.appendChild(memoText);
        memoRow.appendChild(memoCell);
    }

    weekContainer.appendChild(dateRow);
    weekContainer.appendChild(memoRow);
    return weekContainer;
}

// 달력 생성 함수
function createCalendar() {
    const calendar = document.getElementById('calendar');
    const today = new Date();
    
    // 년도 표시 업데이트
    document.getElementById('yearDisplay').textContent = `${today.getFullYear()}년`;
    
    // 이번 주 일요일 찾기
    const currentWeekSunday = new Date(today);
    currentWeekSunday.setDate(today.getDate() - today.getDay());

    // 이전 주 일요일
    const prevWeekSunday = new Date(currentWeekSunday);
    prevWeekSunday.setDate(currentWeekSunday.getDate() - 7);

    // 다음 주 일요일
    const nextWeekSunday = new Date(currentWeekSunday);
    nextWeekSunday.setDate(currentWeekSunday.getDate() + 7);

    // 기존 달력 내용 제거
    while (calendar.children.length > 1) {
        calendar.removeChild(calendar.lastChild);
    }

    // 이전 주 달력 추가
    calendar.appendChild(createWeekCalendar(prevWeekSunday));
    
    // 현재 주 달력 추가
    calendar.appendChild(createWeekCalendar(currentWeekSunday));
    
    // 다음 주 달력 추가
    calendar.appendChild(createWeekCalendar(nextWeekSunday));
}

// 모달 관련 변수
let selectedDate = new Date();
let currentMonth = new Date();

// 모달 열기
function openModal() {
    document.getElementById('memoModal').style.display = 'block';
    updateMonthDisplay();
    createMonthGrid();
}

// 모달 닫기
function closeModal() {
    document.getElementById('memoModal').style.display = 'none';
}

// 월 변경
function changeMonth(delta) {
    currentMonth.setMonth(currentMonth.getMonth() + delta);
    updateMonthDisplay();
    createMonthGrid();
}

// 월 표시 업데이트
function updateMonthDisplay() {
    const year = currentMonth.getFullYear();
    const month = currentMonth.getMonth() + 1;
    document.getElementById('monthDisplay').textContent = `${year}년 ${month}월`;
}

// 월 그리드 생성
function createMonthGrid() {
    const grid = document.getElementById('monthGrid');
    grid.innerHTML = '';

    // 요일 헤더 추가
    weekdays.forEach(day => {
        const dayHeader = document.createElement('div');
        dayHeader.textContent = day;
        dayHeader.style.fontWeight = 'bold';
        grid.appendChild(dayHeader);
    });

    const year = currentMonth.getFullYear();
    const month = currentMonth.getMonth();
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);

    // 첫 날의 요일만큼 빈 칸 추가
    for (let i = 0; i < firstDay.getDay(); i++) {
        const emptyDay = document.createElement('div');
        emptyDay.className = 'month-day';
        grid.appendChild(emptyDay);
    }

    // 날짜 추가
    for (let day = 1; day <= lastDay.getDate(); day++) {
        const dayElement = document.createElement('div');
        dayElement.className = 'month-day';
        dayElement.textContent = day;
        
        const currentDate = new Date(year, month, day);
        const dateString = formatDateString(currentDate);
        
        if (memos[dateString]) {
            dayElement.style.backgroundColor = '#e9ecef';
        }
        
        if (currentDate.toDateString() === selectedDate.toDateString()) {
            dayElement.classList.add('selected');
        }

        dayElement.onclick = () => {
            selectedDate = new Date(year, month, day);
            document.querySelectorAll('.month-day').forEach(el => el.classList.remove('selected'));
            dayElement.classList.add('selected');
            document.getElementById('memoInput').value = memos[dateString] || '';
        };

        grid.appendChild(dayElement);
    }
}

// 메모 저장
function saveMemo() {
    const dateString = formatDateString(selectedDate);
    const memoText = document.getElementById('memoInput').value;
    memos[dateString] = memoText;
    createCalendar();
}

// 메모 삭제
function deleteMemo() {
    const dateString = formatDateString(selectedDate);
    delete memos[dateString];
    document.getElementById('memoInput').value = '';
    createCalendar();
}

// Chrome Storage에 저장
function saveToStorage() {
    chrome.storage.sync.set({ 'calendarMemos': memos }, function() {
        alert('저장되었습니다.');
    });
}

// Chrome Storage에서 불러오기
function loadFromStorage() {
    chrome.storage.sync.get(['calendarMemos'], function(result) {
        if (result.calendarMemos) {
            memos = result.calendarMemos;
            createCalendar();
            if (document.getElementById('memoModal').style.display === 'block') {
                const dateString = formatDateString(selectedDate);
                document.getElementById('memoInput').value = memos[dateString] || '';
            }
        }
    });
}

// 페이지 로드 시 달력 생성 및 저장된 데이터 불러오기
document.addEventListener('DOMContentLoaded', function() {
    createCalendar();
    loadFromStorage();
}); 
