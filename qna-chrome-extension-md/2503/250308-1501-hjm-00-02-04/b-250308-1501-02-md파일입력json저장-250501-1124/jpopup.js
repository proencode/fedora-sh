// 🔥 gemini081501-02.
document.addEventListener('DOMContentLoaded', function() {
    const chapterNumber = document.getElementById('chapterNumber');
    const increaseButton = document.getElementById('increase');
    const decreaseButton = document.getElementById('decrease');
    const addAboveButton = document.getElementById('addAbove');
    const addBelowButton = document.getElementById('addBelow');
    const summaryTextarea = document.getElementById('summary');
    const detailsTextarea = document.getElementById('details');
    const saveButton = document.getElementById('save');
    const loadButton = document.getElementById('load');

    // 숫자 증감 기능
    increaseButton.addEventListener('click', function() {
        chapterNumber.value = parseInt(chapterNumber.value) + 1;
    });

    decreaseButton.addEventListener('click', function() {
        chapterNumber.value = parseInt(chapterNumber.value) - 1;
    });

    // 챕터 추가 기능 (^, v)
    addAboveButton.addEventListener('click', function() {
        // ... (챕터 추가 기능 구현)
    });

    addBelowButton.addEventListener('click', function() {
        // ... (챕터 추가 기능 구현)
    });

    // 저장 기능
    saveButton.addEventListener('click', function() {
        const data = {
            chapter: chapterNumber.value,
            summary: summaryTextarea.value,
            details: detailsTextarea.value
        };
        const filename = `chapter_${chapterNumber.value}.json`;
        saveFile(JSON.stringify(data), filename);
    });

    // 불러오기 기능
    loadButton.addEventListener('click', function() {
        loadFile(function(content) {
            const data = JSON.parse(content);
            chapterNumber.value = data.chapter;
            summaryTextarea.value = data.summary;
            detailsTextarea.value = data.details;
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
