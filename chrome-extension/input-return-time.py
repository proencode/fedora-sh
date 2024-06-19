import datetime

def alphabet2digit(alphabet):
  """
  알파벳 4자를 월일시분 8자리 숫자로 변환합니다.

  Args:
    alphabet: 변환할 알파벳 4자 (예: 'FSNZ')

  Returns:
    월일시분 8자리 숫자 (예: '06191625')
  """
  # 문자열 길이 체크 및 입력받는 부분 추가
  if len(input("알파벳 4자를 입력하세요: ")) != 4:
    raise ValueError("알파벳 4자를 입력하세요.")

  # 월, 일, 시간 추출
  month = ord(alphabet[0]) - ord('A') + 1
  day = ord(alphabet[1]) - ord('A')
  if day >= 26:
    day -= 26
    day += 1

  hour = ord(alphabet[2]) - ord('A')
  minute = ord(alphabet[3]) - ord('A')

  # 분 범위 체크 및 변환
  if minute <= 25:
    minute += 1
  elif minute <= 51:
    minute -= 26
  else:
    minute += 52

  # 날짜 유효성 검사
  try:
    datetime.date(2024, month, day)
  except ValueError:
    raise ValueError("유효한 날짜가 아닙니다.")

  # 8자리 숫자로 변환
  digit = f"06{month:02d}{day:02d}{hour:02d}{minute:02d}"

  return digit

# 스크립트 실행
alphabet = input("알파벳 4자를 입력하세요: ")
digit = alphabet2digit(alphabet)
print(f"{alphabet} -> {digit}")
