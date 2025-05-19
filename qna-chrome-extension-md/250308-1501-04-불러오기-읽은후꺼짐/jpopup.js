// gemini08.1501-04. jpopup.js -->
document.addEventListener('DOMContentLoaded', function() {
    const saveButton = document.getElementById('save');
    const loadButton = document.getElementById('load');

    // 이벤트 위임
    document.body.addEventListener('click', function(event) {
        const target = event.target;
        const chapterContainer = target.closest('.chapter-container');

        if (target.classList.contains('increase')) {
            increaseChapterNumber(chapterContainer);
        } else if (target.classList.contains('decrease')) {
            decreaseChapterNumber(chapterContainer);
        } else if (target.classList.contains('add-above')) {
            addChapterAbove(chapterContainer);
        } else if (target.classList.contains('add-below')) {
            addChapterBelow(chapterContainer);
        }
    });

    // 숫자 증감 기능
    function increaseChapterNumber(container) {
        const chapterNumber = container.querySelector('.chapter-number');
        chapterNumber.value = parseInt(chapterNumber.value) + 1;
    }

    function decreaseChapterNumber(container) {
        const chapterNumber = container.querySelector('.chapter-number');
        chapterNumber.value = parseInt(chapterNumber.value) - 1;
    }

    // 챕터 추가 기능 (^, v)
    function addChapterAbove(container) {
        const newChapter = createChapter();
        container.parentNode.insertBefore(newChapter, container);
    }

    function addChapterBelow(container) {
        const newChapter = createChapter();
        container.parentNode.insertBefore(newChapter, container.nextSibling);
    }

    // 새로운 챕터 생성 함수
    function createChapter() {
        const newChapter = document.createElement('div');
        newChapter.classList.add('chapter-container');
        newChapter.innerHTML = `
            <input type="number" class="chapter-number" value="1">
            <button class="increase">+</button>
            <button class="decrease">-</button>
            <button class="add-above">^</button>
            <button class="add-below">v</button>
            <br>
            <textarea class="summary"></textarea>
            <textarea class="details"></textarea>
        `;
        return newChapter;
    }

    // 저장 기능
    saveButton.addEventListener('click', function() {
        const chapters = [];
        document.querySelectorAll('.chapter-container').forEach(container => {
            const chapter = {
                chapter: container.querySelector('.chapter-number').value,
                summary: container.querySelector('.summary').value,
                details: container.querySelector('.details').value
            };
            chapters.push(chapter);
        });
        const filename = 'markdown_notes.json';
        saveFile(JSON.stringify(chapters), filename);
    });

    // 불러오기 기능
    loadButton.addEventListener('click', function() {
        loadFile(function(content) {
            const chapters = JSON.parse(content);
            const container = document.querySelector('.chapter-container').parentNode;
            container.innerHTML = ''; // 기존 챕터 삭제
            chapters.forEach(chapter => {
                const newChapter = createChapter();
                newChapter.querySelector('.chapter-number').value = chapter.chapter;
                newChapter.querySelector('.summary').value = chapter.summary;
                newChapter.querySelector('.details').value = chapter.details;
                container.appendChild(newChapter);
            });
        });
    });

    // 파일 저장 함수
    function saveFile(content, filename) {
        const blob = new Blob([content], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        a.click();
        URL.revokeObjectURL(url);
    }

    // 파일 불러오기 함수
    function loadFile(callback) {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'application/json';
        input.onchange = function(event) {
            const file = event.target.files[0];
            const reader = new FileReader();
            reader.onload = function(e) {
                callback(e.target.result);
            };
            reader.readAsText(file);
        };
        input.click();
    }
});
