/* 3주 달력 cusr15.1340-01. popup.js */

class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memoMode = 'short'; // 'short' or 'detail'
        this.memos = JSON.parse(localStorage.getItem('calendarMemos')) || {};
        this.selectedDate = null;
        
        this.initializeElements();
        this.attachEventListeners();
        this.renderCalendar();
    }

    initializeElements() {
        this.yearDisplay = document.querySelector('.year-display');
        this.calendarBody = document.getElementById('calendarBody');
        this.prevWeekBtn = document.getElementById('prevWeek');
        this.nextWeekBtn = document.getElementById('nextWeek');
        this.memoModeBtn = document.getElementById('memoMode');
        this.saveMemoBtn = document.getElementById('saveMemo');
        this.loadMemoBtn = document.getElementById('loadMemo');
        this.memoModal = document.getElementById('memoModal');
        this.memoText = document.getElementById('memoText');
        this.saveMemoModalBtn = document.getElementById('saveMemoBtn');
        this.cancelMemoModalBtn = document.getElementById('cancelMemoBtn');
    }

    attachEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => this.navigateWeek(-1));
        this.nextWeekBtn.addEventListener('click', () => this.navigateWeek(1));
        this.memoModeBtn.addEventListener('click', () => this.toggleMemoMode());
        this.saveMemoBtn.addEventListener('click', () => this.saveToFile());
        this.loadMemoBtn.addEventListener('click', () => this.loadFromFile());
        this.saveMemoModalBtn.addEventListener('click', () => this.saveMemo());
        this.cancelMemoModalBtn.addEventListener('click', () => this.closeModal());
    }

    navigateWeek(direction) {
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar();
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === 'short' ? 'detail' : 'short';
        const modeText = document.querySelector('.mode-text');
        modeText.textContent = this.memoMode === 'short' ? '단축' : '상세';
        this.renderCalendar();
    }

    getWeekDates(date) {
        const dates = [];
        const startDate = new Date(date);
        startDate.setDate(startDate.getDate() - startDate.getDay());
        
        for (let i = 0; i < 21; i++) {
            const currentDate = new Date(startDate);
            currentDate.setDate(startDate.getDate() + i);
            dates.push(currentDate);
        }
        return dates;
    }

    formatDate(date) {
        const day = date.getDate();
        const month = date.getMonth() + 1;
        const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'][date.getDay()];
        
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

    formatMemo(memo) {
        if (!memo) return '';
        if (this.memoMode === 'short' && memo.length > 20) {
            return memo.substring(0, 20) + '...';
        }
        return memo;
    }

    renderCalendar() {
        this.yearDisplay.textContent = `${this.currentDate.getFullYear()} 년`;
        this.calendarBody.innerHTML = '';
        
        const dates = this.getWeekDates(this.currentDate);
        let row = document.createElement('tr');
        
        dates.forEach((date, index) => {
            if (index > 0 && index % 7 === 0) {
                this.calendarBody.appendChild(row);
                row = document.createElement('tr');
            }
            
            const cell = document.createElement('td');
            cell.className = 'calendar-cell';
            if (this.isToday(date)) {
                cell.classList.add('today');
            }
            
            const dateDisplay = document.createElement('div');
            dateDisplay.className = 'date-display';
            dateDisplay.textContent = this.formatDate(date);
            
            const memoDisplay = document.createElement('div');
            memoDisplay.className = 'memo-display';
            if (this.memoMode === 'detail') {
                memoDisplay.classList.add('detail-mode');
            }
            const dateKey = date.toISOString().split('T')[0];
            memoDisplay.textContent = this.formatMemo(this.memos[dateKey]);
            
            cell.appendChild(dateDisplay);
            cell.appendChild(memoDisplay);
            
            cell.addEventListener('click', () => this.openMemoModal(date));
            row.appendChild(cell);
        });
        
        this.calendarBody.appendChild(row);
    }

    openMemoModal(date) {
        this.selectedDate = date;
        const dateKey = date.toISOString().split('T')[0];
        this.memoText.value = this.memos[dateKey] || '';
        this.memoModal.style.display = 'block';
    }

    closeModal() {
        this.memoModal.style.display = 'none';
        this.selectedDate = null;
    }

    saveMemo() {
        if (this.selectedDate) {
            const dateKey = this.selectedDate.toISOString().split('T')[0];
            this.memos[dateKey] = this.memoText.value;
            localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
            this.renderCalendar();
            this.closeModal();
        }
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
                    const loadedMemos = JSON.parse(event.target.result);
                    this.memos = loadedMemos;
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