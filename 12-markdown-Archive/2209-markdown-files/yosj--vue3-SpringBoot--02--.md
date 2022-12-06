# 1: var 선언자 특성

1. 중복 선언 가능
```
// ecma_ex_1.1
```
2. 일반 변수 선언시 호이스팅
- 변수의 정의란 var num = 100; 과 같이 선언 하는것.
> 호이스팅 이란:
> 함수 안에서 정의 되었으면 --> 함수의 최상위로 이동.
> 함수 바깥에서 정의 되었으면 --> 전역 컨텍스트이 최상위로 이동.
- 변수 선언이 되어있지 않을때
```
// ecma_ex_1.2.1
```
- 변수가 사용되고 나서 선언이 되었을때
```
// ecma_ex_1.2.2
```
- 동일한 코드
```
// ecma_ex_1.2.3
```
3. for 문 초기화 식에서 변수 선언시 호이스팅
- 변수 선언이 되어있지 않을때
```
// ecma_ex_1.3.1
```
- 변수가 사용되고 나서 선언이 되었을때
```
// ecma_ex_1.3.2
```
- 동일한 코드
```
// ecma_ex_1.3.3
```
4. if 문 내에서 변수 선언시 호이스팅
- if문 외부에 이름이 동일한 변수가 선언되어 있을때
```
// ecma_ex_1.4.1
```
- 동일한 코드
```
// ecma_ex_1.4.2
```
- 변수가 사용되고 나서 선언이 되었을때
  변수 사용시 변수를 선언하지 않았지만, 호이스팅이 적용되어 변수를 사용할 수 있다.
```
// ecma_ex_1.4.3
```
- 동일한 코드
```
// ecma_ex_1.4.4
```

# 2: let 선언자

1. let 변수 선언
- 선언과 동시에 초기화
```
// ecma_ex_2.1.1
```
- 선언후 초기화
```
// ecma_ex_2.1.2
```
2. 중복선언 불가능
```
// ecma_ex_2.2.1
```
3. 호이스팅이 발생하지 않는다.
```
// ecma_ex_2.3.1
```
4. for 문 초기화 식에서 변수 선언
- 변수 선언
```
// ecma_ex_2.4.1
```
- 호이스팅이 발생하지 않는다.
```
// ecma_ex_2.4.2
```
- for 문 외부에서 사용 불가능
```
// ecma_ex_2.4.3
```
5. 제어문 중괄호 블록 내부에서 변수 선언
- 변수 선언
```
// ecma_ex_2.5.1
```
- 호이스팅이 발생하지 않는다
```
// ecma_ex_2.5.2
```
- 제어문 중괄호 블록 외부에서 사용 불가능
```
// ecma_ex_2.5.3
```

# 3: const 선언자

1. 상수를 선언한다
```
// ecma_ex_3.1
```
- 상수를 선언과 동시에 초기화를 해야 한다
```
// ecma_ex_3.2
```
- 초기값을 설정한 후 상수에 값을 할당할 수 없다
```
// ecma_ex_3.3
```
- 중복 선언이 불가능라다
```
// ecma_ex_3.4
```

# 4: Symbol 타입

심볼은 유일무이한 값

1. 심볼 생성
```
// ecma_ex_4.1
```
2. 심볼의 설명
```
// ecma_ex_4.2
```
3. 심볼의 값 비교
```
// ecma_ex_4.3
```
4. 심볼의 설명 확인
```
// ecma_ex_4.4
```
5. 심볼 사용과 상수 사용 비교
- 상수 사용
```
// ecma_ex_4.5.1
```
- 심볼 사용
```
// ecma_ex_4.5.2
```

# 5: 화살표 함수

1. 화살표 함수 표현식의 작성법
- 매개변수가 없을때
```
// ecma_ex_5.1.1
```
- 매개변수가 하나일때
```
// ecma_ex_5.1.2
```
- 매개변수가 2개 이상일때
```
// ecma_ex_5.1.3
```
2. 화살표 함수와 this
- 메서드 몸체안에 정의한 중첩함수 경우-1
  중펍함수 this 가 전역객체를 가리킨다.
```
// ecma_ex_5.2.1
```
- 메서드 몸체안에 정의한 중첩함수 경우-2
```
// ecma_ex_5.2.2
```
- 메서드 몸체안에 정의한 화살표 함수
  화살표 함수 this 를 메서드 정의할 때의 calc 객체로 고정시킨다
```
// ecma_ex_5.2.3
```

# 6: for of 문

1. 배열의 각 요소를 순회한다.
- 메서드 몸체안에 정의한 중첩함수 경우-2
```
// ecma_ex_6.1
```
2. 문자열을 이루는 문자 요소를 순회한다
```
// ecma_ex_6.2
```
3. for in 문처럼 객체의 프로퍼티를 열거하지는 않는다
```
// ecma_ex_6.3
```

# 7: 비 구조화 할당

1. 비 구조화 할당 이전 방식
   객체의 프로퍼티 별로 따로 변수를 선언해서 값을 할당한다.
```
// ecma_ex_7.1
```
2. 비 구조화 할당
- 기본작인 사용법
  객체 리터럴과 비슷한 문법을 사용한다
  { 프로퍼티명:변수명 , 프로퍼티명:변수명 , ... } 형식을 가진다.
```
// ecma_ex_7.2.1
```
- 프로퍼티 없을때
  unddefined 값이 할당된다.
```
// ecma_ex_7.2.2
```
- 기본값 설정
  프로퍼티가 없더라도 기본값을 설정할 수 있다.
```
// ecma_ex_7.2.3
```
- 프로퍼티 이름 생략
  변수명만 쉼표로 구분해서 작성할 수 있다.
```
// ecma_ex_7.2.4
```

# 8: Map 컬렉션 타입

1. Map 객체 생성
```
// ecma_ex_8.1
```
2. 초기 데이터 지정해서 생성
```
// ecma_ex_8.2
```
3. Map 객체 데이터의 갯수 확인
```
// ecma_ex_8.3
```
4. 데이터 추가하기
```
// ecma_ex_8.4
```
5. 데이터 값 읽기
```
// ecma_ex_8.5
```
6. 데이터 존재 확인
```
// ecma_ex_8.6
```
7. 데이터 삭제
```
// ecma_ex_8.7
```
8. 모든 데이터 삭제
```
// ecma_ex_8.8
```
9. 모든 키 값 열거하기
```
// ecma_ex_8.9
```
10. 모든 값 열거하기
```
// ecma_ex_8.10
```
11. 모든 데이터 열거하기
```
// ecma_ex_8.11
```
12. 모든 데이터함수 처리
```
// ecma_ex_8.12
```

# 9: Set 컬렉션 타입

1. Set 객체 생성
```
// ecma_ex_9.1
```
2. 초기 데이터 지정해서 생성
```
// ecma_ex_9.2
```
3. Set 객체 데이터의 갯수 확인
```
// ecma_ex_9.3
```
4. 데이터 추가하기
```
// ecma_ex_9.4
```
5. 데이터 존재 확인
```
// ecma_ex_9.5
```
6. 데이터 삭제
```
// ecma_ex_9.6
```
7. 모든 데이터 삭제
```
// ecma_ex_9.7
```
8. 모든 키 값 열거하기
```
// ecma_ex_9.8
```
9. 모든 데이터 열거하기
```
// ecma_ex_9.9
```
10. for of 문을 사용해서 모든 데이터 열거하기
```
// ecma_ex_9.10
```
11. 모든 데이터 함수 처리
```
// ecma_ex_9.11
```
# 10: 함수 매개변수

1. 나머지 매개변수
  나머지 매개변수는 전개 연산자 "..." 로 표현한 매개변수이다.
- 다른 매개변수와 사용
```
// ecma_ex_10.1.1
```
- 단독 사용
```
// ecma_ex_10.1.2
```
2. 매개변수의 기본값
   매개변수에 대입 연산자 (=) 를 써서 기본값을 설정할 수 있다.
- 기본값 사용하지 않을때
```
// ecma_ex_10.2.1
```
- 기본값 사용할 때
```
// ecma_ex_10.2.2
```

# 11: 템플릿 리터럴

> 템플릿 리터럴이란, 역따옴표 \' 로 묶은 문자열이다.

1. 기본작인 사용법
- 한줄 문자열
```
// ecma_ex_11.1.1
```
- 여러줄 문자열
```
// ecma_ex_11.1.2
```
2. 보간 표현식
   템플릿 리터럴에서 플레이스 홀더 ${...} 를 넣을 수 있다.
- 변수
```
// ecma_ex_11.2.1
```
- 표현식
```
// ecma_ex_11.2.2
```

# 12: 클래스 구문

1. 클래스 선언문
```
// ecma_ex_12.1
```
2. 클래스 표현식
```
// ecma_ex_12.2
```
3. 접근자
```
// ecma_ex_12.3
```
4. 정적 메서드
```
// ecma_ex_12.4
```

# 13: 클래스 상속

1. 클래스 확장
```
// ecma_ex_13.1
```
2. 메서드 재정의
```
// ecma_ex_13.2
```

# 14: 전개 연산자

`...` 은 전개 연산자 spread operator 라고 한다.
전개 연산자는 반복 가능한 객체를 반환하는 표현식 앞에 표기한다.
이를 통해 반복 가능한 객체를 배열 리터럴 또는 함수의 인수 목록으로 펼칠 수 있다.

1. 배열 리터럴 전개
   전개 연산자를 사용해서 배열 리터럴 안에 전개하여 새로운 배열 리터럴을 생성한다.
```
// ecma_ex_14.1
```
2. 함수 인수 목록 전개
   전개 연산자를 사용해서 함수의 인수 목록으로 펼칠 수 있다.
```
// ecma_ex_14.2
```
3. 배열 연결
   전개 연산자를 활용하여 배열을 연결한다.
```
// ecma_ex_14.3
```
4. 배열 최대값
   Math.max 로 전개 연산자를 이용한 값을 인자로 전달하여 배역 최대값을 구한다.
```
// ecma_ex_14.4
```

# 15: 객체 속성 생략 지정

객체의 변수 이름과 속성 이름이 같으면 생략해서 입력해도 된다

1. 객체 리터럴
   객체 리터럴로 객체를 생성한다.
   객체 속성 이름으로 문자열을 사용할 수 있다.
```
// ecma_ex_15.1
```
2. 객체 속성 생략 지정
   객체의 변수 이름과 속성 이름이 같으면 생략해서 입력해도 된다
```
// ecma_ex_15.2
```

# 16: 프로미스

프로미스 Promis 는 비동기 처리를 추상화한 객체이다. 비동기 처리를 조작하는 방법을 제공한다.
프로미스는 비동기 처리를 실행하고 그 처리가 끝난 후에 다음 처리를 실행하기 위한 용도로 사용한다.

Pronis 객체는 비동기 작업이 끝나기를 기다렸다가 작업의 결과에 따라 다음 작업을 진행할지, 에러를 처리할지 결정하며, 이 동작을 구현하기 위해 promise 객체는 다음주 하나의 상태로 존재한다.

- Fulfilled: 작업이 성공한 경우
- Rejected: 작업이 실패한 경우. 에러를 반환한다.
- Pending: 작업이 아직 진행중인 경우.

1. Promise 생성자 사용법
   프로미스를 사용하려면 먼저 Promise 객체를 생성해야 한다.
   Promise 생성자에는 실행하고자 하는 처리를 작성한 함수를 인수로 넘기고, fulfilled 상태가 될때 실행될 함수 = resolve() 와 rejected 상태가 될때 실행될 함수 = reject() 를 인수로 받는다.
```
var promise = new Promise(function(resolve, reject( { ..... } );
```
2. 비동기 함수
   함수가 비동기로 작동하면 일반적인 호출을 하면 원하는 실행 순서를 보장할수 없다.
```
// ecma_ex_16.1
```
3. 콜백 지옥
   비동기 작업을 동기식으로 처리하려면 콜백함수를 중첩해서 처리한다.
   중첩 정도가 올라갈수록 소스의 가독성이 현저히 떨어진다.'
```
// ecma_ex_16.2
```
4. 프로미스 사용
   프로미스를 사용하면 중첩된 콜백함수를 제거할 수 있고, 소스의 가독성이 좋아진다.
```
// ecma_ex_16.3
```
5. resolve 함수 호출
   처리가 성공적으로 완료되었을때는 resolve 함수를 호출한다.
   resolve 함수는 프로미스를 종료시킨다.
   resolve 함수에 인자값을 전달할 수 있다.
```
// ecma_ex_16.4
```
6. reject 함수 호출
   처리가 실패했다면 reject 함수를 호출한다.
   reject 함수는 프로미스를 종료시킨다.
   reject 함수에 인자값을 전달할 수 있다.
```
// ecma_ex_16.5
```
7. finally 함수 호출
   성공 또는 실패 여부와 상관없이 무조건 해야 하는 처리는 finally 를 사용한다.
```
// ecma_ex_16.6
```
8. 비동기 함수
   함수가 비동기로 작동하면 일반적인 호출을 하면 원하는 실행순서를 보장할 수 없다.
```
// ecma_ex_16.7
```
9. 콜백 지옥
   비동기 작업을 동기식으로 처리하려면 콜백함수를 중첩하여 처리한다.
   중첩 정도가 올라갈수록 소스의 가독성이 현저히 떨어진다.
```
// ecma_ex_16.8
```
10. 프로미스 사용
   프로미스를 사용하면 중첩된 콜백 함수를 제거할 수 있고, 소스의 가독성이 좋아진다.
```
// ecma_ex_16.9
```
11. 프로미스와 비동기 함수 사용
   비동기 함수는 resolve, reject 콜백함수를 전달받는 인자를 가질수 있다.
```
// ecma_ex_16.10
```
12. 프로미스를 반환하는 비동기 함수 사용
   비동기 함수는 프로미스 객체를 생성하여 반환할 수 있다.
```
// ecma_ex_16.11
```
