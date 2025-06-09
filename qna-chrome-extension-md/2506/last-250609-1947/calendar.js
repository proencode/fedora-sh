class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memos = {};
        this.isSimpleMemo = false;
        this.initializeElements();
        this.loadMemos();
        this.renderCalendar();
        this.attachEventListeners();
    }

    initializeElements() {
        this.yearDisplay = document.getElementById('yearDisplay');
        this.calendarGrid = document.getElementById('calendarGrid');
        this.prevWeekBtn = document.getElementById('prevWeek');
        this.nextWeekBtn = document.getElementById('nextWeek');
        this.toggleMemoBtn = document.getElementById('toggleMemo');
        this.memoModal = document.getElementById('memoModal');
        this.modalDate = document.getElementById('modalDate');
        this.memoInput = document.getElementById('memoInput');
        this.closeModal = document.getElementById('closeModal');
        this.saveMemo = document.getElementById('saveMemo');
    }

    async loadMemos() {
        const result = await chrome.storage.sync.get('memos');
        this.memos = result.memos || {};
    }

    async saveMemos() {
        await chrome.storage.sync.set({ memos: this.memos });
    }

    getWeekDates(date) {
        const weekDates = [];
        const currentDay = date.getDay();
        const diff = date.getDate() - currentDay;
        
        for (let i = -7; i < 14; i++) {
            const newDate = new Date(date.getFullYear(), date.getMonth(), diff + i);
            weekDates.push(newDate);
        }
        
        return weekDates;
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

    isToday(date) {
        const today = new Date();
        return date.getDate() === today.getDate() &&
               date.getMonth() === today.getMonth() &&
               date.getFullYear() === today.getFullYear();
    }

    formatMemo(memo) {
        if (!memo) return '';
        if (this.isSimpleMemo && memo.length > 20) {
            return memo.substring(0, 20) + '...';
        }
        return memo;
    }

    renderCalendar() {
        this.yearDisplay.textContent = `${this.currentDate.getFullYear()} 년`;
        this.calendarGrid.innerHTML = '';

        const weekDates = this.getWeekDates(this.currentDate);
        
        // 날짜 행
        for (let i = 0; i < 21; i += 7) {
            const dateRow = document.createElement('div');
            dateRow.className = 'calendar-row';
            
            for (let j = 0; j < 7; j++) {
                const date = weekDates[i + j];
                const cell = document.createElement('div');
                cell.className = 'calendar-cell date-cell';
                if (this.isToday(date)) {
                    cell.classList.add('today');
                }
                cell.textContent = this.formatDate(date);
                cell.dataset.date = date.toISOString();
                cell.addEventListener('click', () => this.openMemoModal(date));
                dateRow.appendChild(cell);
            }
            
            this.calendarGrid.appendChild(dateRow);

            // 메모 행
            const memoRow = document.createElement('div');
            memoRow.className = 'calendar-row';
            
            for (let j = 0; j < 7; j++) {
                const date = weekDates[i + j];
                const cell = document.createElement('div');
                cell.className = 'calendar-cell memo-cell';
                const memo = this.memos[date.toISOString()] || '';
                cell.textContent = this.formatMemo(memo);
                memoRow.appendChild(cell);
            }
            
            this.calendarGrid.appendChild(memoRow);
        }
    }

    openMemoModal(date) {
        this.modalDate.textContent = this.formatDate(date);
        this.memoInput.value = this.memos[date.toISOString()] || '';
        this.memoModal.style.display = 'block';
        this.currentEditingDate = date;
    }

    closeMemoModal() {
        this.memoModal.style.display = 'none';
        this.currentEditingDate = null;
    }

    async saveMemoContent() {
        if (this.currentEditingDate) {
            const dateStr = this.currentEditingDate.toISOString();
            this.memos[dateStr] = this.memoInput.value;
            await this.saveMemos();
            this.renderCalendar();
            this.closeMemoModal();
        }
    }

    attachEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => {
            this.currentDate.setDate(this.currentDate.getDate() - 7);
            this.renderCalendar();
        });

        this.nextWeekBtn.addEventListener('click', () => {
            this.currentDate.setDate(this.currentDate.getDate() + 7);
            this.renderCalendar();
        });

        this.toggleMemoBtn.addEventListener('click', () => {
            this.isSimpleMemo = !this.isSimpleMemo;
            this.toggleMemoBtn.textContent = this.isSimpleMemo ? '전체 메모' : '간편 메모';
            this.renderCalendar();
        });

        this.closeModal.addEventListener('click', () => this.closeMemoModal());
        this.saveMemo.addEventListener('click', () => this.saveMemoContent());

        window.addEventListener('click', (e) => {
            if (e.target === this.memoModal) {
                this.closeMemoModal();
            }
        });
    }
}

// 달력 초기화
document.addEventListener('DOMContentLoaded', () => {
    new Calendar();
}); 