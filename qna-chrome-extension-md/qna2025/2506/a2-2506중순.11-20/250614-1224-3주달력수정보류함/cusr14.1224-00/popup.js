/* 3주 달력 cusr14.1224-00. popup.js */

class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memoMode = '단축';
        this.memos = JSON.parse(localStorage.getItem('calendarMemos')) || {};
        this.selectedDate = null;
        
        this.initializeElements();
        this.attachEventListeners();
        this.renderCalendar();
    }

    initializeElements() {
        this.yearDisplay = document.getElementById('yearDisplay');
        this.calendarGrid = document.getElementById('calendarGrid');
        this.prevWeekBtn = document.getElementById('prevWeek');
        this.nextWeekBtn = document.getElementById('nextWeek');
        this.memoModeBtn = document.getElementById('memoMode');
        this.memoModeText = document.getElementById('memoModeText');
        this.saveMemoBtn = document.getElementById('saveMemo');
        this.loadMemoBtn = document.getElementById('loadMemo');
        this.memoModal = document.getElementById('memoModal');
        this.memoText = document.getElementById('memoText');
        this.saveMemoModalBtn = document.getElementById('saveMemoBtn');
        this.closeModalBtn = document.getElementById('closeModal');
    }

    attachEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => this.navigateWeek(-1));
        this.nextWeekBtn.addEventListener('click', () => this.navigateWeek(1));
        this.memoModeBtn.addEventListener('click', () => this.toggleMemoMode());
        this.saveMemoBtn.addEventListener('click', () => this.saveToFile());
        this.loadMemoBtn.addEventListener('click', () => this.loadFromFile());
        this.saveMemoModalBtn.addEventListener('click', () => this.saveMemo());
        this.closeModalBtn.addEventListener('click', () => this.closeModal());
    }

    navigateWeek(direction) {
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar();
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === '단축' ? '상세' : '단축';
        this.memoModeText.textContent = this.memoMode;
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
        const days = ['일', '월', '화', '수', '목', '금', '토'];
        const month = date.getMonth() + 1;
        const day = date.getDate();
        const dayOfWeek = days[date.getDay()];

        if (date.getDay() === 0 || day === 1) {
            return `${month} / ${day} (${dayOfWeek})`;
        }
        return `${day} (${dayOfWeek})`;
    }

    isToday(date) {
        const today = new Date();
        return date.getDate() === today.getDate() &&
               date.getMonth() === today.getMonth() &&
               date.getFullYear() === today.getFullYear();
    }

    getMemoKey(date) {
        return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
    }

    formatMemo(memo) {
        if (!memo) return '';
        if (this.memoMode === '단축' && memo.length > 20) {
            return memo.substring(0, 20) + '...';
        }
        return memo;
    }

    renderCalendar() {
        this.yearDisplay.textContent = `${this.currentDate.getFullYear()} 년`;
        this.calendarGrid.innerHTML = '';

        const dates = this.getWeekDates();
        dates.forEach(date => {
            const cell = document.createElement('div');
            cell.className = 'calendar-cell';
            if (this.isToday(date)) {
                cell.classList.add('today');
            }

            const dateDisplay = document.createElement('div');
            dateDisplay.className = 'date-display';
            dateDisplay.textContent = this.formatDate(date);

            const memoDisplay = document.createElement('div');
            memoDisplay.className = 'memo-display';
            const memoKey = this.getMemoKey(date);
            memoDisplay.textContent = this.formatMemo(this.memos[memoKey]);

            cell.appendChild(dateDisplay);
            cell.appendChild(memoDisplay);

            cell.addEventListener('click', () => this.openMemoModal(date));
            this.calendarGrid.appendChild(cell);
        });
    }

    openMemoModal(date) {
        this.selectedDate = date;
        const memoKey = this.getMemoKey(date);
        this.memoText.value = this.memos[memoKey] || '';
        this.memoModal.style.display = 'block';
    }

    closeModal() {
        this.memoModal.style.display = 'none';
        this.selectedDate = null;
    }

    saveMemo() {
        if (!this.selectedDate) return;
        const memoKey = this.getMemoKey(this.selectedDate);
        this.memos[memoKey] = this.memoText.value;
        localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
        this.renderCalendar();
        this.closeModal();
    }

    saveToFile() {
        const dataStr = JSON.stringify(this.memos);
        const dataUri = 'data:application/json;charset=utf-8,'+ encodeURIComponent(dataStr);
        const exportFileDefaultName = 'calendar_memos.json';

        const linkElement = document.createElement('a');
        linkElement.setAttribute('href', dataUri);
        linkElement.setAttribute('download', exportFileDefaultName);
        linkElement.click();
    }

    loadFromFile() {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = '.json';
        
        input.onchange = e => {
            const file = e.target.files[0];
            const reader = new FileReader();
            
            reader.onload = event => {
                try {
                    this.memos = JSON.parse(event.target.result);
                    localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
                    this.renderCalendar();
                } catch (error) {
                    alert('잘못된 파일 형식입니다.');
                }
            };
            
            reader.readAsText(file);
        };
        
        input.click();
    }
}

// 달력 초기화
document.addEventListener('DOMContentLoaded', () => {
    new Calendar();
}); 