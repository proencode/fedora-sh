/* 250304-13 */
let schedule = {};

function displayWeekCalendar() {
  const today = new Date();
  const dayOfWeek = today.getDay();
  const currentDate = today.getDate();
  const currentMonth = today.getMonth();
  const currentYear = today.getFullYear();

  const calendarTable = document.getElementById("calendar");
  const headerRow = calendarTable.rows[0];
  const memoRow = calendarTable.rows[1];

  headerRow.innerHTML = "";
  memoRow.innerHTML = "";

  const startDate = new Date(currentYear, currentMonth, currentDate - dayOfWeek);

  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate);
    date.setDate(startDate.getDate() + i);

    const day = date.getDate();
    const dayName = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];
    const month = date.getMonth() + 1;

    let dateText = `${day} (${dayName})`;

    if (date.getDay() === 0 || (i > 0 && date.getDate() === 1)) {
      dateText = `${month} / ${day} (${dayName})`;
    }

    const headerCell = document.createElement("th");
    headerCell.textContent = dateText;

    if (
      date.getFullYear() === currentYear &&
      date.getMonth() === currentMonth &&
      date.getDate() === currentDate
    ) {
      headerCell.classList.add("today");
    }

    headerRow.appendChild(headerCell);

    if (schedule[day]) {
      const memoCell = document.createElement("td");
      memoCell.textContent = schedule[day];
      memoRow.appendChild(memoCell);
    } else {
      const emptyCell = document.createElement("td");
      memoRow.appendChild(emptyCell);
    }
  }
  document.getElementById("calendar").style.display = "table";
}

function addInputRow() {
  const inputRow = document.createElement("div");
  inputRow.className = "inputRow";
  inputRow.innerHTML = '<input type="number" placeholder="날짜" class="dateInput"><input type="text" placeholder="메모" class="memoInput">';
  document.getElementById("inputContainer").insertBefore(inputRow, document.getElementById("saveInput"));
}

document.getElementById("inputContainer").addEventListener("keydown", function(event) {
  if (event.key === "Tab") {
    const memoInputs = document.getElementsByClassName("memoInput");
    if (event.target === memoInputs[memoInputs.length - 1]) {
      event.preventDefault();
      addInputRow();
      memoInputs[memoInputs.length -1].parentElement.getElementsByClassName('dateInput')[0].focus();
    }
  }
});

document.getElementById("saveInput").addEventListener("click", function() {
  schedule = {};
  const inputRows = document.getElementsByClassName("inputRow");
  for (let i = 0; i < inputRows.length; i++) {
    const dateInput = inputRows[i].getElementsByClassName("dateInput")[0];
    const memoInput = inputRows[i].getElementsByClassName("memoInput")[0];
    const date = parseInt(dateInput.value);
    const memo = memoInput.value;
    if (!isNaN(date) && memo) {
      schedule[date] = memo;
    }
  }
  displayWeekCalendar();
});

addInputRow();
