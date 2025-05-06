// chatgpt05.1342-00 utils.js
const SHIFT_CYCLE = [
  '주간-1', '주간-2',
  '야간-1', '야간-2',
  '휴무-1', '휴무-2'
];

function parseDate(str) {
  const [year, month, day] = str.split('-').map(Number);
  return new Date(year, month - 1, day);
}

function formatDate(date, includeMonth = false) {
  const day = date.getDate();
  const weekday = ['일', '월', '화', '수', '목', '금', '토'][date.getDay()];
  const month = date.getMonth() + 1;
  return includeMonth ? `${month} / ${day} (${weekday})` : `${day} (${weekday})`;
}

function getShift(startDate, startShift, targetDate) {
  const shiftIndex = SHIFT_CYCLE.indexOf(startShift);
  const daysDiff = Math.floor((targetDate - startDate) / (1000 * 60 * 60 * 24));
  const index = (shiftIndex + daysDiff % 6 + 6) % 6;
  return SHIFT_CYCLE[index];
}

function getEffectiveShift(startPoints, date) {
  let activeStart = startPoints[0];
  for (const sp of startPoints) {
    if (sp.date <= date) activeStart = sp;
  }
  return getShift(activeStart.date, activeStart.shift, date);
}
