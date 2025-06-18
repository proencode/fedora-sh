/* 3주 달력 cusr16.1230-04. popup.js */

class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memoMode = 'short'; // 'short' or 'full'
        this.memos = this.loadMemosFromLocalStorage();

        this.calendarGrid = document.getElementById('calendarGrid');
        this.yearDisplay = document.querySelector('.year-display');
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

        this.selectedDateCell = null; // To store the cell currently being edited

        this.setupEventListeners();
        this.renderCalendar();
    }

    setupEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => this.navigateWeeks(-1));
        this.nextWeekBtn.addEventListener('click', () => this.navigateWeeks(1));
        this.memoModeBtn.addEventListener('click', () => this.toggleMemoMode());
        this.saveMemoBtn.addEventListener('click', () => this.saveMemosToFile());
        this.loadMemoBtn.addEventListener('click', () => this.loadMemosFromFile());

        this.closeModalBtn.addEventListener('click', () => this.closeMemoModal());
        this.saveModalMemoBtn.addEventListener('click', () => this.saveMemoToCell());

        // Close modal when clicking outside
        window.addEventListener('click', (event) => {
            if (event.target === this.memoModal) {
                this.closeMemoModal();
            }
        });
    }

    renderCalendar() {
        this.calendarGrid.innerHTML = '';
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Normalize today's date for comparison

        // Set the current date to the start of its week (Sunday)
        const startOfWeek = new Date(this.currentDate);
        startOfWeek.setDate(this.currentDate.getDate() - this.currentDate.getDay()); // Go back to Sunday

        this.yearDisplay.textContent = `${this.currentDate.getFullYear()} 년`;

        for (let i = 0; i < 3 * 7; i++) { // 3 weeks * 7 days
            const date = new Date(startOfWeek);
            date.setDate(startOfWeek.getDate() + i);

            const cell = document.createElement('div');
            cell.classList.add('calendar-cell');
            if (this.memoMode === 'full') {
                cell.classList.add('full-memo-mode');
            }

            const dateArea = document.createElement('div');
            dateArea.classList.add('date-area');

            const memoArea = document.createElement('div');
            memoArea.classList.add('memo-area');

            const dayOfWeek = date.getDay(); // 0 for Sunday, 6 for Saturday
            let dateString = '';
            let dayClass = '';

            // Day of week in Korean
            const daysOfWeekKorean = ['일', '월', '화', '수', '목', '금', '토'];
            const dayText = daysOfWeekKorean[dayOfWeek];

            if (dayOfWeek === 0) { // Sunday
                dayClass = 'sunday';
                dateString = `${date.getMonth() + 1} / ${date.getDate()} (${dayText})`;
            } else if (dayOfWeek === 6) { // Saturday
                dayClass = 'saturday';
                dateString = `${date.getDate()} (${dayText})`;
            } else { // Weekdays
                dayClass = 'weekday';
                dateString = `${date.getDate()} (${dayText})`;
            }

            // Check if month changes or if it's the first day of the 3-week period
            if (i === 0 || date.getDate() === 1) {
                dateString = `${date.getMonth() + 1} / ${date.getDate()} (${dayText})`;
            }

            dateArea.textContent = dateString;
            dateArea.classList.add(dayClass);

            // Highlight today's date
            if (date.toDateString() === today.toDateString()) {
                cell.classList.add('today');
            }

            // Load memo for the date
            const dateKey = this.getDateKey(date);
            const memo = this.memos[dateKey] || '';

            if (this.memoMode === 'short') {
                memoArea.textContent = memo.length > 20 ? memo.substring(0, 20) + '...' : memo;
            } else {
                memoArea.textContent = memo;
            }

            cell.dataset.date = dateKey; // Store date key for memo retrieval
            cell.appendChild(dateArea);
            cell.appendChild(memoArea);
            this.calendarGrid.appendChild(cell);

            cell.addEventListener('click', () => this.openMemoModal(date, memo, cell));
        }
    }

    navigateWeeks(direction) {
        // 기존: this.currentDate.setDate(this.currentDate.getDate() + (direction * 21)); // 3주씩 이동
        // 변경: 1주씩 이동
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar();
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === 'short' ? 'full' : 'short';
        this.updateMemoModeButton();
        this.renderCalendar();
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
        this.memoModal.style.display = 'flex'; // Use flex to center
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
            this.renderCalendar(); // Re-render to update the memo display
            this.closeMemoModal();
        }
    }

    saveMemosToLocalStorage() {
        try {
            localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
            console.log('Memos saved to localStorage.');
        } catch (e) {
            console.error('Error saving memos to localStorage:', e);
            alert('메모 저장 중 오류가 발생했습니다.');
        }
    }

    loadMemosFromLocalStorage() {
        try {
            const storedMemos = localStorage.getItem('calendarMemos');
            return storedMemos ? JSON.parse(storedMemos) : {};
        } catch (e) {
            console.error('Error loading memos from localStorage:', e);
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
                    // Merge loaded memos with existing ones, or overwrite
                    // For this example, we'll overwrite. For merging, you'd iterate and assign.
                    this.memos = loadedMemos;
                    this.saveMemosToLocalStorage(); // Save loaded memos to local storage
                    this.renderCalendar();
                    alert('메모를 파일에서 성공적으로 불러왔습니다.');
                } catch (e) {
                    console.error('Error loading memos from file:', e);
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
