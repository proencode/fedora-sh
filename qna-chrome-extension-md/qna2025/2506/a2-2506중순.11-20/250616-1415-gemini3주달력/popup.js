/* 3주 달력 cusr16.1230-04. popup.js */

class Calendar {
    constructor() {
        this.currentDate = new Date(); // 이 날짜를 기준으로 3주 뷰가 중앙에 맞춰집니다.
        this.memoMode = 'short'; // 'short' 또는 'full'
        this.memos = this.loadMemosFromLocalStorage();

        this.calendarGrid = document.getElementById('calendarGrid');
        this.yearDisplay = document.querySelector('.year-display'); // 이 요소가 포맷된 날짜를 표시합니다.
        this.prevWeekBtn = document.getElementById('prevWeekBtn');
        this.nextWeekBtn = document.getElementById('nextWeekBtn');
        this.memoModeBtn = document.getElementById('memoModeBtn');
        this.saveMemoBtn = document.getElementById('saveMemoBtn');
        this.loadMemoBtn = document.getElementById('loadMemoBtn');

        this.shortTextSpan = document.getElementById('shortText');
        this.fullTextSpan = document.getElementById('fullText');

        this.memoModal = document.getElementById('memoModal');
        this.closeModalBtn = this.memoModal.querySelector('.close-button');
        this.modalDate = document.getElementById('modalDate');
        this.memoInput = document.getElementById('memoInput');
        this.saveModalMemoBtn = document.getElementById('saveModalMemoBtn');

        this.selectedDateCell = null; // 현재 편집 중인 셀을 저장합니다.

        this.setupEventListeners();
        this.renderCalendar(); // 초기 렌더링
        this.updateMemoModeButton(); // 초기 메모 모드 버튼 상태 반영
    }

    setupEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => this.navigateWeeks(-1));
        this.nextWeekBtn.addEventListener('click', () => this.navigateWeeks(1));
        this.memoModeBtn.addEventListener('click', () => this.toggleMemoMode());
        this.saveMemoBtn.addEventListener('click', () => this.saveMemosToFile());
        this.loadMemoBtn.addEventListener('click', () => this.loadMemosFromFile());

        this.closeModalBtn.addEventListener('click', () => this.closeMemoModal());
        this.saveModalMemoBtn.addEventListener('click', () => this.saveMemoToCell());

        // 모달 외부 클릭 시 닫기
        window.addEventListener('click', (event) => {
            if (event.target === this.memoModal) {
                this.closeMemoModal();
            }
        });
    }

    renderCalendar() {
        this.calendarGrid.innerHTML = '';
        const today = new Date();
        today.setHours(0, 0, 0, 0); // 비교를 위해 오늘 날짜를 정규화합니다.

        // 현재 날짜를 해당 주의 시작(일요일)으로 설정합니다.
        const startOfWeek = new Date(this.currentDate);
        startOfWeek.setDate(this.currentDate.getDate() - this.currentDate.getDay()); // 일요일로 돌아갑니다.

        // --- 수정: 헤더 날짜를 YYYY-MM-DD (요일) 형식으로 업데이트 ---
        const daysOfWeekKorean = ['일', '월', '화', '수', '목', '금', '토'];
        const headerDate = new Date(); // 현재 시스템 날짜를 사용합니다.
        const headerYear = headerDate.getFullYear();
        const headerMonth = (headerDate.getMonth() + 1).toString().padStart(2, '0');
        const headerDay = headerDate.getDate().toString().padStart(2, '0');
        const headerDayText = daysOfWeekKorean[headerDate.getDay()];
        this.yearDisplay.textContent = `${headerYear}-${headerMonth}-${headerDay} (${headerDayText})`;
        // --- 수정 끝 ---


        for (let i = 0; i < 3 * 7; i++) { // 3주 * 7일
            const date = new Date(startOfWeek);
            date.setDate(startOfWeek.getDate() + i);

            const cell = document.createElement('div');
            cell.classList.add('calendar-cell');
            // 현재 메모 모드에 따라 full-memo-mode 클래스를 적용합니다.
            if (this.memoMode === 'full') {
                cell.classList.add('full-memo-mode');
            }

            const dateArea = document.createElement('div');
            dateArea.classList.add('date-area');

            const memoArea = document.createElement('div');
            memoArea.classList.add('memo-area');

            const dayOfWeek = date.getDay(); // 0: 일요일, 6: 토요일
            let dateString = '';

            // 한국어 요일
            const dayText = daysOfWeekKorean[dayOfWeek];

            // 날짜 형식 적용 로직: 일요일, 월 변경, 또는 뷰의 첫 날인 경우 "월 / 일 (요일)"
            // 그 외에는 "일 (요일)"
            if (date.getDate() === 1 || i === 0 || dayOfWeek === 0) {
                dateString = `${date.getMonth() + 1} / ${date.getDate()} (${dayText})`;
            } else {
                dateString = `${date.getDate()} (${dayText})`;
            }

            dateArea.textContent = dateString;
            
            // 요일별 색상 클래스 적용
            if (dayOfWeek === 0) { // 일요일
                dateArea.classList.add('sunday');
            } else if (dayOfWeek === 6) { // 토요일
                dateArea.classList.add('saturday');
            } else { // 평일
                dateArea.classList.add('weekday');
            }

            // 오늘 날짜 강조
            if (date.toDateString() === today.toDateString()) {
                cell.classList.add('today');
            }

            // 해당 날짜의 메모를 로드합니다.
            const dateKey = this.getDateKey(date);
            const memo = this.memos[dateKey] || '';

            // 메모 내용을 설정합니다. CSS가 'short' 모드에서 자르기를 처리합니다.
            memoArea.textContent = memo;

            cell.dataset.date = dateKey; // 메모 검색을 위해 날짜 키를 저장합니다.
            cell.appendChild(dateArea);
            cell.appendChild(memoArea);
            this.calendarGrid.appendChild(cell);

            cell.addEventListener('click', () => this.openMemoModal(date, memo, cell));
        }
    }

    navigateWeeks(direction) {
        // 1주씩 이동
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar(); // 달력과 헤더를 업데이트하기 위해 다시 렌더링합니다.
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === 'short' ? 'full' : 'short';
        this.updateMemoModeButton();
        this.renderCalendar(); // 메모 모드 변경 사항을 셀 높이에 적용하기 위해 다시 렌더링합니다.
    }

    updateMemoModeButton() {
        if (this.memoMode === 'short') {
            this.shortTextSpan.classList.add('highlight');
            this.fullTextSpan.classList.remove('highlight');
        } else {
            this.shortTextSpan.classList.remove('highlight');
            this.fullTextSpan.classList.add('highlight');
        }
    }

    getDateKey(date) {
        return date.toISOString().split('T')[0]; // YYYY-MM-DD
    }

    openMemoModal(date, memo, cell) {
        this.selectedDateCell = cell;
        this.modalDate.textContent = `${date.getMonth() + 1}월 ${date.getDate()}일 (${['일', '월', '화', '수', '목', '금', '토'][date.getDay()]})`;
        this.memoInput.value = memo;
        this.memoModal.style.display = 'flex'; // 중앙 정렬을 위해 flex를 사용합니다.
    }

    closeMemoModal() {
        this.memoModal.style.display = 'none';
        this.memoInput.value = '';
        this.selectedDateCell = null;
    }

    saveMemoToCell() {
        if (this.selectedDateCell) {
            const dateKey = this.selectedDateCell.dataset.date;
            const newMemo = this.memoInput.value;
            this.memos[dateKey] = newMemo;
            this.saveMemosToLocalStorage();
            this.renderCalendar(); // 메모 표시를 업데이트하기 위해 다시 렌더링합니다.
            this.closeMemoModal();
        }
    }

    saveMemosToLocalStorage() {
        try {
            localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
            console.log('메모가 localStorage에 저장되었습니다.');
        } catch (e) {
            console.error('localStorage에 메모 저장 중 오류 발생:', e);
            alert('메모 저장 중 오류가 발생했습니다.');
        }
    }

    loadMemosFromLocalStorage() {
        try {
            const storedMemos = localStorage.getItem('calendarMemos');
            return storedMemos ? JSON.parse(storedMemos) : {};
        } catch (e) {
            console.error('localStorage에서 메모 로드 중 오류 발생:', e);
            return {};
        }
    }

    saveMemosToFile() {
        const dataStr = JSON.stringify(this.memos, null, 2);
        const blob = new Blob([dataStr], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'calendar_memos.json';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        alert('메모가 calendar_memos.json 파일로 저장되었습니다.');
    }

    loadMemosFromFile() {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'application/json';
        input.onchange = async (event) => {
            const file = event.target.files[0];
            if (file) {
                try {
                    const text = await file.text();
                    const loadedMemos = JSON.parse(text);
                    // 로드된 메모를 기존 메모와 병합하거나 덮어씁니다.
                    // 이 예시에서는 덮어씁니다. 병합하려면 반복하여 할당해야 합니다.
                    this.memos = loadedMemos;
                    this.saveMemosToLocalStorage(); // 로드된 메모를 로컬 스토리지에 저장합니다.
                    this.renderCalendar();
                    alert('메모를 파일에서 성공적으로 불러왔습니다.');
                } catch (e) {
                    console.error('파일에서 메모 로드 중 오류 발생:', e);
                    alert('파일을 불러오는 중 오류가 발생했습니다. 올바른 JSON 파일인지 확인해주세요.');
                }
            }
        };
        input.click();
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new Calendar();
});
