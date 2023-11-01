⚒ Backend/Node.js
# [Node.js] Prisma CRUD 구현 (feat Prisma Studio)
by Fomagran 💻 2022. 8. 2. https://fomaios.tistory.com/entry/Nodejs-Prisma-CRUD-%EA%B5%AC%ED%98%84%ED%95%B4-%EB%B3%B4%EA%B8%B0-feat-Prisma-Studio

Prisma 쓸 이유 https://fomaios.tistory.com/entry/Nodejs-Prisma%EB%9E%80-feat-%EC%82%AC%EC%9A%A9%ED%95%B4%EC%95%BC-%EB%90%98%EB%8A%94-%EC%9D%B4%EC%9C%A0

## Init Prisma

```
npm init -y
npm install prisma @prisma/client typescript ts-node @types/node --save-dev

mkdir ~/start-prisma ; cd ~/start-prisma
npx prisma init
```

## Set a environment

.env 파일에 db 정보 입력.
```
DATABASE_URL="postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public"0
# DATABASE_URL="디비종류://유저이름:패스워드@localhost:포트번호/디비이름"
```

## Set a schema.prisma

`cat prisma/schema.prisma` 파일 내용:
```
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL") #-- .env 에 선언한 것을 쓴다.
}
```

그리고 나서, Gagyebu 라고 이름을 지은 테이블에, 원하는 데이터 모델을 정의해 준다.
```
model Gagyebu {
  id        Int      @id @default(autoincrement())
  pum       String   @db.VarChar(255)
  su        Int      @default(0)
  dan       Int      @default(0)
  kum       Int      @default(0)
  gage      String   @db.VarChar(255)
  jibul     Int
  ymd       String
  hm        String
  bigo      String   @db.VarChar(255)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

