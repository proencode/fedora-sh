/* 3주 달력 cusr15.1107-00. popup.js */

class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memoMode = 'short'; // 'short' or 'detail'
        this.memos = JSON.parse(localStorage.getItem('calendarMemos')) || {};
        
        this.initializeElements();
        this.attachEventListeners();
        this.renderCalendar();
    }

    initializeElements() {
        this.yearElement = document.getElementById('year');
        this.calendarGrid = document.getElementById('calendarGrid');
        this.prevWeekBtn = document.getElementById('prevWeek');
        this.nextWeekBtn = document.getElementById('nextWeek');
        this.memoModeBtn = document.getElementById('memoMode');
        this.saveMemoBtn = document.getElementById('saveMemo');
        this.loadMemoBtn = document.getElementById('loadMemo');
        this.memoModal = document.getElementById('memoModal');
        this.memoText = document.getElementById('memoText');
        this.saveMemoModalBtn = document.getElementById('saveMemoBtn');
        this.cancelMemoModalBtn = document.getElementById('cancelMemoBtn');
        this.modeText = document.querySelector('.mode-text');
    }

    attachEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => this.navigateWeek(-1));
        this.nextWeekBtn.addEventListener('click', () => this.navigateWeek(1));
        this.memoModeBtn.addEventListener('click', () => this.toggleMemoMode());
        this.saveMemoBtn.addEventListener('click', () => this.saveMemosToFile());
        this.loadMemoBtn.addEventListener('click', () => this.loadMemosFromFile());
        this.saveMemoModalBtn.addEventListener('click', () => this.saveMemo());
        this.cancelMemoModalBtn.addEventListener('click', () => this.closeModal());
    }

    navigateWeek(direction) {
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar();
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === 'short' ? 'detail' : 'short';
        const modeText = this.modeText;
        if (this.memoMode === 'short') {
            modeText.textContent = '단축';
            modeText.previousSibling.textContent = '메모: ';
            modeText.nextSibling.textContent = '/상세';
        } else {
            modeText.textContent = '상세';
            modeText.previousSibling.textContent = '메모: 단축/';
            modeText.nextSibling.textContent = '';
        }
        this.renderCalendar();
    }

    getWeekDates() {
        const dates = [];
        const startDate = new Date(this.currentDate);
        startDate.setDate(startDate.getDate() - startDate.getDay());

        for (let i = 0; i < 21; i++) {
            const date = new Date(startDate);
            date.setDate(date.getDate() + i);
            dates.push(date);
        }

        return dates;
    }

    formatDate(date) {
        const day = date.getDate();
        const month = date.getMonth() + 1;
        const weekdays = ['일', '월', '화', '수', '목', '금', '토'];
        const weekday = weekdays[date.getDay()];

        if (date.getDay() === 0 || day === 1) {
            return `${month} / ${day} (${weekday})`;
        }
        return `${day} (${weekday})`;
    }

    formatMemo(memo) {
        if (!memo) return '';
        if (this.memoMode === 'short' && memo.length > 20) {
            return memo.substring(0, 20) + '...';
        }
        return memo;
    }

    isToday(date) {
        const today = new Date();
        return date.getDate() === today.getDate() &&
               date.getMonth() === today.getMonth() &&
               date.getFullYear() === today.getFullYear();
    }

    renderCalendar() {
        this.yearElement.textContent = `${this.currentDate.getFullYear()} 년`;
        this.calendarGrid.innerHTML = '';

        const dates = this.getWeekDates();
        dates.forEach(date => {
            const cell = document.createElement('div');
            cell.className = 'calendar-cell';
            if (this.isToday(date)) {
                cell.classList.add('today');
            }

            const dateArea = document.createElement('div');
            dateArea.className = 'date-area';
            dateArea.textContent = this.formatDate(date);

            const memoArea = document.createElement('div');
            memoArea.className = 'memo-area';
            if (this.memoMode === 'detail') {
                memoArea.classList.add('detail-mode');
            }
            const dateKey = date.toISOString().split('T')[0];
            memoArea.textContent = this.formatMemo(this.memos[dateKey]);

            cell.appendChild(dateArea);
            cell.appendChild(memoArea);

            cell.addEventListener('click', () => this.openMemoModal(date));
            this.calendarGrid.appendChild(cell);
        });
    }

    openMemoModal(date) {
        const dateKey = date.toISOString().split('T')[0];
        this.memoText.value = this.memos[dateKey] || '';
        this.memoModal.style.display = 'block';
        this.memoModal.dataset.date = dateKey;
    }

    closeModal() {
        this.memoModal.style.display = 'none';
        this.memoText.value = '';
        delete this.memoModal.dataset.date;
    }

    saveMemo() {
        const dateKey = this.memoModal.dataset.date;
        if (dateKey) {
            this.memos[dateKey] = this.memoText.value;
            localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
            this.renderCalendar();
        }
        this.closeModal();
    }

    saveMemosToFile() {
        const blob = new Blob([JSON.stringify(this.memos)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'calendar_memos.json';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }

    loadMemosFromFile() {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = '.json';
        input.onchange = (e) => {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (event) => {
                    try {
                        this.memos = JSON.parse(event.target.result);
                        localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
                        this.renderCalendar();
                    } catch (error) {
                        alert('잘못된 파일 형식입니다.');
                    }
                };
                reader.readAsText(file);
            }
        };
        input.click();
    }
}

// 달력 초기화
document.addEventListener('DOMContentLoaded', () => {
    new Calendar();
}); 