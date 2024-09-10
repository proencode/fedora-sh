
바로 사용할 수 있는 Pomodoro 카이머 크롬 확장 프로그램을 구현합니다.

# 목차

1. 개요
1.1. 포모도로란 무엇인가
2. 나만의 Pomodoro Timer Chrome 확장 프로그램 만들기
2.1. Pomodoro 타이머를 위한 기본 Chrome 확장 프로그램 만들기
2.2. 필수 조건
2.3. 1단계: 프로젝트 설정
2.4. 2단계: 매니페스트 파일 준비
2.5. 3단계: 팝업 만들기
2.5.1. popup.html
2.5.2. popup.js
2.6. 4단계: 백그라운드 스크립트 구현
2.7. 5단계: CSS로 스타일 추가
2.8. 6단계: 이미지 만들기
2.8.1. 이미지 크기:
2.9. 7단계: Chrome에 확장 프로그램 로드
2.10. Pomodoro Timer Chrome 확장 프로그램 만들기: 결론
3. 개발자를 위한 중요 참고 사항:
3.0.1. 테스트를 위한 타이머 조정:
4. 타이머를 개선할 수 있는 방법

# 1. 개요

이 튜토리얼은 크롬 확장 프로그램으로 간단하면서도 효과적인 포모도로 타이머를 만드는 방법을 안내합니다. 타이머는 휴식을 취할 시간이 되면 알려주고, 알림에는 휴식을 시작하거나 건너뛸 수 있는 옵션이 포함됩니다.

# 1.1. 포모도로란 무엇인가

1980년대 후반 프란체스코 시릴로가 개발한 시간 관리 방법입니다. 이 기술은 타이머를 사용하여 작업을 전통적으로 25분 길이의 간격으로 나누고 짧은 휴식으로 구분합니다. 이러한 간격은 "포모도로스"로 알려져 있으며, 이탈리아에서 토마토를 의미하는 단어에서 따온 이름입니다. 시릴로가 대학생 때 사용했던 토마토 모양의 주방 타이머에서 영감을 받았습니다.

포모도로 테크닉이 작동하는 방식을 간단히 살펴보면 다음과 같습니다.

1. `작업 선택`: 작업하려는 작업을 선택하세요.
1. `포모도로 타이머 설정`: 타이머를 25분으로 설정합니다.
1. `작업 진행`: 타이머가 울릴 때까지 작업을 진행한 후, 종이에 체크 표시를 하세요.
1. `짧은 휴식을 취하세요`. 짧은 휴식을 취하세요(5분이 좋은 시작점입니다).
1. `4번의 포모도로를 한 후`: 포모도로를 4번 한 후 긴 휴식을 취하세요(15~30분).

이 기술은 작업을 짧고 관리하기 쉬운 간격으로 나누어 집중력을 향상시키는 동시에, 마음을 상쾌하게 하는 정기적인 휴식을 제공하도록 고안되었습니다.

비디오 플레이어

# 2. 나만의 Pomodoro Timer Chrome 확장 프로그램 만들기

## 2.1. Pomodoro 타이머를 위한 기본 Chrome 확장 프로그램 만들기

Pomodoro 타이머를 위한 기본 Chrome 확장 프로그램을 만드는 데는 여러 단계가 필요합니다. 아래는 이러한 확장 프로그램을 만드는 방법에 대한 개요이며, 필요한 기본 파일 [Encrypt files on Linux using VeraCrypt](https://danielepais.com/journal/encrypt-files-on-linux-using-veracrypt/) 과 각각에 대한 몇 가지 예제 코드도 포함됩니다.

## 2.2. 필수 조건

- HTML, CSS, JavaScript에 대한 기본적인 이해
- 크롬 브라우저 설치됨
- 텍스트 편집기(예: VS Code , Sublime Text 또는 선택한 편집기)
- Chrome 확장 프로그램의 작동 방식에 대한 기본 지식

## 2.3. 1 단계: 프로젝트 설정

1. 프로젝트에 대한 새 폴더를 만듭니다 (예: PomodoroTimerExtension).
1. 이 폴더 안에 다음 파일과 하위 폴더를 만드세요.
- manifest.json
- background.js
- popup.html
- popup.js
- images = 아이콘과 기타 이미지를 모아 놓은 하위 폴더입니다.

## 2.4. 2 단계: 매니페스트 파일 준비

먼저, manifest.json 파일이 필요합니다. 이 파일에는 Chrome이 확장 프로그램에 대해 알아야 할 모든 정보(이름, 버전, 필요한 권한, 사용하는 파일 등)가 포함되어 있습니다.
```json
{
  "manifest_version": 3,
  "name": "Pomodoro Timer",
  "version": "1.0",
  "description": "A simple Pomodoro timer to help you manage your work and break times.",
  "permissions": ["alarms", "notifications"],
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "images/tomato16.png",
      "48": "images/tomato48.png",
      "128": "images/tomato128.png"
    }
  },
  "background": {
    "service_worker": "background.js"
  },
  "icons": {
    "16": "images/tomato16.png",
    "48": "images/tomato48.png",
    "128": "images/tomato128.png"
  }
}
```
지정된 경로에 아이콘이 있는지 확인하세요.

## 2.5. 3 단계: 팝업 만들기

### 2.5.1. popup.html

```html
<!DOCTYPE html>
<html>
<head>
    <title>Pomodoro Timer</title>
    <link rel="stylesheet" type="text/css" href="popup.css">
</head>
<body>

    <div id="timer">25:00</div>
    <button id="start">Start</button>
     <button id="stop">Stop</button>
    <button id="reset" disabled>Reset</button>

    <script src="popup.js"></script>
</body>
</html>
```

### 2.5.2. popup.js

```js
document.getElementById('start').addEventListener('click', () => {
    chrome.runtime.sendMessage({ command: 'start' });
    document.getElementById('reset').disabled = false; // Enable the "Reset" button
});

document.getElementById('stop').addEventListener('click', () => {
    chrome.runtime.sendMessage({ command: 'stop' });
    // Optionally decide if the "Reset" button should be enabled or disabled here
});

document.getElementById('reset').addEventListener('click', () => {
    chrome.runtime.sendMessage({ command: 'reset' });
});

// Listener for messages from the background script to update the timer display
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.timer) {
        document.getElementById('timer').textContent = message.timer;
    }
});
```

또한 읽어보세요: [5분 튜토리얼: 단어 수 만들기 Google Chrome 확장 프로그램](https://danielepais.com/journal/5-minutes-tutorial-making-a-word-count-google-chrome-extension/)

## 2.6. 4 단계: 백그라운드 스크립트 구현

스크립트 background.js 는 타이머를 관리하고 알림을 생성합니다.
```js
let countdown;
let time = 25 * 60; // Initial timer set for 25 minutes

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.command === 'start') {
        startTimer();
    } else if (message.command === 'reset') {
        resetTimer();
    }
});

function startTimer() {
    if (time === 25 * 60 || countdown === undefined) { // Start a new timer if it's reset or not set
        clearInterval(countdown); // Clear any existing intervals
        countdown = setInterval(() => {
            if (time > 0) {
                time--;
                updatePopup();
            } else {
                completeTimer(); // Handle the completion of the timer
            }
        }, 1000);
    } else { // Resume the existing timer
        countdown = setInterval(() => {
            if (time > 0) {
                time--;
                updatePopup();
            } else {
                completeTimer(); // Handle the completion of the timer
            }
        }, 1000);
    }
}

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    // Existing message handling for 'start' and 'reset'

    if (message.command === 'stop') {
        stopTimer(); // Implement this function to pause the timer
    }
});

function stopTimer() {
    clearInterval(countdown);
    // Do not reset the time variable here to allow the timer to resume from where it was paused
}

function resetTimer() {
    clearInterval(countdown);
    time = 25 * 60; // Reset the timer to 25 minutes
    isRunning = false; // Ensure to mark the timer as not running
    updatePopup(); // Update the popup with the new time
}

function completeTimer() {
    clearInterval(countdown); // Stop the countdown
    // Reset the time for the next session but don't start counting down automatically
    time = 25 * 60;
    updatePopup(); // Update the popup with the reset time
     

    // Trigger the notification
    chrome.notifications.create({
        type: 'image',
        iconUrl: 'images/tomato128.png',
        title: 'Time is up!',
        message: 'Take a break, your 25-minute session is complete.',
          imageUrl: 'images/stop.jpg',
          requireInteraction: true, // The notification will stay until the user interacts with it
    buttons: [
        {title: "Start Break"},
        {title: "Skip Break"}
    ],
        priority: 2
    });
}

function updatePopup() {
    let minutes = Math.floor(time / 60);
    let seconds = time % 60;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    chrome.runtime.sendMessage({ timer: `${minutes}:${seconds}` });
}
```

## 2.7. 5 단계: CSS로 스타일 추가

이 popup.css 파일은 팝업에 기본 스타일을 추가합니다.
```css
body {
    width: 200px;
    padding: 10px;
    text-align: center;
}

#timer {
    font-size: 2em;
    margin-bottom: 20px;
}

button {
    margin: 5px;
}
```

## 2.8. 6 단계: 이미지 만들기

아이콘으로 사용할 토마토 이미지(tomato16.png, tomato48.png, tomato128.png, stop.jpg) 를 만들거나 찾아서 images 폴더에 넣어야 합니다.

### 2.8.1. 이미지 크기:

- tomato16.png (16px w x 16px h)
- tomato48.png (48px w x 48px h)
- tomato128.png (128px w x 128px h)
- stop.jpg (512px w x 512px h)

## 2.9. 7 단계: Chrome에 확장 프로그램 로드

1. Chrome을 열고  chrome://extensions/ 으로 이동합니다.
1. 오른쪽 상단의 "개발자 모드" 를 활성화하세요.
1. "압축 해제된 파일 로드"를 클릭하고 프로젝트 폴더를 선택하세요.

이제 브라우저에 Pomodoro Timer 확장 프로그램 아이콘이 표시됩니다. 클릭하면 시작, 중지 및 재설정 버튼이 있는 팝업이 열립니다. 타이머를 시작하면 25분부터 카운트다운되며 팝업에 남은 시간이 표시됩니다. 타이머가 끝나면 알림이 나타납니다.

액션 가능한 알림이 포함된 Pomodoro Timer Chrome 확장 프로그램

크롬 확장 프로그램을 성공적으로 구현했습니다.

## 2.10. Pomodoro Timer Chrome 확장 프로그램 만들기: 결론

축하합니다! 방금 Pomodoro를 만들었습니다.

# 3. 개발자를 위한 중요 참고 사항:

Pomodoro Timer Chrome 확장 프로그램을 개발하고 테스트할 때 표준 25분 대신 10초와 같이 더 짧은 기간으로 타이머 지속 시간을 조정하는 것이 좋습니다. 이 조정을 통해 더 빠른 테스트 주기를 허용하여 긴 대기 시간 없이 타이머와 알림의 기능을 확인할 수 있습니다.

### 3.0.1. 테스트를 위한 타이머 조정

파일 에서 background.js타이머 기간이 설정된 줄을 찾으세요.
```js
let time = 25 * 60; // 25 minutes
```

변경해야 할 시간 기간은 총 4가지입니다.
```js
let time = 10; // 10 seconds for testing
```

테스트를 완료하고 확장 프로그램을 게시하거나 공유하기 전에 이 변경 사항을 표준 기간 (예: 25분) 으로 되돌리는 것을 잊지 마세요.

[Samba를 사용하여 Linux 및 Windows와 네트워크 공유](https://danielepais.com/journal/sharing-a-network-with-linux-and-windows-using-samba/)

이렇게 하면 효율적인 개발과 테스트가 보장되어 불필요한 지연 없이 확장 기능의 기능을 개선하고 다듬는 데 집중할 수 있습니다.

# 4. 타이머를 개선할 수 있는 방법

이 확장 프로그램을 계속 개발하거나 개선할 계획이라면 고려해 볼 만한 추가 기능이나 개선 사항은 다음과 같습니다.

1. `사용자 정의 가능한 타이머 기간` : 사용자가 확장 프로그램의 팝업이나 옵션 페이지를 통해 원하는 집중 및 휴식 기간을 설정할 수 있도록 합니다.
1. `긴 휴식` : 일정 기간의 집중 기간을 거친 후 더 긴 휴식을 취하는 전통적인 포모도로 테크닉을 구현합니다.
1. `오디오 알림` : 타이머가 시작, 일시 정지 또는 완료될 때 시각적 알림 외에도 선택적으로 오디오 알림을 추가합니다.
1. `업무 통합` : 사용자가 각 Pomodoro 세션 중에 작업 중인 업무를 입력하고 선택할 수 있도록 하여 생산성 추적에 도움이 됩니다.
1. `통계` : 사용자가 일정 시간 동안 완료한 포모도로 세션 수, 평균 집중 시간, 휴식 시간 등에 대한 통찰력을 제공하여 사용자가 생산성 패턴을 모니터링하고 개선할 수 있도록 돕습니다.

또한 읽어보세요: [나만의 노트 작성 크롬 확장 프로그램 만들기: 단계별 가이드](https://danielepais.com/journal/build-your-own-note-taking-chrome-extension-a-step-by-step-guide/)

[무료](https://danielepais.com/journal/free-to-download-recipe-template-scalable-vector-for-illustrator-or-inkscape/) 사본 받기 : [무료 Pomodoro Timer Chrome 확장 프로그램](https://danielepais.com/journal/free-downloads)

# 다니엘 파이스

디지털 디자이너, 블로그 작가이자 기술 애호가이기도 합니다.
그는 블로그, 팟캐스트, 디자인 웹사이트, 로고, 브로셔, 배너 및 청중에게 메시지를 전달하는 모든 것에 대한 콘텐츠를 쓰는 것을 좋아합니다.
아래 링크에서 Daniele에게 연락할 수 있습니다.
[다니엘 파이스](danielepais.com/#contact)

[다니엘 파이스 저널](https://danielepais.com/journal/) 태그 240909-1233
| [어도비 일러스트레이터](https://danielepais.com/journal/tag/adobe-illustrator/) (7) | [어도비 포토샵](https://danielepais.com/journal/tag/adobe-photoshop/) (19) | [캔버스](https://danielepais.com/journal/tag/canva/) (15) | [채팅 gpt](https://danielepais.com/journal/tag/chat-gpt/) (6) | [채팅GPT](https://danielepais.com/journal/tag/chatgpt/) (15) | [창의적](https://danielepais.com/journal/tag/creative/) (14) |
|:----|:----|:----|:----|:----|:----|
| [디자인](https://danielepais.com/journal/tag/design/) (15) | [디자인 템플릿](https://danielepais.com/journal/tag/design-template/) (10) | [편집](https://danielepais.com/journal/tag/editing/) (6) | [엘리멘터](https://danielepais.com/journal/tag/elementor/) (9) | [페이스북 게시물](https://danielepais.com/journal/tag/facebook-post/) (12) | [무료](https://danielepais.com/journal/tag/free/) (9) |
| [무료 다운로드](https://danielepais.com/journal/tag/free-download/) (34) | [프리랜서](https://danielepais.com/journal/tag/freelance/) (9) | [프리랜서](https://danielepais.com/journal/tag/freelancer/) (4) | [김프](https://danielepais.com/journal/tag/gimp/) (6) | [구글 크롬 확장 프로그램](https://danielepais.com/journal/tag/google-chrome-extension/) (7) | [구글 슬라이드](https://danielepais.com/journal/tag/google-slides/) (5) |
| [그래픽 디자인](https://danielepais.com/journal/tag/graphic-design/) (17) | [그래픽](https://danielepais.com/journal/tag/graphics/) (12) | [어떻게](https://danielepais.com/journal/tag/how-to/) (7) | [잉크스케이프](https://danielepais.com/journal/tag/inkscape/) (6) | [인스타그램 게시물](https://danielepais.com/journal/tag/instagram-post/) (10) | [인터넷 마케팅](https://danielepais.com/journal/tag/internet-marketing/) (5) |
| [단축키](https://danielepais.com/journal/tag/keyboard-shortcuts/) (5) | [리눅스](https://danielepais.com/journal/tag/linux/) (6) | [로고 디자인](https://danielepais.com/journal/tag/logo-design/) (6) | [마케팅](https://danielepais.com/journal/tag/marketing/) (8) | [모형](https://danielepais.com/journal/tag/mockup/) (10) | [네트워크 보안](https://danielepais.com/journal/tag/network-security/) (4) |
| [오픈소스](https://danielepais.com/journal/tag/open-source/) (6) | [포장 디자인](https://danielepais.com/journal/tag/packaging-design/) (7) | [플러그인](https://danielepais.com/journal/tag/plugin/) (5) | [플러그인 개발](https://danielepais.com/journal/tag/plugin-development/) (4) | [게시물](https://danielepais.com/journal/tag/post/) (11) | [제품 디자인](https://danielepais.com/journal/tag/product-design/) (9) |
| [SEO](https://danielepais.com/journal/tag/seo/) (6) | [소셜 미디어](https://danielepais.com/journal/tag/social-media/) (17) | [소프트웨어](https://danielepais.com/journal/tag/software/) (9) | [SVG](https://danielepais.com/journal/tag/svg/) (9) | [템플릿](https://danielepais.com/journal/tag/template/) (19) | [트위터 게시물](https://danielepais.com/journal/tag/twitter-post/) (10) |
| [비디오](https://danielepais.com/journal/tag/video/) (5) | [웹 디자인](https://danielepais.com/journal/tag/web-design/) (5) | [워드프레스](https://danielepais.com/journal/tag/wordpress/) (28) |  |  |  |

> Page Info:
> (1) Title: Pomodoro 타이머 크롬 확장 프로그램
> (2) Short Description: 크롬 확장 프로그램
> (3) Path: danielepais/2024/2409/09-Google_Chrome_Extension
> 제목: Pomodoro Timer Chrome Extension
> 쓴이: By Daniele Pais / February 2, 2024
> 링크: https://danielepais.com/journal/make-your-own-pomodoro-timer-chrome-extension/
> 입력: 2024-09-10 화 09-21-37
> 파일: 09-Google_Chrome_Extension.md

