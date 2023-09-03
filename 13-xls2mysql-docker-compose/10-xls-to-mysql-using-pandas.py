#!/usr/bin/python
# -*- coding: cp949 -*-

#-- 다음 명령을 실행하여 필수 종속성을 설치합니다.
#-- pip install pandas mysql-connector-python
#-- 새 Python 파일을 열고 필요한 라이브러리를 가져옵니다.

import pandas as pd
import mysql.connector

# sudo docker ps -a ; sudo docker-compose ps -a
# cat docker-compose.yml ; sudo docker-compose up
# sudo docker logs xlsmycon | grep "GENERATED ROOT PASSWORD"
# sudo docker exec -it xlsmycon mysql -u root -p #-- 처음에는 위 "GENERATED ROOT PASSWORD" 의 결과를 입력해야 한다.

#-- read_excel() 함수를 사용하여 Excel 데이터를 pandas DataFrame에 로드합니다.

df = pd.read_excel('filename.xlsx')

#-- mysql.connector.connect() 함수를 사용하여 MySQL 데이터베이스에 대한 연결을 만듭니다.

connection = mysql.connector.connect(host='myxlscont',
user='root',
password='ds2axa',
database='hajdb')

#-- 커서 개체를 만들고 SQL 쿼리를 실행하여 MySQL 테이블에 데이터를 삽입합니다.

cursor = connection.cursor()
query = 'INSERT INTO table_name (column1, column2, column3) VALUES (%s, %s, %s)'
for row in df.itertuples():
cursor.execute(query, (row.column1, row.column2, row.column3))
connection.commit()

#-- filename.xlsx, 사용자 이름, 비밀번호, 호스트, 데이터베이스, table_name, 컬럼1, 컬럼2, 컬럼3을 사용 사례에 적합한 값으로 바꿔야 합니다.
