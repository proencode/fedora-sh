import datetime

def alphabet2digit(alphabet):
  """
  알파벳 4자를 월일시분 8자리 숫자 및 "=FSRT=" 형식으로 변환합니다.

  Args:
    alphabet: 변환할 알파벳 4자 (예: 'FSRg')

  Returns:
    월일시분 8자리 숫자 및 "=FSRT=" 형식 문자열 (예: '06-19 17:32 =FSRg=')
  """
  # 문자열 길이 체크
  if len(alphabet) != 4:
    raise ValueError("알파벳 4자를 입력하세요.")

  # 월, 일, 시간, 분 추출
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
  elif minute <= 59:
    minute += 52
  else:
    raise ValueError("유효한 분 값이 아닙니다.")

  # 날짜 유효성 검사
  try:
    datetime.date(2024, month, day)
  except ValueError:
    raise ValueError("유효한 날짜가 아닙니다.")

  # 숫자 형식 변환
  month_str = f"{month:02d}"
  day_str = f"{day:02d}"
  hour_str = f"{hour:02d}"
  minute_str = f"{minute:02d}"

  # 8자리 숫자 문자열 생성
  digit_str = f"{month_str}-{day_str} {hour_str}:{minute_str}"

  # "=FSRT=" 형식 문자열 생성
  formatted_str = f"= {alphabet} ="

  # 결과 출력
  return f"{digit_str} {formatted_str}"

# 스크립트 실행
alphabet = input("알파벳 4자를 입력하세요: ")
result = alphabet2digit(alphabet)
print(result)
