import datetime

def convert_time_to_alphabet(current_time):
  """
  현재 시각을 4개의 알파벳으로 변환합니다.

  Args:
    current_time: datetime 객체 (현재 시각)

  Returns:
    4개의 알파벳으로 변환된 문자열
  """
  month = current_time.month
  day = current_time.day
  hour = current_time.hour
  minute = current_time.minute

  # 월 알파벳 변환
  month_alphabet = chr(ord('A') + month - 1)

  # 일 알파벳 변환
  if day <= 26:
    day_alphabet = chr(ord('A') + day - 1)
  else:
    day_alphabet = chr(ord('a') + day - 27)

  # 시 알파벳 변환
  hour_alphabet = chr(ord('A') + hour)

  # 분 알파벳 변환
  if minute <= 25:
    minute_alphabet = chr(ord('A') + minute)
  elif minute <= 51:
    minute_alphabet = chr(ord('a') + minute - 26)
  else:
    minute_alphabet = str(minute - 52)

  return f"{month_alphabet}{day_alphabet}{hour_alphabet}{minute_alphabet}"

# 현재 시각 가져오기
current_time = datetime.datetime.now()

# 알파벳으로 변환된 시각 출력
converted_time = convert_time_to_alphabet(current_time)
print(f"{current_time.month}-{current_time.day} {current_time.hour}:{current_time.minute}")
print("")
print(f"={converted_time}= ")
