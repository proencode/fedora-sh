/* 3주 달력 cusr18.1254-00. popup.js */

class Calendar {
    constructor() {
        this.currentDate = new Date();
        this.memoMode = 'short'; // 'short' or 'detail'
        this.memos = {};
        this.selectedDate = null;
        this.currentFileName = '';
        
        this.initializeElements();
        this.attachEventListeners();
        this.loadMemos();
        this.renderCalendar();
        this.updateMemoModeButton();
        this.loadLatestFile();
    }

    initializeElements() {
        this.calendarGrid = document.getElementById('calendarGrid');
        this.prevWeekBtn = document.getElementById('prevWeek');
        this.nextWeekBtn = document.getElementById('nextWeek');
        this.toggleMemoModeBtn = document.getElementById('toggleMemoMode');
        this.saveMemoBtn = document.getElementById('saveMemo');
        this.loadMemoBtn = document.getElementById('loadMemo');
        this.memoModal = document.getElementById('memoModal');
        this.memoInput = document.getElementById('memoInput');
        this.modalSaveBtn = document.getElementById('saveMemoBtn');
        this.modalCancelBtn = document.getElementById('cancelMemoBtn');
        this.fileNameDisplay = document.getElementById('fileNameDisplay');
    }

    attachEventListeners() {
        this.prevWeekBtn.addEventListener('click', () => this.navigateWeek(-1));
        this.nextWeekBtn.addEventListener('click', () => this.navigateWeek(1));
        this.toggleMemoModeBtn.addEventListener('click', () => this.toggleMemoMode());
        this.saveMemoBtn.addEventListener('click', () => this.saveMemosToFile());
        this.loadMemoBtn.addEventListener('click', () => this.loadMemosFromFile());
        this.modalSaveBtn.addEventListener('click', () => this.saveMemoContent());
        this.modalCancelBtn.addEventListener('click', () => this.closeModal());
    }

    navigateWeek(direction) {
        this.currentDate.setDate(this.currentDate.getDate() + (direction * 7));
        this.renderCalendar();
    }

    toggleMemoMode() {
        this.memoMode = this.memoMode === 'short' ? 'detail' : 'short';
        this.updateMemoModeButton();
        this.renderCalendar();
    }

    updateMemoModeButton() {
        const button = this.toggleMemoModeBtn;
        const shortMode = button.querySelector('.short-mode');
        const detailMode = button.querySelector('.detail-mode');

        if (this.memoMode === 'short') {
            shortMode.style.display = 'inline';
            detailMode.style.display = 'none';
        } else {
            shortMode.style.display = 'none';
            detailMode.style.display = 'inline';
        }
    }

    renderCalendar() {
        this.calendarGrid.innerHTML = '';
        const startDate = new Date(this.currentDate);
        startDate.setDate(startDate.getDate() - startDate.getDay());

        for (let week = 0; week < 3; week++) {
            for (let day = 0; day < 7; day++) {
                const currentDate = new Date(startDate);
                currentDate.setDate(startDate.getDate() + (week * 7) + day);
                
                const cell = this.createCalendarCell(currentDate);
                this.calendarGrid.appendChild(cell);
            }
        }
    }

    createCalendarCell(date) {
        const cell = document.createElement('div');
        cell.className = 'calendar-cell';
        
        const dateStr = this.formatDate(date);
        const dateDisplay = document.createElement('div');
        dateDisplay.className = `date-display ${this.getDayClass(date)}`;
        dateDisplay.textContent = dateStr;
        
        const memoContent = document.createElement('div');
        memoContent.className = `memo-content ${this.memoMode}`;
        const memo = this.memos[this.getDateKey(date)] || '';
        
        if (this.memoMode === 'short' && memo.length > 30) {
            memoContent.textContent = memo.substring(0, 30) + '...';
        } else {
            memoContent.textContent = memo;
        }

        cell.appendChild(dateDisplay);
        cell.appendChild(memoContent);

        if (this.isToday(date)) {
            cell.classList.add('today');
        }

        cell.addEventListener('click', () => this.openMemoModal(date));
        
        return cell;
    }

    formatDate(date) {
        const month = date.getMonth() + 1;
        const day = date.getDate();
        const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'][date.getDay()];
        
        if (day === 1 || date.getDay() === 0) {
            return `${month} / ${day} (${dayOfWeek})`;
        }
        return `${day} (${dayOfWeek})`;
    }

    getDayClass(date) {
        const day = date.getDay();
        if (day === 0) return 'sunday';
        if (day === 6) return 'saturday';
        return 'weekday';
    }

    isToday(date) {
        const today = new Date();
        return date.getDate() === today.getDate() &&
               date.getMonth() === today.getMonth() &&
               date.getFullYear() === today.getFullYear();
    }

    getDateKey(date) {
        return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
    }

    openMemoModal(date) {
        this.selectedDate = date;
        this.memoInput.value = this.memos[this.getDateKey(date)] || '';
        this.memoModal.style.display = 'block';
    }

    closeModal() {
        this.memoModal.style.display = 'none';
        this.selectedDate = null;
    }

    saveMemoContent() {
        if (this.selectedDate) {
            const dateKey = this.getDateKey(this.selectedDate);
            this.memos[dateKey] = this.memoInput.value;
            this.saveMemos();
            this.renderCalendar();
            
            // 현재 파일이 있으면 자동 저장
            if (this.currentFileName) {
                this.saveMemosToFile(this.currentFileName, false);
            }
        }
        this.closeModal();
    }

    saveMemos() {
        localStorage.setItem('calendarMemos', JSON.stringify(this.memos));
    }

    loadMemos() {
        const savedMemos = localStorage.getItem('calendarMemos');
        if (savedMemos) {
            this.memos = JSON.parse(savedMemos);
        }
    }

    saveMemosToFile(fileName = null, showPrompt = true) {
        if (!fileName && showPrompt) {
            const defaultFileName = 'calendar_memos.json';
            fileName = prompt('저장할 파일 이름을 입력하세요:', defaultFileName);
        }
        
        if (fileName) {
            const blob = new Blob([JSON.stringify(this.memos)], { type: 'application/json' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = fileName.endsWith('.json') ? fileName : `${fileName}.json`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
            
            this.currentFileName = fileName;
            this.updateFileNameDisplay();
        }
    }

    async loadLatestFile() {
        try {
            const response = await fetch('/api/latest-file');
            const data = await response.json();
            if (data.fileName) {
                this.loadMemosFromFile(data.fileName);
            }
        } catch (error) {
            console.log('최근 파일 로드 실패:', error);
        }
    }

    loadMemosFromFile(fileName = null) {
        if (fileName) {
            // 서버에서 파일 로드
            fetch(`/api/load-file/${fileName}`)
                .then(response => response.json())
                .then(data => {
                    this.memos = data;
                    this.saveMemos();
                    this.renderCalendar();
                    this.currentFileName = fileName;
                    this.updateFileNameDisplay();
                })
                .catch(error => {
                    console.error('파일 로드 실패:', error);
                    alert('파일을 불러오는데 실패했습니다.');
                });
        } else {
            // 파일 선택 다이얼로그 표시
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
                            this.saveMemos();
                            this.renderCalendar();
                            this.currentFileName = file.name;
                            this.updateFileNameDisplay();
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

    updateFileNameDisplay() {
        if (this.currentFileName) {
            this.fileNameDisplay.textContent = this.currentFileName;
        } else {
            this.fileNameDisplay.textContent = '';
        }
    }
}

// 달력 초기화
document.addEventListener('DOMContentLoaded', () => {
    new Calendar();
});
