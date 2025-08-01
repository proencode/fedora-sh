/* cusr12.1039-02 script.js */
class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memoMode = 'short'; // 'short' or 'detail'
        this.memos = JSON.parse(localStorage.getItem('memos')) || {};
        
        this.initializeElements();
        this.attachEventListeners();
        this.renderCalendar();
        this.updateMemoModeDisplay();
    }

    initializeElements() {
        this.calendarElement = document.getElementById('calendar');
        this.yearDisplay = document.getElementById('yearDisplay');
        this.modal = document.getElementById('memoModal');
        this.modalDate = document.getElementById('modalDate');
        this.memoText = document.getElementById('memoText');
        this.fileInput = document.getElementById('fileInput');
        this.memoModeText = document.getElementById('memoModeText');
        this.memoModeText2 = document.getElementById('memoModeText2');
    }

    attachEventListeners() {
        document.getElementById('prevWeek').addEventListener('click', () => this.navigateWeek(-1));
        document.getElementById('nextWeek').addEventListener('click', () => this.navigateWeek(1));
        document.getElementById('toggleMemoMode').addEventListener('click', () => this.toggleMemoMode());
        document.getElementById('saveMemo').addEventListener('click', () => this.saveToFile());
        document.getElementById('loadMemo').addEventListener('click', () => this.fileInput.click());
        document.getElementById('saveMemoBtn').addEventListener('click', () => this.saveMemo());
        document.getElementById('closeModalBtn').addEventListener('click', () => this.closeModal());
        this.fileInput.addEventListener('change', (e) => this.loadFromFile(e));
    }

    navigateWeek(direction) {
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar();
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === 'short' ? 'detail' : 'short';
        this.updateMemoModeDisplay();
        this.renderCalendar();
    }

    updateMemoModeDisplay() {
        if (this.memoMode === 'short') {
            this.memoModeText.classList.add('active-mode');
            this.memoModeText2.classList.remove('active-mode');
        } else {
            this.memoModeText.classList.remove('active-mode');
            this.memoModeText2.classList.add('active-mode');
        }
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
        const isSunday = date.getDay() === 0;
        const isMonthChange = date.getDate() === 1;
        
        if (isSunday || isMonthChange) {
            return `${date.getMonth() + 1} / ${date.getDate()} (${days[date.getDay()]})`;
        }
        return `${date.getDate()} (${days[date.getDay()]})`;
    }

    isToday(date) {
        const today = new Date();
        return date.getDate() === today.getDate() &&
               date.getMonth() === today.getMonth() &&
               date.getFullYear() === today.getFullYear();
    }

    renderCalendar() {
        this.calendarElement.innerHTML = '';
        const dates = this.getWeekDates();
        
        dates.forEach(date => {
            const cell = document.createElement('div');
            cell.className = 'date-cell';
            if (this.isToday(date)) {
                cell.classList.add('today');
            }

            const dateDisplay = document.createElement('div');
            dateDisplay.className = 'date';
            dateDisplay.textContent = this.formatDate(date);
            cell.appendChild(dateDisplay);

            const memo = document.createElement('div');
            memo.className = 'memo';
            const dateKey = date.toISOString().split('T')[0];
            const memoText = this.memos[dateKey] || '';
            
            if (this.memoMode === 'short' && memoText.length > 20) {
                memo.textContent = memoText.substring(0, 20) + '...';
            } else {
                memo.textContent = memoText;
            }
            
            cell.appendChild(memo);
            cell.addEventListener('click', () => this.openModal(date));
            this.calendarElement.appendChild(cell);
        });

        this.yearDisplay.textContent = `${this.currentDate.getFullYear()} 년`;
    }

    openModal(date) {
        this.modal.style.display = 'block';
        this.modalDate.textContent = this.formatDate(date);
        const dateKey = date.toISOString().split('T')[0];
        this.memoText.value = this.memos[dateKey] || '';
        this.currentEditingDate = dateKey;
    }

    closeModal() {
        this.modal.style.display = 'none';
        this.currentEditingDate = null;
    }

    saveMemo() {
        if (this.currentEditingDate) {
            this.memos[this.currentEditingDate] = this.memoText.value;
            localStorage.setItem('memos', JSON.stringify(this.memos));
            this.closeModal();
            this.renderCalendar();
        }
    }

    saveToFile() {
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

    loadFromFile(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                try {
                    this.memos = JSON.parse(e.target.result);
                    localStorage.setItem('memos', JSON.stringify(this.memos));
                    this.renderCalendar();
                } catch (error) {
                    alert('파일 형식이 올바르지 않습니다.');
                }
            };
            reader.readAsText(file);
        }
    }
}

// 달력 초기화
document.addEventListener('DOMContentLoaded', () => {
    new Calendar();
});
