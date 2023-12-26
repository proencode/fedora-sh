### 오늘의 링크

1. 젯브레인 2023학습채널 https://hyperskill.org/tracks/18
1. (2023-07 322p) 최신 Android 13 개발 요리책 Modern Android 13 Development Cookbook https://subscription.packtpub.com/book/mobile/9781803235578/pref
1. (2022-03 420.p) WordPress Plugin Development Cookbook https://subscription.packtpub.com/book/web-development/9781801810777/pref
1. 전국은행연합회 - 예금상품 금리비교 https://portal.kfb.or.kr/compare/receiving_neosearch.php

#### prisma
1.  Backend/Node.js [Node.js] Prisma란? (feat. 사용해야 되는 이유) by Fomagran 💻 2022. 8. 2. https://fomaios.tistory.com/entry/Nodejs-Prisma%EB%9E%80-feat-%EC%82%AC%EC%9A%A9%ED%95%B4%EC%95%BC-%EB%90%98%EB%8A%94-%EC%9D%B4%EC%9C%A0
1. Prisma 처음 시작하기 https://www.prisma.io/docs/getting-started/quickstart
1. 데이터베이스 프레임워크/Prisma [Prisma] Prisma란? / 간단시작하기 ( PostgreSQL 연결 ) MOONCO  2021. 4. 20. https://defineall.tistory.com/853
1. 프리즈마 란 무엇입니까? https://www.prisma.io/docs/concepts/overview/what-is-prisma
1. 개발에 어떤 도구를 사용하고 있나요? 피유시 야다브 4월 19일 https://medium.com/@piyushyadav0191/what-tools-am-i-using-for-development-ad26e8b760ec
`chadVim`, `Prisma`,
1. 데이터베이스에서 정수 ID 사용을 중지하세요. 톰 제이 5월 23일 https://medium.com/@thomasjay200/stop-using-integer-ids-in-your-database-5e5126a25dbe
1. Prisma 처음 시작하기 https://www.daleseo.com/prisma/
1. Prisma와 Docker로 간단한 GraphQL 서버 만들기 2019.08.16 00:38 https://geonlee.tistory.com/148
1. How to set up Prisma with a local Docker Postgres container
This is a simple guide on how to connect a Docker Postgres container to a Prisma Schema setup. This is not a Prisma tutorial. Alessandro Baccini  Nerd For Tech Alessandro Baccini Published in Nerd For Tech Oct 20, 2022 https://medium.com/nerd-for-tech/how-to-set-up-prisma-with-a-local-docker-postgres-container-9e0958d08544
1. ⚒ Backend/Node.js [Node.js] Prisma CRUD 구현해 보기 (feat Prisma Studio) by Fomagran 💻 2022. 8. 2. https://fomaios.tistory.com/entry/Nodejs-Prisma-CRUD-%EA%B5%AC%ED%98%84%ED%95%B4-%EB%B3%B4%EA%B8%B0-feat-Prisma-Studio
1. [프로젝트 로그] 1-2. 개발환경 설정 - 백엔드편 metafear5108·2023년 2월 24일 https://velog.io/@metafear5108/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EB%A1%9C%EA%B7%B8-1.-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-%EC%84%A4%EC%A0%95-%EB%B0%B1%EC%97%94%EB%93%9C%ED%8E%B8
1. How to set up Prisma with a local Docker Postgres container
This is a simple guide on how to connect a Docker Postgres container to a Prisma Schema setup. This is not a Prisma tutorial. Nerd For Tech Alessandro Baccini Published in Nerd For Tech Oct 20, 2022 https://medium.com/nerd-for-tech/how-to-set-up-prisma-with-a-local-docker-postgres-container-9e0958d08544



# 23 12 24

## pgadmin

### Docker를 사용하여 PostgreSQL 및 pgAdmin을 실행하는 방법 20230731 
https://www.commandprompt.com/education/how-to-run-postgresql-and-pgadmin-using-docker/

1. Postgres Docker 이미지 가져오기/다운로드
```
sudo docker pull postgres
```
2. Postgres 컨테이너 시작 및 실행
```
docker run --name my-pgadmin -p 82:80 -e 'PGADMIN_DEFAULT_EMAIL=my@email.com' -e 'PGADMIN_DEFAULT_PASSWORD=pass1234' -d dpage/pgadmin4
```
3. pgAdmin4 Docker 이미지 가져오기/다운로드
```
sudo docker pull dpage/pgadmin4
```
4. pgAdmin4 컨테이너 빌드 및 실행
```
sudo docker run --name my-pgadmin -p 82:80 -e 'PGADMIN_DEFAULT_EMAIL=my@email.com' -e 'PGADMIN_DEFAULT_PASSWORD=pass1234' -d dpage/pgadmin4
```
5. 실행 중인 컨테이너 확인
```
sudo docker ps
```
6. 브라우저에서 pgAdmin4에 액세스
```
https://localhost:82
```
7. pgAdmin과 Docker Postgres 인스턴스 간 연결 설정
- `Object Explorer` > `Servers` > `Register` > `Server...`
- `Register - Server` > `General` > `Name` => `PostgreSQL`
- `Register - Server` > `Connection` > `Host name/address` => `Postgres_DB`

# 231223 토

## youtube

1. 5천 년 전 부자들은 이렇게 돈을 모았다 | 북언더스탠딩 | 5000년의 부 | 스노우폭스북스 서진 편집장 언더스탠딩 : 세상의 모든 지식 구독자 54.4만명 https://www.youtube.com/watch?v=dnasE9o4zhI
1. 일본에서 한류에 빠진 일본 엄마가 화제가 된 이유 ぱく家(박가네) 구독자 50.3만명 https://www.youtube.com/watch?v=Myg42z4MLQQ
1. 40대부터 점차 줄어드는 근육량 꾸준한 운동 습관으로 사라진 근력 돌릴 수 있다! | 노쇠 전 단계 | 명의 | #EBS건강 EBS 건강 구독자 7.3만명 조회수 50만회  1개월 전 https://www.youtube.com/watch?v=W90JAnRQbLI
1. [무료영화] 그때 그사람들 (2005) / '서울의 봄' 관람 전에 봐야 하는 영화 PLAYYMOVIE 구독자 58.1만명 조회수 76만회  1개월 전 https://www.youtube.com/watch?v=PMg58MDFcWs
1. 추억의 올드팝 [1960년대 27 곡] Oldies Songs 1960s [27 Songs] ch음악채널4111 구독자 11.2만명 조회수 552,963회 231108 https://www.youtube.com/watch?v=CIx8ejm6NTc
1. 더 이상 라디오에서 들을 수 없는 음악 - 부드러운 기타와 함께 휴식을 취할 수 있는 기억의 음악 Melodious Strings 구독자 12.6만명 조회수 311만회  스트리밍 시간: 4개월 전 https://www.youtube.com/watch?v=_4pQkR2149w&t=17s

# 231222 금
1010 푸른숲

## ChatGPT 3.5

### User
아래의 기사를 요약해서 한국어로 번역해줘.
### ChatGPT
불행히도, 여러분이 요청한 기사의 내용이 주어지지 않았습니다. 기사의 내용이나 특정 주제를 제공해 주시면, 해당 내용을 한국어로 요약해 드릴 수 있습니다. 부연 설명이나 특정 기사 내용을 알려주시면 도움이 될 것입니다.

### User
어? 여기 입력창에서 엔터를 치면 줄이 바뀌기만 하고, 위로 화살표 아이콘을 눌러야 입력한 문장이 보내졌는데, 오늘은 그렇게 안되네? 어쨋든 지금 기사의 내용을 보낼께.
### ChatGPT
네, 이해했습니다. 문제가 발생한 점에 대해 죄송합니다. 기사 내용을 전달해주시면, 해당 내용을 한국어로 요약해 드리겠습니다. 어떤 기사인지 알려주시기 바랍니다.

### User
Why the EU AI Act was so hard to agree on
Three key issues that jeopardized the EU AI Act

By Tate Ryan-Mosleyarchive page
December 11, 2023
European Parliament during a vote on the Artificial Intelligence Act in June 2023
AP PHOTO/JEAN-FRANCOIS BADIA
This article is from The Technocrat, MIT Technology Review's weekly tech policy newsletter about power, politics, and Silicon Valley. To receive it in your inbox every Friday, sign up here.

Update: On December 8, 2023, the EU AI Act was agreed on, after this story was written and sent as MIT Technology Review's weekly tech policy newsletter, The Technocrat. The full text of the new law is not yet available, but we will have a full breakdown in The Algorithm, arriving in inboxes later today. Make sure you're signed up!

Three governing bodies of the European Union have been intensely negotiating the final version of the EU AI Act, a major package of laws regulating the industry that was first proposed back in 2021. The initial deadline for a final package, December 6, has now come and gone, though lawmakers have not given up and were debating into the early hours of Thursday morning and again on Friday. 

Just a few months ago, it seemed as though the EU AI Act was on its way to getting all the necessary votes and setting the benchmark for AI regulation far beyond the European bloc. But now France, Germany, and Italy in the EU Council, which is composed of member countries’ heads of state, have contested some of the package’s main tenets, and the legislation seems in real danger of failing—which would open the door for other countries outside Europe to set the global AI agenda. 


To better understand the key sticking points and what’s next, I spoke with our senior AI reporter Melissa Heikkilä and Connor Dunlop, a policy expert at the Ada Lovelace Institute. I’ll warn it’s all pretty complex and it’s still a moving target; as Connor tells me, “The most surprising thing has been the level of drafting and redrafting across all three EU institutions,” which he describes as “unprecedented.” But here, with their help, I’ll do my best to answer some of the biggest questions.

What is the basic outline of this law? 
As a refresher, the EU AI Act seeks to establish a risk-based framework for regulating artificial-intelligence products and applications. The use of AI in hiring, for example, is more tightly regulated and requires more transparency than a “lower-risk” application, like AI-enabled spam filters. (I wrote about the package back in June, if you want more background information.) 

Why has this been so hard to finalize?
First, Melissa tells me, there is a lot of disagreement about foundation models, which has taken up most of the energy and space during the latest debates. There are several definitions of the term “foundation model” floating around, which is part of what’s causing the discord, but the core concept has to do with general-purpose AI that can do many different things for various applications. 

You’ve probably played around with ChatGPT; that interface is essentially powered by a foundation model, in this case a large language model from OpenAI. Making this more complex, though, is that these technologies can also be plugged into various other applications with more narrow uses, like education or advertising.

Initial versions of the EU AI Act didn’t explicitly consider foundation models, but Melissa notes that the proliferation of generative AI products over the past year pushed lawmakers to integrate them into the risk framework. In the version of the legislation passed by Parliament in June, all foundation models would be tightly regulated regardless of their assigned risk category or how they are used. This was deemed necessary in light of the vast amount of training data required to build them, as well as IP and privacy concerns and the overall impact they have on other technologies. 

But of course, tech companies that build foundation models have disputed this and advocate for a more nuanced approach that considers how the models are used. France, Germany, and Italy have flipped their positions and gone so far to say that foundation models should be largely exempt from AI Act regulations. (I’ll get at why below.)

The latest round of EU negotiations has introduced a two-tier approach in which foundation models are, at least in part, sorted on the basis of the computational resources they require, Connor explains. In practice, this would mean that “the vast majority of powerful general-purpose models will likely only be regulated by light-touch transparency and information-sharing obligations,” he says, including models from Anthropic, Meta, and others. “This would be a dramatic narrowing of scope [of the EU AI Act],” he adds. Connor says OpenAI’s GPT-4 is the only model on the market that would definitely fall into the higher tier, though Google’s new model, Gemini, might as well. (Read more about the just-released Gemini from Melissa and our senior AI editor Will Douglas Heaven here.)

This debate over foundation models is closely tied to another big issue: industry-friendliness. The EU is known for its aggressive digital policies (like its landmark data privacy law, GDPR), which often seek to protect Europeans from American and Chinese tech companies. But in the past few years, as Melissa points out, European companies have started to emerge as major tech players as well. Mistral AI in France and Aleph Alpha in Germany, for instance, have recently raised hundreds of millions in funding to build foundation models. It’s almost certainly not a coincidence that France, Germany, and Italy have now started to argue that the EU AI act may be too burdensome for the industry. Connor says this means that the regulatory environment could end up relying on voluntary commitments from companies, which may only later become binding.

“How do we regulate these technologies without hindering innovation? Obviously there’s a lot of lobbying happening from Big Tech, but as European countries have very successful AI startups of their own, they have maybe moved to a slightly more industry-friendly position,” says Melissa. 

Finally, both Melissa and Connor talk about how hard it’s been to find agreement on biometric data and AI in policing. “From the very beginning, one of the biggest bones of contention was the use of facial recognition in public places by law enforcement,” says Melissa. 


The European Parliament is pushing for stricter restrictions on biometrics over fears the technology could enable mass surveillance and infringe on citizens’ privacy and other rights. But European countries such as France, which is hosting the Olympics next year, want to use AI to fight crime and terrorism; they are lobbying aggressively and placing a lot of pressure on the Parliament to relax their proposed policies, she says.   

What’s next?
The December 6 deadline was essentially arbitrary, as negotiations have already continued past that date. But the EU is creeping up to a harder deadline. 

Melissa and Connor tell me the key stipulations need to be settled several months before EU elections next June to prevent the legislation from withering completely or getting delayed until 2025. It’s likely that if no agreement is reached in the next few days, the discussion will resume after Christmas. And keep in mind that beyond solidifying the text of the actual law, there’s still a lot that needs to be ironed out regarding implementation and enforcement. 

“Hopes were high for the EU to set the global standard with the first horizontal regulation on AI in the world,” Connor says, “but if it fails to properly assign responsibility across the AI value chain and fails to adequately protect EU citizens and their rights, then this attempt at global leadership will be severely diminished.” 

What I am reading this week
The House Judiciary committee approved a version of a bill that would reform and renew FISA, a controversial surveillance bill that is up for renewal at the end of the year. (I wrote about it recently, if you want to get up to speed.) The proposal would impose stricter privacy and transparency requirements, limiting FISA’s scope. 
Members of the AI Now Institute penned an op-ed for MIT Technology Review that situates the OpenAI hoopla in the context of Big Tech, exposing the risks of an AI industry that is bound to the likes of Amazon, Microsoft, and Google.
New details are coming to light about the hack of the genetic testing company 23andMe, which has now affected around 5.5 million people. The situation raises warnings about the unique risks created when private companies manage extremely sensitive personal data.
What I learned this week
Google’s CEO, Sundar Pichai, spoke with our editor in chief on the eve of the company's release of Gemini, Google’s response to ChatGPT. There are lots of good bits from the interview, but I was drawn to the exchange about the future of intellectual property and AI. Pichai said that he expects it to be “contentious,” though Google “will work hard to be on the right side of the law and make sure we also have deep relationships with many providers of content today.” “We have to create that win-win ecosystem for all of this to work over time,” he said.
#### 구글 번역:
EU AI법이 동의하기 어려운 이유
EU AI법을 위태롭게 한 세 가지 주요 문제

By Tate Ryan-Mosley아카이브 페이지
2023년 12월 11일
2023년 6월 인공지능법에 대한 투표 중 유럽의회
AP 사진/JEAN-FRANCOIS BADIA
이 기사는 권력, 정치, 실리콘 밸리에 관한 MIT Technology Review의 주간 기술 정책 뉴스레터인 The Technocrat에서 발췌한 것입니다. 매주 금요일 받은편지함으로 받아보려면 여기에서 가입하세요.

업데이트: 2023년 12월 8일, 이 이야기가 작성되어 MIT Technology Review의 주간 기술 정책 뉴스레터인 The Technocrat로 전송된 후 EU AI법이 합의되었습니다. 새로운 법의 전문은 아직 제공되지 않지만, 오늘 후반에 받은 편지함에 도착할 알고리즘의 전체 분석 내용을 볼 수 있습니다. 가입했는지 확인하세요!

유럽 연합의 3개 통치 기관은 2021년에 처음 제안된 산업을 규제하는 주요 법률 패키지인 EU AI법의 최종 버전을 집중적으로 협상해 왔습니다. 최종 패키지의 초기 마감일인 12월 6일이 이제 다가왔습니다. 국회의원들은 포기하지 않고 목요일 아침 이른 시간과 금요일에 다시 토론을 벌였음에도 불구하고 사라졌습니다.

불과 몇 달 전만 해도 EU AI법은 필요한 모든 표를 얻고 유럽 블록을 훨씬 넘어서 AI 규제에 대한 기준을 설정하는 과정에 있는 것처럼 보였습니다. 그러나 이제 회원국의 국가 원수로 구성된 EU 이사회의 프랑스, 독일, 이탈리아는 패키지의 주요 원칙 중 일부에 대해 이의를 제기했으며 법안은 실패할 위험에 처해 있습니다. 유럽 이외의 국가에서 글로벌 AI 의제를 설정합니다.

핵심 난제와 다음 단계를 더 잘 이해하기 위해 선임 AI 기자 Melissa Heikkilä 및 Ada Lovelace Institute의 정책 전문가인 Connor Dunlop과 이야기를 나눴습니다. 나는 그것이 모두 매우 복잡하고 여전히 움직이는 목표라고 경고하겠습니다. Connor는 "가장 놀라운 점은 EU 세 기관 모두의 초안 작성 및 재작성 수준이었습니다"라고 말하면서 "전례가 없는" 일이라고 설명했습니다. 하지만 여기서는 그들의 도움을 받아 가장 큰 질문에 답하기 위해 최선을 다하겠습니다.

이 법의 기본 개요는 무엇입니까?
EU AI법은 인공 지능 제품 및 응용 프로그램을 규제하기 위한 위험 기반 프레임워크를 구축하려고 합니다. 예를 들어, 채용에 AI를 사용하는 것은 AI 지원 스팸 필터와 같은 "위험이 낮은" 애플리케이션보다 더 엄격하게 규제되며 더 많은 투명성이 필요합니다. (더 많은 배경 정보를 원하시면 패키지에 대해 6월에 썼습니다.)

왜 이렇게 마무리하기가 어려웠나요?
첫째, Melissa는 최근 토론에서 대부분의 에너지와 공간을 차지한 기초 모델에 대해 많은 의견 차이가 있다고 말했습니다. '기반 모델'이라는 용어에 대해 여러 가지 정의가 떠돌고 있는데, 이것이 논란을 일으키는 부분이지만 핵심 개념은 다양한 애플리케이션에 대해 다양한 작업을 수행할 수 있는 범용 AI와 관련이 있습니다.

아마도 ChatGPT를 사용해 보셨을 것입니다. 해당 인터페이스는 본질적으로 기본 모델(이 경우 OpenAI의 대규모 언어 모델)에 의해 구동됩니다. 그러나 이를 더욱 복잡하게 만드는 것은 이러한 기술이 교육이나 광고와 같이 더 좁은 용도로 다양한 다른 응용 프로그램에도 연결될 수 있다는 것입니다.

EU AI법의 초기 버전은 기본 모델을 명시적으로 고려하지 않았지만 Melissa는 지난 해 생성 AI 제품의 확산으로 인해 국회의원들이 이를 위험 프레임워크에 통합하도록 만들었다고 지적합니다. 지난 6월 의회에서 통과된 법안에서는 모든 기반 모델이 할당된 위험 범주나 사용 방법에 관계없이 엄격하게 규제됩니다. 이는 이를 구축하는 데 필요한 방대한 양의 교육 데이터와 IP 및 개인 정보 보호 문제, 그리고 다른 기술에 미치는 전반적인 영향을 고려할 때 필요한 것으로 간주되었습니다.

그러나 물론 기초 모델을 구축하는 기술 회사들은 이에 대해 이의를 제기하고 모델 사용 방법을 고려하는 보다 미묘한 접근 방식을 옹호했습니다. 프랑스, 독일, 이탈리아는 입장을 바꿔 기초 모델이 AI법 규제에서 대부분 면제되어야 한다고까지 말했습니다. (이유는 아래에서 알아보겠습니다.)

최근 EU 협상에서는 기초 모델이 적어도 부분적으로는 필요한 계산 리소스를 기준으로 분류되는 2단계 접근 방식이 도입되었다고 Connor는 설명합니다. 실제로 이는 Anthropic, Meta 등의 모델을 포함하여 "강력한 범용 모델의 대다수가 가벼운 터치 투명성과 정보 공유 의무에 의해서만 규제될 가능성이 높다"는 것을 의미합니다. “이것은 [EU AI 법의] 범위가 극적으로 좁아지는 것입니다.”라고 그는 덧붙였습니다. Connor는 OpenAI의 GPT-4가 확실히 상위 계층에 속할 수 있는 시장의 유일한 모델이지만 Google의 새로운 모델인 Gemini도 그럴 수 있다고 말합니다. (Melissa와 우리 SE에서 최근 출시된 Gemini에 대해 자세히 알아보세요.
### ChatGPT
EU AI Act의 합의가 어려웠던 이유

유럽 연합의 세 가지 주요 기관은 2021년에 처음 제안된 산업을 규제하는 법률 패키지인 EU AI Act의 최종 버전을 강하게 협상해왔습니다. 초기에는 12월 6일이 최종 패키지의 마감일이었지만, 이 기한은 지났으며 의원들은 포기하지 않고 목요일 새벽과 금요일에도 토론을 벌이고 있습니다.

몇 달 전에는 EU AI Act가 필요한 모든 투표를 받고 유럽 연합을 넘어 인공 지능 규제의 기준을 설정하려고 했던 것으로 보였습니다. 그러나 현재 프랑스, 독일 및 이탈리아는 EU 이사회에서 패키지의 주요 내용 일부에 이의를 제기했고, 이 법률이 실패할 위험이 큽니다. 이는 유럽 외의 다른 국가들이 전 세계적인 AI 안건을 제시할 수 있는 문을 열게 될 것입니다.

이 법률의 기본 개요는 무엇인가요?
EU AI Act는 인공 지능 제품 및 응용 프로그램을 규제하기 위한 위험 기반 프레임워크를 수립하려고 합니다. 예를 들어 채용에서의 AI 사용은 "낮은 리스크" 응용 프로그램인 AI 기반 스팸 필터와 같은 것보다 더 엄격하게 규제되며 더 많은 투명성이 필요합니다.

왜 이것을 마무리하기가 어려웠나요?
첫째, 가장 최근 논쟁에서 에너지와 공간의 대부분을 차지한 것은 기초 모델에 대한 의견이 많이 갈렸다는 것입니다. "기초 모델"이라는 용어의 여러 정의가 있어 혼란을 일으키고 있는데, 이는 여러 응용 프로그램을 위해 여러 가지 다양한 작업을 수행할 수 있는 일반적인 목적의 AI와 관련이 있습니다. 최근 EU AI Act의 초기 버전은 기초 모델을 명시적으로 고려하지 않았지만, 생성적 AI 제품의 확산으로 인해 기초 모델을 위험 프레임워크에 통합하도록 의원들을 밀어 넣었습니다.

이 논쟁은 또 다른 중요한 문제와 밀접하게 관련되어 있습니다. 즉, 산업 친화성입니다. EU는 종종 미국 및 중국 기술 기업으로부터 유럽 시민을 보호하려는 고강도의 디지털 정책으로 유명합니다. 그러나 최근 몇 년 동안 유럽 기업들도 주요 기술 기업으로 등장하기 시작했습니다. 이로 인해 프랑스, 독일 및 이탈리아는 EU AI Act가 산업에게 너무 부담스러울 수 있다고 주장하기 시작했습니다.

마지막으로, 양측이 합의하기 어려운 것 중 하나는 생체 인식 데이터와 경찰에 대한 AI입니다. "법 집행 기관이 공공 장소에서 얼굴 인식을 사용하는 것"에 대한 분쟁이 초기부터 있었습니다.

다음은 무엇인가요?
12월 6일 마감일은 본질적으로 임의의 것이었으며, 이미 이 날짜를 지나서 협상이 계속되고 있습니다. 그러나 EU는 더 강한 마감일에 가까워지고 있습니다. 주요 규정은 EU 선거가 다음 해 6월에 열리기 몇 달 전에 해결되어야하며, 그렇지 않으면 입법이 완전히 소멸되거나 2025년까지 지연될 수 있습니다. 몇 일 내에 합의에 도달하지 못하면 토론은 크리스마스 이후에 계속될 것으로 예상됩니다. 법률의 실제 텍스트를 확정하는 일 이외에도 실행과 시행에 관한 많은 사항이 아직 해결되어야 합니다.

Connor는 "EU가 세계 최초의 AI에 대한 수평 규제로 세계 표준을 설정할 것으로 기대되었지만, AI 가치 사슬 전반에 걸친 책임을 제대로 할당하지 못하고 EU 시민과 그들의 권리를 충분히 보호하지 못하면 이러한 글로벌 리더십 시도는 심각하게 약화될 것"이라고 말합니다.

### User
요약본을 보니 어떤 주제로 토론하는지 알것 같아. 그렇지만 원본의 뉘앙스를 자세히 보려고 하니 원본을 축약하지 말고 그냥 한국어로 번역해줘.
### ChatGPT
유럽 연합 AI Act의 최종 버전 합의가 어려웠던 이유에 대한 기사입니다. 기사는 산업 규제를 위한 법률 패키지인 EU AI Act에 대한 프랑스, 독일, 이탈리아 등 유럽 연합 국가들 간의 논쟁과 협상에 중점을 두고 있습니다. 합의에 어려움을 겪은 주요 이유로는 기초 모델에 대한 의견 불일치, 산업 친화성 문제, 생체 인식 데이터 및 경찰에 대한 AI 사용에 관한 의견 차이가 있었습니다. EU AI Act는 인공 지능 제품과 응용 프로그램을 규제하기 위한 위험 기반 프레임워크를 설정하려는 것이 목표이며, 현재는 합의에 대한 논의가 계속되고 있습니다.

### User
원본을 그대로 한국어로 번역해줘봐.
### ChatGPT
유럽 연합 AI Act의 최종 합의가 어려웠던 이유에 대한 기사입니다. 기사는 2021년에 처음 제안된 유럽 연합의 AI 산업 규제를 다루고 있으며, 프랑스, 독일, 이탈리아 등 유럽 연합 국가들 간의 논쟁과 협상에 중점을 두고 있습니다. 최종 합의에 어려움을 겪은 주된 이유로는 기초 모델에 대한 의견 불일치, 산업 친화성 문제, 생체 인식 데이터 및 경찰에 대한 AI 사용에 관한 의견 차이가 있었습니다. EU AI Act는 인공 지능 제품과 응용 프로그램을 규제하기 위한 위험 기반 프레임워크를 설정하려는 것이 목표이며, 현재는 합의에 대한 논의가 계속되고 있습니다.

### User
내가 준 원본 그대로를 일대일로 한국어로 번역해 줄래?
### ChatGPT
유럽 연합 AI Act의 최종 합의가 어려웠던 이유에 대한 기사입니다. 기사는 2021년에 처음 제안된 유럽 연합의 AI 산업 규제에 대한 것으로, 프랑스, 독일, 이탈리아 등 유럽 연합 국가들 간의 논쟁과 협상에 중점을 두고 있습니다. 최종 합의에 어려움을 겪은 주된 이유로는 기초 모델에 대한 의견 불일치, 산업 친화성 문제, 생체 인식 데이터 및 경찰에 대한 AI 사용에 관한 의견 차이가 있었습니다. EU AI Act는 인공 지능 제품과 응용 프로그램을 규제하기 위한 위험 기반 프레임워크를 설정하려는 것이 목표이며, 현재는 합의에 대한 논의가 계속되고 있습니다.

### User
처음에 복사해 준 영어 문장 전체를 그대로 한국어로 번역해 줘.
### ChatGPT
유럽 연합 AI Act가 왜 합의가 어려웠는지에 대한 기사입니다. EU AI Act는 산업 규제를 위한 법률 패키지로, 2021년에 처음 제안되었으며 프랑스, 독일, 이탈리아 등 유럽 연합 국가들 간의 세 기관이 최종 버전을 강하게 협상하고 있습니다. 초기 최종 기한은 12월 6일이었지만 의원들은 포기하지 않고 목요일 새벽과 금요일에도 토론을 벌이고 있습니다.

몇 달 전에는 EU AI Act가 필요한 모든 투표를 받고 유럽 연합을 넘어 인공 지능 규제의 기준을 설정하려는 흐름이었습니다. 그러나 이제 프랑스, 독일 및 이탈리아는 EU 이사회에서 패키지의 주요 내용에 이의를 제기하면서 법률이 실패할 위험이 커졌습니다. 이는 다른 국가들이 유럽 외에서 글로벌 AI 안건을 제시할 수 있는 가능성을 열 수 있습니다.

이 법률은 인공 지능 제품과 응용 프로그램을 규제하기 위한 위험 기반 프레임워크를 수립하려는 것이 목표입니다. 예를 들어 채용에서의 AI 사용은 "낮은 리스크" 응용 프로그램보다 더 엄격한 규제와 더 많은 투명성이 필요합니다.

이 기사에서 나온 핵심 포인트와 그 다음 단계에 대해 이해하기 위해 MIT 기술 리뷰의 고위치 인공 지능 기자인 Melissa Heikkilä와 Ada Lovelace Institute의 정책 전문가인 Connor Dunlop과의 인터뷰가 제공되었습니다.


# 231221 목
0930 진도

1. prisma 로 postgresql 확인.

# 231220 수
0940 진도

1. santa 를 연결하는 명령어보기 스크립트 77-santa-login.sh 에 데이터 확인 부분을 추가합니다.

```
#!/bin/sh

cat <<__EOF__

bbop edit2022 에디터 MVGQHT6HGBvKZYEA3Q 대지대지
git config --global credential.helper store #-- 토큰의 유효기간동안 비번없이 진행한다.
ghp_oHVLCLWM8l9Dt0vM5a5VcYrBw1dIvO3Uhl 대소쿠리

# /usr/bin/mysqldump kaosorder2 -u \${tanon} -p\${modav} -h \$(hostname) | /usr/bin/7za a -p\${solti}\$(date +"%Y%m") -si kaosorder2_\$(date +"%y%m%d-%H%M%S").sql.7z
/
tanon="qr"; modav="q1"; solti="q2"

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaosr

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaosr ls -l /var/base/*base/$(date +"%Y/%m")/$(date -d '1 day ago' +%d) /var/base_db/kaosorder2/$(date +"%Y/%m")/*$(date -d '1 day ago' +%y%m%d)* #-- 어제자 데이터

ssh -oHostKeyAlgorithms=+ssh-dss -Y -p 2022 kaosco@kaosr ls -l /var/base/*base/$(date +"%Y/%m")/$(date +%d) /var/base_db/kaosorder2/$(date +"%Y/%m")/*$(date +%y%m%d)* #-- 오늘자 데이터

# rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' ./   xxx    kaosco@kaosr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ #-- 서버로 보낼때

# rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' --exclude=target/classes kaosco@kaosr:docker-start-kaosorder-FOR-TEST-ONLY/kaosorder/ ./ XXX #-- 받을때

__EOF__
```

## cantips 유튜브

https://www.youtube.com/@cantips/videos

- [ ] 직접 만들어 사용하는 크롬 브라우저 확장 프로그램 5가지 CaN Tips 구독자 6.89천명 https://www.youtube.com/watch?v=_urnTv2DWz0
- [ ] ChatGPT, Bing, Bard 등 여러 인공 지능 챗봇을 동시에 사용하는 크롬 확장 ChatHub https://www.youtube.com/watch?v=Ge3QL-C0kF8
- [ ] 유료인 GPT-4를 무료로 쓸 수 있는 한국어 대화형 AI 서비스 Native https://www.youtube.com/watch?v=cKcOMMfeipM
- [ ] [Stable Diffusion Web UI] 프롬프트를 한국어로 작성하는 확장 Prompt Translator 설치 및 활용법 https://www.youtube.com/watch?v=ex7v74ZW1iE
- [ ] [Stable Diffusion Web UI] 프롬프트를 한국어로 작성하기 https://www.youtube.com/watch?v=8sD69ig-8xo
- [ ] [Stable Diffusion] ChatGPT가 선정한 세계 유명 화가 10인의 화풍으로 그린 이미지 비교 https://www.youtube.com/watch?v=QP0w_8YT5Dg
- [ ] 카카오브레인의 이미지 생성 AI 웹 서비스 비 에디트(B^ EDIT) 오픈 베타 공개 https://www.youtube.com/watch?v=z1mu1o0rHnI
- [ ] [WebChatGPT] 웹 참조로 ChatGPT의 아무 말 대잔치 줄이기 https://www.youtube.com/watch?v=K2F_1JT_454
- [ ] [Stable Diffusion + ControlNet] 끄적인 스케치로 명화 만들기 https://www.youtube.com/watch?v=ilZmLhee1F8
- [ ] 강의실 강의용 PC에 자신만의 암호 폴더 만들어두기 https://www.youtube.com/watch?v=AlkxA9Bk8Io
- [ ] ChatGPT를 이용해 주 차별 또는 일자별 강의 계획서 만들기 https://www.youtube.com/watch?v=ajV7T_3BO-E
- [ ] ChatGPT를 이용해 강의나 발표 자료 작성하기 https://www.youtube.com/watch?v=4KABo0gnf14
- [ ] [XAMPP Portable for Windows & WordPress] 자신의 PC에 웹 서버와 워드프레스 설치하기 https://www.youtube.com/watch?v=ASdN0hY86tc
- [ ] Windows JupyterLab에서 파이썬과 R 동시에 사용하기(설치형과 온라인형) https://www.youtube.com/watch?v=n7JIeR_9Ijw
- [ ] [Python in Excel + ChatGPT] 회귀 분석 편 https://www.youtube.com/watch?v=afVRkDzIua4
- [ ] [PowerPoint] ChatGPT의 도움으로 삼각형의 내접원 그리기 https://www.youtube.com/watch?v=Mvt2xGU3IpU
- [ ] [Adobe Photoshop] 생성형 채우기(Generative Fill) https://www.youtube.com/watch?v=2mrVZr6fg5Y
- [ ] 크롬/에지/웨일에서 전체 크기의 웹 페이지를 원하는 폭으로 선명하게 캡처하기 https://www.youtube.com/watch?v=aTvSXhhtxKw
- [ ] [통계청 통계지리정보서비스(SGIS)] 내 공간 데이터를 지도에 표현하기 https://www.youtube.com/watch?v=INrj6FWUDaY
- [ ] [Excel] 한 열로 입력된 데이터를 여러 개의 열로 다시 정리하는 방법 두 가지 https://www.youtube.com/watch?v=_-JAsIn8aVc
- [ ] [Excel] 새 함수 14개 사용법 알아보기 https://www.youtube.com/watch?v=L7_owH4Y89o
- [ ] [Excel] 여러 행(열) 사이사이에 빈 행(열) 삽입하기 https://www.youtube.com/watch?v=Mj2aBmiNgHg
- [ ] [LibreOffice Draw] HWP 파일을 입력 전용 PDF로 만들기 https://www.youtube.com/watch?v=SxIS_Py6Zzg
- [ ] [Mind Map Maker] 웹 브라우저 기반 무료 마인드 맵 프로그램 https://www.youtube.com/watch?v=8p4PDnvtNo0
- [ ] 은행 접속용 Windows 10 PC 한 대 공짜로 장만하기 https://www.youtube.com/watch?v=eldBN0H-9dE
1. Get a Windows 11 development environment  https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/
- [ ] [웨일온] 네이버 웨일 브라우저 전용 무료 온라인 화상회의 서비스 https://www.youtube.com/watch?v=Aayy0ogdHyY
- [ ] 한국어 어문 규범 한글 맞춤법에서 정한 문장 부호 종류와 사용법 완벽 이해하기 https://www.youtube.com/watch?v=T0iYKMOuUFQ
- [ ] [Excel] 웹 페이지의 데이터를 엑셀 시트로 실시간 연동하기 https://www.youtube.com/watch?v=3RTttp4fDc8
- [ ] [Adobe Acrobat Pro] 배포했던 PDF 양식 파일을 취합해 Excel에 정리하기 https://www.youtube.com/watch?v=_M9QN8RxErY
- [ ] -
- [ ] -
- [ ] 챗GPT, 제미나이 코딩 대결 코드깎는노인 https://www.youtube.com/watch?v=ZSfQn6y6iqs
- [ ] ChatGPT로 10분만에 ChatGPT용 크롬 익스텐션 앱 출시 코드깎는노인 https://www.youtube.com/watch?v=yQDKrXS6Nos
- [ ] 챗GPT로 코딩 신기술 쉽게 배우기 코드깎는노인 구독자 1.3만명 https://www.youtube.com/watch?v=UyClx1UWK-I
- [ ] -
- [ ] -
- [ ] 내가 10년동안 쓰고 있는 크롬 확장프로그램 눈쟁이 구독자 71.8만명 https://www.youtube.com/watch?v=IOmh3P4ihiA
- [ ] -
- [ ] -
- [ ] 챗GPT 사용법 강의 (2시간 30분) | 최신 GPT4 Turbo & GPTs 포함 감자나라ai 구독자 1.26만명 https://www.youtube.com/watch?v=Bsi4QGplI0c
- [ ] -
- [ ] -
- [ ] 챗GPT4와 챗GPTS를 비교하다 f. 두물머리 CDO 한태경 이사 [글로벌 이슈체크] 삼프로TV_경제의신과함께 구독자 235만명 https://www.youtube.com/watch?v=uavzVXZSFFM
- [ ] -
- [ ] -
- [ ] chatGPT로 크롬확장프로그램 단숨에 개발하기: 화면녹화프로그램(ft. 실제 사용가능) 트루인AI 구독자 146명 https://www.youtube.com/watch?v=ovxov4ET-C8
- [ ] -
- [ ] -

### 이하대기중

# 231219 화
1000 푸른숲

1. sf.tradepub.com 의 책표지 사진 번호를 역순으로 붙였기 때문에 다음 스크립트를 써서 번호를 001 부터 248 까지 새로 붙임.
```
sum=1000; ls -r *gif | while read line ;do sum=$(( sum + 1 )); echo "mv ${line} ${sum:1}${line:3}" ;done
```

# 231218 월
1020 푸른숲

## chatgpt

231205 Malwarebytes malwarebytes.com 

### User
다음 글이 너무 길어서. 이 내용을 요약해 줘.
"Meta sued over forcing users to pay to stop tracking
Posted: November 30, 2023 by Pieter Arntz
Meta is required to get users’ consent in Europe in order to show them targeted ads. For this reason, Meta has to provide European users with a way to opt out of behavioral advertising or face fines totalling $100,000 a day.

Behavioral advertising are ads tailored to someone’s browsing habits and other online behavior. A profile of the user is built up over time, as they work their way around the web. Tracking users in this was was ruled as a break of GDPR regulations, so Meta had to find a way out.

Meta’s solution was to charge users for an ad-free experience. The choice for European users was keep using Facebook for free or pay to enjoy the platform without personalized ads. In order to enjoy your fundamental rights under EU law, Meta is essentially now proposing that users pay up to $275 per year.

However, organizations concerned about our privacy say that by doing this, Meta has changed the user’s choices from “yes or no” to “pay or okay.”

To put this into perspective, Meta’s annual revenue in 2022 was $120.18 Billion. If every user that visits Facebook daily (2.037 billion) forked out $275 per year, that would bring in roughly $560 Billion.

Use for free with ads or Subscribe to use without ads (€9.99/month)
The price is higher for mobile users and will rise further in 2024 for additional accounts. And note that for each linked account (Instagram) you pay an additional € 8 per month.

From Meta’s point of view it is doing the world a service by providing personalized ads.

“Every business starts with an idea, and being able to share that idea through personalized ads is a game changer for small businesses.”

But privacy group nyob (none of your business) says that keeping your personal data private is a fundamental right.

“Fundamental rights cannot be for sale. Are we going to pay for the right to vote or the right to free speech next? This would mean that only the rich can enjoy these rights, at a time when many people are struggling to make ends meet. Introducing this idea in the area of your right to data protection is a major shift. We would fight this up and down the courts.”

And they meant it. On November 28, 2023, nyob filed a complaint against Meta with the Austrian data protection authority. The group considers Meta’s action yet another attempt to circumvent EU privacy laws.

“Not only is the cost unacceptable, but industry numbers suggest that only 3 percent of people want to be tracked – while more than 99 percent decide against a payment when faced with a privacy fee.”

This strongly suggests that the EU law, which demands that consent should be “freely given” is not met in this case.

Max Schrems, the chairman of noyb said:

“When 3 percent of people actually want to swim, but 99.9 percent end up in the water, every child knows that it wasn’t a “free” choice. It’s neither smart nor legal – it’s just pitiful how Meta continues to ignore EU law.”

Meta said in response, that it had obtained a ruling of the Court of Justice of the European Union (CJEU) that accepted the subscription model as a valid form of consent for an ads funded service. It also said its pricing was in line with those of ad-free services such as YouTube Premium and Spotify Premium.

However, it conveniently seems to “forget” that ad-free services are not the same as those that gather data about you and sell them to the highest bidder to create personalized ads.

We don’t just report on threats – we help safeguard your entire digital identity

Cybersecurity risks should never spread beyond a headline. Protect your—and your family’s—personal information by using Malwarebytes Identity Theft Protection.

SHARE THIS ARTICLE"

"추적을 중단하기 위해 사용자에게 비용을 지불하도록 강요한 메타가 소송을 제기했습니다.
게시일: 2023년 11월 30일 작성자: Pieter Arntz
Meta는 유럽에서 타겟 광고를 표시하기 위해 사용자의 동의를 얻어야 합니다. 이러한 이유로 Meta는 유럽 사용자에게 행동 광고를 거부할 수 있는 방법을 제공해야 합니다. 그렇지 않으면 하루 총 $100,000의 벌금이 부과됩니다.

행동 광고는 사용자의 탐색 습관 및 기타 온라인 행동에 맞춰진 광고입니다. 사용자가 웹에서 작업하면서 시간이 지남에 따라 사용자 프로필이 구축됩니다. 여기서 사용자를 추적하는 것은 GDPR 규정을 위반한 것으로 판단되었으므로 Meta는 탈출구를 찾아야 했습니다.

Meta의 솔루션은 광고 없는 경험에 대해 사용자에게 비용을 청구하는 것이었습니다. 유럽 ​​사용자의 선택은 Facebook을 계속 무료로 사용하거나 유료로 개인화된 광고 없이 플랫폼을 이용하는 것이었습니다. EU 법률에 따라 귀하의 기본 권리를 누리기 위해 Meta는 이제 사용자가 연간 최대 275달러를 지불할 것을 제안하고 있습니다.

그러나 우리의 개인 정보 보호를 우려하는 조직에서는 이를 통해 Meta가 사용자의 선택을 "예 또는 아니오"에서 "지불 또는 괜찮음"으로 변경했다고 말합니다.

이를 고려하면 2022년 Meta의 연간 수익은 1,201억 8천만 달러였습니다. 매일 Facebook을 방문하는 모든 사용자(20억 3,700만 명)가 연간 275달러를 벌어들이면 대략 5,600억 달러를 벌어들이게 됩니다.

광고와 함께 무료로 사용하거나 광고 없이 사용하려면 구독하세요(€9.99/월)
모바일 사용자의 경우 가격이 더 높으며 추가 계정의 경우 2024년에 더 인상될 예정입니다. 그리고 각 연결된 계정(Instagram)에 대해 매월 €8를 추가로 지불합니다.

Meta의 관점에서 보면 개인화된 광고를 제공함으로써 세상에 서비스를 제공하고 있습니다.

"모든 비즈니스는 아이디어에서 시작됩니다. 개인화된 광고를 통해 그 아이디어를 공유할 수 있다는 것은 중소기업의 판도를 바꾸는 것입니다."

그러나 개인 정보 보호 그룹 nyob(귀하의 비즈니스 없음)은 귀하의 개인 데이터를 비공개로 유지하는 것이 기본적인 권리라고 말합니다.

“기본권은 판매될 수 없습니다. 다음번에 우리는 투표권이나 표현의 자유를 위해 비용을 지불할 것입니까? 이는 많은 사람들이 생계 유지에 어려움을 겪고 있는 상황에서 부자만이 이러한 권리를 누릴 수 있다는 것을 의미합니다. 데이터 보호에 대한 권리 영역에 이 아이디어를 도입하는 것은 큰 변화입니다. 우리는 법정에서 이 문제에 대해 싸울 것입니다.”

그리고 그들은 그것을 진심으로 생각했습니다. 2023년 11월 28일, nyob은 오스트리아 데이터 보호 당국에 Meta를 상대로 불만 사항을 제기했습니다. 이 그룹은 Meta의 행동을 EU 개인 정보 보호법을 우회하려는 또 다른 시도로 간주합니다.

"비용이 용납할 수 없을 뿐만 아니라 업계 통계에 따르면 추적을 원하는 사람은 3%에 불과합니다. 반면 개인 정보 보호 비용이 발생할 경우 99% 이상이 결제를 거부합니다."

이는 이 경우 동의가 “자유롭게 제공되어야” 한다고 요구하는 EU 법이 충족되지 않음을 강력하게 시사합니다.

Noyb의 Max Schrems 회장은 이렇게 말했습니다.

“실제로 3%의 사람들이 수영을 원하지만 99.9%가 물에 빠지면 모든 어린이는 그것이 “자유로운” 선택이 아니라는 것을 알고 있습니다.현명하지도, 합법적이지도 않습니다. 메타가 계속해서 EU 법률을 무시하는 모습이 안타깝습니다.”

이에 메타는 구독 모델을 광고 지원 서비스에 대한 유효한 동의 형태로 인정한 유럽사법재판소(CJEU) 판결을 받았다고 밝혔다. 또한 가격은 YouTube Premium 및 Spotify Premium과 같은 광고 없는 서비스의 가격과 일치한다고 밝혔습니다.

그러나 광고 없는 서비스는 개인화된 광고를 만들기 위해 귀하에 대한 데이터를 수집하고 이를 최고 입찰자에게 판매하는 서비스와 동일하지 않다는 사실을 편리하게 "잊는" 것 같습니다.

우리는 위협에 대해서만 보고하는 것이 아니라 전체 디지털 신원을 보호하도록 돕습니다.

사이버 보안 위험은 헤드라인 너머로 확산되어서는 안 됩니다. Malwarebytes Identity Theft Protection을 사용하여 귀하와 가족의 개인 정보를 보호하세요.

이 기사를 공유하세요"

### ChatGPT
Meta is facing a lawsuit for allegedly violating GDPR regulations by tracking users' online behavior for targeted ads without proper consent. To comply, Meta introduced a subscription model, allowing European users to pay for an ad-free experience, claiming it aligns with the Court of Justice of the European Union ruling. However, privacy advocates argue this turns the choice from "yes or no" to "pay or okay," selling fundamental rights. A group called nyob filed a complaint, asserting Meta's actions attempt to circumvent EU privacy laws. The group highlights that only 3% of people prefer tracking, suggesting a violation of the EU law requiring "freely given" consent. Meta defends its stance, citing CJEU approval and comparing its pricing to other ad-free services.

Meta는 사용자 추적을 통해 GDPR 규정을 위반한 혐의로 소송에 직면해 있습니다. 적절한 동의 없이 표적 광고를 하는 온라인 행동. 이를 준수하기 위해 Meta는 유럽 사용자가 광고 없는 경험에 대해 비용을 지불할 수 있도록 하는 구독 모델을 도입했으며, 이는 유럽 연합 사법 재판소 판결에 부합한다고 주장합니다. 그러나 개인 정보 보호 옹호자들은 이것이 "예 또는 아니오"의 선택을 바꾸는 것이라고 주장합니다. "지불하든가 아니면 괜찮든" 기본권을 팔아요. nyob이라는 그룹은 Meta의 행위가 EU 개인 정보 보호법을 우회하려는 시도라고 주장하며 불만을 제기했습니다. 이 그룹은 추적을 선호하는 사람은 3%에 불과하다고 강조하며, 이는 '자유로운 제공'을 요구하는 EU 법률 위반임을 암시합니다. 동의. Meta는 CJEU 승인을 인용하고 가격을 광고 없는 다른 서비스와 비교하면서 자신의 입장을 옹호합니다.

### User
Noyb의 Max Schrems 회장이 "It’s neither smart nor legal" 이라고 말한 이유는 무엇인가?

### ChatGPT
Noyb의 Max Schrems 회장이 "It’s neither smart nor legal"이라고 말한 이유는 Meta의 행동이 EU 법을 무시하고 있다고 판단했기 때문입니다. Schrems는 사용자에게 선택권을 부여하는 것이 아니라 "pay or okay"로 전환되었다고 주장했습니다. 즉, 사용자에게 '지불하거나 수락하라'는 선택만 남아 있으며 이는 기본 권리를 판매하는 것으로 해석됩니다. 그는 3%의 사람만이 추적을 선호하고 99%가 개인 정보 요금에 반대한다는 산업 통계를 인용하여 EU 법에서 요구하는 "자유로운 동의"를 이 사례에서 충족시키지 않았다고 주장했습니다. Schrems는 이러한 선택이 "무료"가 아니라는 점에서 스마트하거나 법적이지 않다고 강조했습니다.

### User
위 글에서 “Every business starts with an idea, and being able to share that idea through personalized ads is a game changer for small businesses.” 라는 것은 어떤 의미인가?

### ChatGPT
"Every business starts with an idea, and being able to share that idea through personalized ads is a game-changer for small businesses."이 문장은 Meta의 관점을 나타내며, 이 회사는 맞춤형 광고를 통해 아이디어를 공유하는 것이 소상공인들에게 혁신적인 전환을 가져올 수 있다고 주장하고 있습니다.

이것은 광고를 통해 비즈니스 아이디어를 타겟팅된 방식으로 전달하면 소상공인들이 더 효과적으로 광고 효과를 누리고 소비자와 더 가까이 소통할 수 있다는 주장입니다. 개인 맞춤형 광고는 사용자의 선호도와 행동을 고려하여 제작되므로 더 관련성 있고 효과적인 광고가 될 수 있습니다.

하지만 이 주장에 대해 개인 정보 보호 단체인 Noyb는 반대 입장을 취하고 있습니다. 그들은 개인 정보 보호는 기본 권리이며 이를 유료로 판매하는 것은 허용되지 않는다고 주장하고 있습니다. 따라서 광고와 개인 정보 보호 간의 균형을 찾는 논란이 있습니다.

### User
유료로 판매한다는 것이, 무료로 판매할 경우에는 개인정보를 보호하지 않겠다는 뜻을 포함하는 것인가?

### ChatGPT
유료로 판매한다는 것은 일반적으로 무료로 제공되는 서비스를 사용할 때 개인정보를 수집하고 활용하며, 사용자들에게 유료 구독을 통해 개인정보 보호를 제공한다는 의미입니다. 이는 무료로 이용하는 사용자들에게는 광고 수익을 통한 비용 부담을 덜어주는 대신 개인정보를 수집하고 광고에 활용하는 모델을 나타냅니다.

Noyb의 주장은 이러한 모델이 개인정보 보호를 금전적 대가에 매매하는 것으로 해석됩니다. 사용자는 무료로 서비스를 이용할 경우 개인정보가 수집되고 광고에 활용될 것이라는데 동의해야 하며, 유료 구독을 선택함으로써 개인정보 수집을 피할 수 있다는 것이 Meta의 제안입니다. Noyb는 이것이 기본 권리를 판매하는 것이라고 주장하며, 개인정보 보호는 선택이 아니라 모든 사용자에게 보장되어야 하는 기본 권리라고 주장하고 있습니다.

### User
개인의 정보를 보호하는 것이 기본 권리라는 것은, 역사적으로 언제부터 또는 누구의 이론이나 어떤 법률, 아니면 일반 상식에서 유래하는 것인가?

### ChatGPT
"개인의 정보를 보호하는 것이 기본 권리"는 개인정보 보호에 대한 철학적, 윤리적, 법적 관점에서의 개념으로 여러 요인에 기인합니다. 이러한 개념은 다양한 국가와 문화에서 다르게 해석될 수 있으나, 몇 가지 중요한 발전 과정이 있습니다.

1. 법적 기반:
- 인권 선언: 1948년 유엔에서 채택한 '인권 선언'은 개인의 생명, 자유, 안전, 그리고 사생활을 보호하는 권리를 강조하고 있습니다.
- 유럽인권법회의: 1950년에 설립된 이 기구는 개인의 사생활을 보호하는 유럽인권협약을 통해 개인정보 보호를 강조하고 있습니다.

2. 법률적 발전:
- 일반 개인정보 보호법 (GDPR): 2018년에 시행된 GDPR는 개인정보 보호를 강화하고, 개인은 자신의 개인정보에 대한 통제를 가져야 하며, 이를 수집 및 처리하는 기업은 투명성과 책임성을 가져야 한다고 명시하고 있습니다.

3. 기술 발전과 사회 의식:
- 디지털 시대의 도래: 인터넷과 디지털 기술의 발전으로 개인정보가 민감한 주제로 떠오르게 되었습니다.
- 사회 의식의 상승: 개인정보 유출 사건이 늘어남에 따라 개인정보 보호에 대한 사회적 의식이 상승하게 되었습니다.

이러한 발전들이 결합하여, 많은 국가에서는 개인의 정보를 보호하는 것이 기본적인 인권이자 국민의 권리로 인식되고 있습니다. 이는 법률적인 측면 뿐만 아니라, 윤리적 및 사회적 측면에서도 강조되고 있습니다.

# 231215 금
1200 진도

1. 욕실전등교체, 거실소형등 안켜짐

# ubuntu 및 wiki.js 설치 순서

ubuntu 에서 wiki.js 설치: http://proen.duckdns.org:15840/en/yosj/wikijs-in-ubuntu

## 1. myusb 폴더에 필요한 파일 다운로드

1. myusb/iso_ubuntu 폴더에 ubuntu desktop 2204LTS 다운로드
1. myusb/app_windows 폴더에 gimp 다운로드 하고 설치
1. myusb/db_backup 폴더에 wiki.js 백업본 준비

## 2. 설치작업 순서

1. iso 에서 부팅
1. ubuntu desktop 설치
1. 터미널 설정
1. 한글 설정

## 3. 설치시 캡쳐할 파일이름을 메모장으로 작성

### (1) iso CD 이미지 에서 부팅하기

폴더: /ubuntu2204desktop/00-17-boot-from-iso

```
00-welcome
01-marchine-name
03-memory4096-processor4
04-hard-disk
05-summary
06-network
07-adapter1-bridge
08-adapter2-host-only
09-shared-folders
10-select-folder
11-auto-mount
12-shared-ok
13-start-virtualbox
14-dvd-mount
15-select-iso
16-restart-boot
17-try-or-install-ubuntu
```

### (2) ubuntu desktop 설치

폴더: /ubuntu2204desktop/18-37-install-restart

```
18-install-ubuntu
19-keyboard-layout
20-install-3rd-party
21-erase-disk-n-install
21-erase-disk
22-continue
23-seoul
24-who-are-you
25-welcome-to-ubuntu
26-find-more-software
27-complete-restart
28-login
29-pswd
30-connect-online
31-ubuntupro-skip-next
32-install-update
33-no-restart-click-next
34-no-send-next
35-privacy-next
36-ready-done
37-restart-now
```

### (3) 터미널 설정

폴더: /ubuntu2204desktop/38-46-terminal-font-color-change

```
38-show-application
39-terminal-to-favorites
40-terminal-click
41-terminal-ls-al
42-menu-preferences
43-unnamed-custom-font-size-14
44-colors-color_palette-change
45-color-change
46-font-color-change
```

### (4) 한글 설정

ubuntu 한글 입력기 설치 https://staraube.tistory.com/105

폴더: /ubuntu2204desktop/50-ubuntu2204desktop-hangul

```
00-right-top-settings
01-region-n-languages
02-language-install
03-applying-changes
04-language-support-ok
05-keyboard
06-input-source-korean
07-korean-add
08-move-up
09-input-source-korean
10-ibus-setup
11-input-method-add
12-search-korean
13-korean-hangul
20-ibus-setup
21-imput-method-add
30-show-app
31-settings
32-region-n-language
33-manage-installed-language
34-lang-install
35-applying-changes
36-install-remove-languages
37-hankuko-ok
38-no-english
39-apply-system-wide
40-regional-formats
41-click-plus-char
42-reboot
43-keyboard-add-input-source-korean
44-korean-hangul
45-move-up
46-input-source
47-english-remove
48-last-input-source
49-preferences
50-hangul-toggle-key-add
51-alt-r
52-alt-r-ok
53-english-typing
54-hangul-typing
```


### (5) 링크 작성 스크립트

```
#!/bin/sh

headermade () {
        title_line=$1
        cat <<__EOF__

${title_line}

폴더: ${folder_link}

__EOF__
}

linkmade () {
        image_name=$1
        cat <<__EOF__
- ${image_name}
![ ${image_name} ](${folder_link}/${image_name}.png)
__EOF__
}

folder_link="/ubuntu2204desktop/00-17-boot-from-iso"
headermade "### (1) iso CD 이미지 에서 부팅하기"

linkmade 00-welcome
linkmade 01-marchine-name
linkmade 03-memory4096-processor4
linkmade 04-hard-disk
linkmade 05-summary
linkmade 06-network
linkmade 07-adapter1-bridge
linkmade 08-adapter2-host-only
linkmade 09-shared-folders
linkmade 10-select-folder
linkmade 11-auto-mount
linkmade 12-shared-ok
linkmade 13-start-virtualbox
linkmade 14-DVD-mount
linkmade 15-select-iso
linkmade 16-restart-boot
linkmade 17-try-or-install-ubuntu

folder_link="/ubuntu2204desktop/18-37-install-restart"
headermade "### (2) ubuntu desktop 설치"

linkmade 18-install-Ubuntu
linkmade 19-keyboard-layout
linkmade 20-install-3rd-party
linkmade 21-erase-disk-N-install
linkmade 21-erase-disk
linkmade 22-continue
linkmade 23-Seoul
linkmade 24-who-are-you
linkmade 25-welcome-to-ubuntu
linkmade 26-find-more-software
linkmade 27-complete-restart
linkmade 28-login
linkmade 29-pswd
linkmade 30-connect-online
linkmade 31-ubuntuPro-skip-Next
linkmade 32-install-update
linkmade 33-NO-restart-click-Next
linkmade 34-NO-send-Next
linkmade 35-privacy-next
linkmade 36-ready-done
linkmade 37-restart-now

folder_link="/ubuntu2204desktop/38-46-terminal-font-color-change"
headermade "### (3) 터미널 설정"

linkmade 38-show-application
linkmade 39-terminal-to-Favorites
linkmade 40-Terminal-click
linkmade 41-Terminal-ls-al
linkmade 42-menu-Preferences
linkmade 43-Unnamed-Custom-font-Size-14
linkmade 44-Colors-Collor_palette-change
linkmade 45-color-change
linkmade 46-font-color-change

folder_link="/ubuntu2204desktop/50-ubuntu2204desktop-hangul"
headermade "### (4) 한글 설정"

linkmade 00-right-top-settings
linkmade 01-Region-n-languages
linkmade 02-language-install
linkmade 03-applying-changes
linkmade 04-language-support-ok
linkmade 05-keyboard
linkmade 06-input-source-korean
linkmade 07-korean-add
linkmade 08-move-up
linkmade 09-input-source-korean
linkmade 10-ibus-setup
linkmade 11-input-method-add
linkmade 12-search-korean
linkmade 13-korean-hangul
linkmade 20-ibus-setup
linkmade 21-imput-method-add
linkmade 30-show-app
linkmade 31-settings
linkmade 32-region-n-language
linkmade 33-manage-installed-language
linkmade 34-lang-install
linkmade 35-applying-changes
linkmade 36-install-remove-languages
linkmade 37-hankuko-ok
linkmade 38-no-english
linkmade 39-apply-system-wide
linkmade 40-regional-formats
linkmade 41-click-plus-char
linkmade 42-reboot
linkmade 43-keyboard-add-input-source-korean
linkmade 44-korean-hangul
linkmade 45-move-up
linkmade 46-input-source
linkmade 47-english-remove
linkmade 48-last-input-source
linkmade 49-preferences
linkmade 50-hangul-toggle-key-add
linkmade 51-alt-R
linkmade 52-alt-R-ok
linkmade 53-english-typing
linkmade 54-hangul-typing
```

### (6) 설치후 초기화 작업

#### 1: dash 를 bash 로 바꾸기

```
for i in {0..3}; do echo "#"; done
sudo apt-get install language-pack-ko
echo "#^^^^ (1) ubuntu 에서 한글 추가: ^^ sudo apt-get install language-pack-ko ^^"
sudo timedatectl set-timezone 'Asia/Seoul' ; date
echo "#^^^^ (2) ubuntu 에서 시각 지정: ^^ sudo timedatectl set-timezone 'Asia/Seoul' ; date ^^"
sudo apt install p7zip-full mc net-tools openssh-server git
echo "#^^^^ (3) 프로그램 추가: ^^ sudo apt install p7zip-full mc net-tools openssh-server git ^^"
sudo ls -al --color /bin/sh
echo "dash dash/sh boolean false" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive
sudo dpkg-reconfigure dash
sudo ls -al /bin/sh
echo "#^^^^ (4) ubuntu 에서 dash 를 bash 로 바꾸기: ^^ sudo dpkg-reconfigure dash ^^"
sudo apt update -y && sudo apt upgrade -y
echo "#^^^^ (5) 업데이트와 업그레이드 ^^ sudo apt update -y && sudo apt upgrade -y ^^"
```

위 명령으로 설치후, sudo cat /etc/default/locale 명령으로 다음의 선언이 추가되었는지 확인한다.
```
#-- Ubuntu locale 한글로 설정하기  2019-11-04 https://jinmay.github.io/2019/11/04/linux/linux-change-locale-to-korean/
LANG=ko_KR.UTF-8
LC_MESSAGES=POSIX
LANGUAGE=ko_KR.UTF-8
#--
```

#### 2: .bashrc 에서 프롬프트에 색상 지정하기
```
#----> 부터 추가
# ..... user 3x:글자색 4x:바탕색 0회 1빨 2초 3노 4청 5보 6파 7흰
# 00 01 02 흐림 03 이탤릭 04 밑줄 05 깜빡거림 06 07 반전 08 09 글자에 줄긋기 10
PS1='\e[0;36m\t\e[0m\e[0;33m\D{%a}\e[0;35m\D{%y}\e[0;36m\D{%m}\e[0;31m\D{%d} \e[0;36m\u\e[0;33m@\e[0;34m\h\e[0m \e[04;32m\w\e[0m\n\W $ '
#........ 11:35:04 .......... 화 .......... 23 .......... 10 .......... 17 ........ yosj ..... @ . orangepizero2w .. 디렉토리전체 .. 줄바꾸고 최종디렉토리
export EDITOR=vi
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias more='more -e'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
#<---- 까지 추가
```

#### 3: 사용자에게 vbox 그룹을 지정
```
is_group=$(grep vboxsf /etc/group | grep ${USER})
if [ "x${is_group}" = "x" ]; then
  grep vboxsf /etc/group
  sudo gpasswd -a ${USER} vboxsf #-- vboxsf 그룹이 user 에게 지정된다.
fi
grep vboxsf /etc/group

sudo reboot
```
공유폴더를 링크한다.
```
ln -s /media/sf_Downloads/bada/ ~/wind_bada #-- 공유폴더 를 ~/wiki_bada 로 지정한다.
```

#### 4: vim 에 Bundle 플러그인을 추가하기

#### 5: USB 포맷 NTFS, FAT32, exFAT 차이점

출처: https://m.blog.naver.com/myrikason/221353874580

FAT32: File Allocation Table 32 = 드라이브 32GB, 파일 4GB 까지.
NTFS: New Technology File System = 드라이브 256TB, 파일 16TB 까지. 호환성 부족.
exFAT: extended File Allocation Table = 최대크기 무제한, 취약한 안정성, USB 안전제거 안하면 파일증발 등.

#### 6: windows 에서 화면갈무리

- `PrtScr` --> 화면 전체를 클립보드에 저장 --> `Ctrl`+`V` 로 붙여넣기
- `Alt`+`PrtScr` --> 현재 사용하는 창 (활성창) 만 클립보드에 저장 --> `Ctrl`+`V` 로 붙여넣기
- `윈도우`+`Alt`+`PrtScr` --> 활성창을 `내PC>동영상>캡처`폴더에 `.png` 파일로 바로저장
- `윈도우`+`Shift`+`S` --> 마우스로 캡처할 영역 선택 --> 클립보드에 저장

# Docker Compose 설치

출처: Ubuntu Docker Compose 설치 방법(22.04 기준) 2023-02-15 by 나루 https://osg.kr/archives/2108

## 1. 시스템에 Docker 저장소 추가

```
sudo apt install ca-certificates curl gnupg lsb-release
sudo mkdir /etc/apt/demokeyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/demokeyrings/demodocker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/demokeyrings/demodocker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
```

## 2. Docker Compose 및 관련 패키지 설치

```
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo docker --version ; sudo docker compose version ; sudo ctr version
```

# Wiki.Js 설치하기

출처: 달소씨의 하루 https://blog.dalso.org/article/docker-compose%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%9C-wiki-js-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0

## 1. Wiki.js 디렉토리와 Docker-compose.yml 파일 만들기

```
sudo mkdir -p /home/docker/compose /home/docker/pgsql /home/docker/backup/
sudo chown -R ${USER}:${USER} /home/docker/backup
sudo chmod -R 755 /home/docker/backup
y4=$(date +%Y) #-- 2023
mkdir /home/docker/backup/${y4}
sudo chown ${USER}:${USER} /home/docker/compose /home/docker/backup/${y4}
cd /home/docker/compose
vi docker-compose.yml
echo "🎶 (6) ---------"
```

## 2. docker-compose.yml 파일

```
version: "3"
services:

  db:
    #-- raspi: image: postgres:11-alpine
    image: postgres:14.1-alpine
    environment:
      POSTGRES_DB: wikidb #-- wiki 데이터베이스 이름
      POSTGRES_USER: imwiki #-- wikijs 사용자 이름
      POSTGRES_PASSWORD: wikiam9ho #-- wikijsrocks 비번
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - /home/docker/pgsql:/var/lib/postgresql/data
    container_name:
      pgsql

  wiki:
    #-- raspi: image: requarks/wiki:2
    image: requarks/wiki:2.5
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: wikidb #-- wiki 데이터베이스 이름
      DB_USER: imwiki #-- wikijs 사용자 이름
      DB_PASS: wikiam9ho #-- wikijsrocks 비번
    restart: unless-stopped
    ports:
      - "9900:3000"
    container_name:
      wikijs
```

## 3. wiki.js 실행

```
cd /home/docker/compose
sudo docker compose up -d
echo "🎶 (8) ---------"
```

## 4. 브라우저에서 위키 주소 입력

```
192.168.000.111:9900
||| ||| ||| ||| ||||
||| ||| ||| ||| ++++---- docker-compose.yml 파일에서 지정한 포트 번호
||| ||| ||| |||
+++-+++-+++-+++---- wiki.js 를 실행한 서버의 ip 주소
```
도커가 읽어보는 파일인 docker-compose.yml 에는 다음과 같이 포트 번호를 지정하고 있다.

```
  wiki:
    ports:
      - "9900:3000"
```
- `9900:3000` <---- 외부에서 포트 `9900` 에 요청을 하면, 도커는 포트 `3000` 에 그 요청을 전달한다.

### (1) 포트번호 0 ~ 65535 번의 분류

| well-known ports | registered ports | dynamic ports |
|:-----:|:-----:|:-----:|
| 0 ~ 1023 번 | 1024 ~ 49151 번 | 49152 ~ 65535 번 |
| 서버 애플리케이션으로 예약된 포트 | 자주 이용하는 서버 애플리케이션을 식별하기 위한 포트 | 클라이언트 애플리케이션용 임시 포트 |

### (2) 서버 애플리케이션에 습관적으로 붙이는 well known port

서버에서 주로 쓰이는 애플리케이션에는 `0 ~ 1023 번` 범위내에서 다음과 같이 관례로 굳어진 번호를 사용한다.

| 포트 번호 | 서버 애플리케이션 |
|:-----:|:-----:|
| 20 번 | FTP (파일 전송) |
| 22 번 | SSH (원격제어, 보안기능 추가) |
| 23 번 | Telnet (원격제어) |
| 25 번 | SMTP (이메일 전송) |
| 80 번 | HTTP (웹) |
| 110 번 | POP3 (이메일 수신) |
| 143 번 | IMAP4 (이메일 수신, + 보관) |
| 443 번 | HTTPS (보안기능 추가한 웹) |

### (3) 웰노운 이외의 서버 애플리케이션에 지정하고 공지하는 registered port

웰노운 이외의 서버 애플리케이션에는 `1024 ~ 49151 번` 을 지정한다.

### (4) 클라이언트 애플리케이션인데 포트번호가 필요할때 쓰는 dynamic ports

well known port 나 registered port 는 그 포트 번호를 서버 애플리케이션이 미리 알고서 시작한다.
이와 반대로, 클라이언트 애플리케이션은 시작한 다음에 OS 에게 포트번호를 요청해서, 포트 번호가 몇번인지를 전달 받는다.
그리고, 클라이언트 애플리케이션이 끝나게 되면, OS 는 그 포트번호를 반납으로 체크해 놓고,
다른 크라이언트가 시작하면서 포트번호를 요청할때, 반납한 포트번호 (`49152 ~ 65535 번`) 중에서 하나를 골라 전달해 준다.

출처: TCP/IP 전송 계층(Transport)과 포트(Port) 번호 2022-4-7 https://forward-movement.tistory.com/188


## 5. 사진 설치작업 진행하면서 화면캡쳐

### (1) iso CD 이미지 에서 부팅하기

폴더: /ubuntu2204desktop/00-17-boot-from-iso

- 00-welcome
![ 00-welcome ](/ubuntu2204desktop/00-17-boot-from-iso/00-welcome.png)
- 01-marchine-name
![ 01-marchine-name ](/ubuntu2204desktop/00-17-boot-from-iso/01-marchine-name.png)
- 03-memory4096-processor4
![ 03-memory4096-processor4 ](/ubuntu2204desktop/00-17-boot-from-iso/03-memory4096-processor4.png)
- 04-hard-disk
![ 04-hard-disk ](/ubuntu2204desktop/00-17-boot-from-iso/04-hard-disk.png)
- 05-summary
![ 05-summary ](/ubuntu2204desktop/00-17-boot-from-iso/05-summary.png)
- 06-network
![ 06-network ](/ubuntu2204desktop/00-17-boot-from-iso/06-network.png)
- 07-adapter1-bridge
![ 07-adapter1-bridge ](/ubuntu2204desktop/00-17-boot-from-iso/07-adapter1-bridge.png)
- 08-adapter2-host-only
![ 08-adapter2-host-only ](/ubuntu2204desktop/00-17-boot-from-iso/08-adapter2-host-only.png)
- 09-shared-folders
![ 09-shared-folders ](/ubuntu2204desktop/00-17-boot-from-iso/09-shared-folders.png)
- 10-select-folder
![ 10-select-folder ](/ubuntu2204desktop/00-17-boot-from-iso/10-select-folder.png)
- 11-auto-mount
![ 11-auto-mount ](/ubuntu2204desktop/00-17-boot-from-iso/11-auto-mount.png)
- 12-shared-ok
![ 12-shared-ok ](/ubuntu2204desktop/00-17-boot-from-iso/12-shared-ok.png)
- 13-start-virtualbox
![ 13-start-virtualbox ](/ubuntu2204desktop/00-17-boot-from-iso/13-start-virtualbox.png)
- 14-DVD-mount
![ 14-DVD-mount ](/ubuntu2204desktop/00-17-boot-from-iso/14-dvd-mount.png)
- 15-select-iso
![ 15-select-iso ](/ubuntu2204desktop/00-17-boot-from-iso/15-select-iso.png)
- 16-restart-boot
![ 16-restart-boot ](/ubuntu2204desktop/00-17-boot-from-iso/16-restart-boot.png)
- 17-try-or-install-ubuntu
![ 17-try-or-install-ubuntu ](/ubuntu2204desktop/00-17-boot-from-iso/17-try-or-install-ubuntu.png)

### (2) ubuntu desktop 설치

폴더: /ubuntu2204desktop/18-37-install-restart

- 18-install-Ubuntu
![ 18-install-Ubuntu ](/ubuntu2204desktop/18-37-install-restart/18-install-ubuntu.png)
- 19-keyboard-layout
![ 19-keyboard-layout ](/ubuntu2204desktop/18-37-install-restart/19-keyboard-layout.png)
- 20-install-3rd-party
![ 20-install-3rd-party ](/ubuntu2204desktop/18-37-install-restart/20-install-3rd-party.png)
- 21-erase-disk-N-install
![ 21-erase-disk-N-install ](/ubuntu2204desktop/18-37-install-restart/21-erase-disk-n-install.png)
- 21-erase-disk
![ 21-erase-disk ](/ubuntu2204desktop/18-37-install-restart/21-erase-disk.png)
- 22-continue
![ 22-continue ](/ubuntu2204desktop/18-37-install-restart/22-continue.png)
- 23-Seoul
![ 23-Seoul ](/ubuntu2204desktop/18-37-install-restart/23-seoul.png)
- 24-who-are-you
![ 24-who-are-you ](/ubuntu2204desktop/18-37-install-restart/24-who-are-you.png)
- 25-welcome-to-ubuntu
![ 25-welcome-to-ubuntu ](/ubuntu2204desktop/18-37-install-restart/25-welcome-to-ubuntu.png)
- 26-find-more-software
![ 26-find-more-software ](/ubuntu2204desktop/18-37-install-restart/26-find-more-software.png)
- 27-complete-restart
![ 27-complete-restart ](/ubuntu2204desktop/18-37-install-restart/27-complete-restart.png)
- 28-login
![ 28-login ](/ubuntu2204desktop/18-37-install-restart/28-login.png)
- 29-pswd
![ 29-pswd ](/ubuntu2204desktop/18-37-install-restart/29-pswd.png)
- 30-connect-online
![ 30-connect-online ](/ubuntu2204desktop/18-37-install-restart/30-connect-online.png)
- 31-ubuntuPro-skip-Next
![ 31-ubuntuPro-skip-Next ](/ubuntu2204desktop/18-37-install-restart/31-ubuntupro-skip-next.png)
- 32-install-update
![ 32-install-update ](/ubuntu2204desktop/18-37-install-restart/32-install-update.png)
- 33-NO-restart-click-Next
![ 33-NO-restart-click-Next ](/ubuntu2204desktop/18-37-install-restart/33-no-restart-click-next.png)
- 34-NO-send-Next
![ 34-NO-send-Next ](/ubuntu2204desktop/18-37-install-restart/34-no-send-next.png)
- 35-privacy-next
![ 35-privacy-next ](/ubuntu2204desktop/18-37-install-restart/35-privacy-next.png)
- 36-ready-done
![ 36-ready-done ](/ubuntu2204desktop/18-37-install-restart/36-ready-done.png)
- 37-restart-now
![ 37-restart-now ](/ubuntu2204desktop/18-37-install-restart/37-restart-now.png)

### (3) 터미널 설정

폴더: /ubuntu2204desktop/38-46-terminal-font-color-change

- 38-show-application
![ 38-show-application ](/ubuntu2204desktop/38-46-terminal-font-color-change/38-show-application.png)
- 39-terminal-to-Favorites
![ 39-terminal-to-Favorites ](/ubuntu2204desktop/38-46-terminal-font-color-change/39-terminal-to-favorites.png)
- 40-Terminal-click
![ 40-Terminal-click ](/ubuntu2204desktop/38-46-terminal-font-color-change/40-terminal-click.png)
- 41-Terminal-ls-al
![ 41-Terminal-ls-al ](/ubuntu2204desktop/38-46-terminal-font-color-change/41-terminal-ls-al.png)
- 42-menu-Preferences
![ 42-menu-Preferences ](/ubuntu2204desktop/38-46-terminal-font-color-change/42-menu-preferences.png)
- 43-Unnamed-Custom-font-Size-14
![ 43-Unnamed-Custom-font-Size-14 ](/ubuntu2204desktop/38-46-terminal-font-color-change/43-unnamed-custom-font-size-14.png)
- 44-Colors-Collor_palette-change
![ 44-Colors-Collor_palette-change ](/ubuntu2204desktop/38-46-terminal-font-color-change/44-colors-collor_palette-change.png)
- 45-color-change
![ 45-color-change ](/ubuntu2204desktop/38-46-terminal-font-color-change/45-color-change.png)
- 46-font-color-change
![ 46-font-color-change ](/ubuntu2204desktop/38-46-terminal-font-color-change/46-font-color-change.png)

### (4) 한글 설정

폴더: /ubuntu2204desktop/50-ubuntu2204desktop-hangul

- 00-right-top-settings
![ 00-right-top-settings ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/00-right-top-settings.png)
- 01-Region-n-languages
![ 01-Region-n-languages ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/01-region-n-languages.png)
- 02-language-install
![ 02-language-install ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/02-language-install.png)
- 03-applying-changes
![ 03-applying-changes ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/03-applying-changes.png)
- 04-language-support-ok
![ 04-language-support-ok ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/04-language-support-ok.png)
- 05-keyboard
![ 05-keyboard ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/05-keyboard.png)
- 06-input-source-korean
![ 06-input-source-korean ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/06-input-source-korean.png)
- 07-korean-add
![ 07-korean-add ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/07-korean-add.png)
- 08-move-up
![ 08-move-up ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/08-move-up.png)
- 09-input-source-korean
![ 09-input-source-korean ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/09-input-source-korean.png)
- 10-ibus-setup
![ 10-ibus-setup ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/10-ibus-setup.png)
- 11-input-method-add
![ 11-input-method-add ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/11-input-method-add.png)
- 12-search-korean
![ 12-search-korean ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/12-search-korean.png)
- 13-korean-hangul
![ 13-korean-hangul ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/13-korean-hangul.png)
- 20-ibus-setup
![ 20-ibus-setup ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/20-ibus-setup.png)
- 21-imput-method-add
![ 21-imput-method-add ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/21-imput-method-add.png)
- 30-show-app
![ 30-show-app ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/30-show-app.png)
- 31-settings
![ 31-settings ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/31-settings.png)
- 32-region-n-language
![ 32-region-n-language ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/32-region-n-language.png)
- 33-manage-installed-language
![ 33-manage-installed-language ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/33-manage-installed-language.png)
- 34-lang-install
![ 34-lang-install ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/34-lang-install.png)
- 35-applying-changes
![ 35-applying-changes ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/35-applying-changes.png)
- 36-install-remove-languages
![ 36-install-remove-languages ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/36-install-remove-languages.png)
- 37-hankuko-ok
![ 37-hankuko-ok ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/37-hankuko-ok.png)
- 38-no-english
![ 38-no-english ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/38-no-english.png)
- 39-apply-system-wide
![ 39-apply-system-wide ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/39-apply-system-wide.png)
- 40-regional-formats
![ 40-regional-formats ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/40-regional-formats.png)
- 41-click-plus-char
![ 41-click-plus-char ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/41-click-plus-char.png)
- 42-reboot
![ 42-reboot ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/42-reboot.png)
- 43-keyboard-add-input-source-korean
![ 43-keyboard-add-input-source-korean ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/43-keyboard-add-input-source-korean.png)
- 44-korean-hangul
![ 44-korean-hangul ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/44-korean-hangul.png)
- 45-move-up
![ 45-move-up ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/45-move-up.png)
- 46-input-source
![ 46-input-source ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/46-input-source.png)
- 47-english-remove
![ 47-english-remove ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/47-english-remove.png)
- 48-last-input-source
![ 48-last-input-source ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/48-last-input-source.png)
- 49-preferences
![ 49-preferences ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/49-preferences.png)
- 50-hangul-toggle-key-add
![ 50-hangul-toggle-key-add ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/50-hangul-toggle-key-add.png)
- 51-alt-R
![ 51-alt-R ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/51-alt-r.png)
- 52-alt-R-ok
![ 52-alt-R-ok ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/52-alt-r-ok.png)
- 53-english-typing
![ 53-english-typing ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/53-english-typing.png)
- 54-hangul-typing
![ 54-hangul-typing ](/ubuntu2204desktop/50-ubuntu2204desktop-hangul/54-hangul-typing.png)

## photoshop

1. 231023월 231016-1주차
https://youtu.be/jBvG-hGjgWI?si=ebLn3X_xjjv4tpDH
2. 231028토 231023-2주차
https://youtu.be/zb01ARY4uOs
3. 231106월 231030-3주차
https://youtu.be/cgiOkrHgdT4
4. 231108수 231106-4주차
https://youtu.be/w4iEHvLahXk
5. 231121화 231113-5주차
https://youtu.be/fy18vxN7dlE
6. 231121화 231120-6주차
https://youtu.be/UEu2aftmxr8
7. 231202토 231127-7주차
https://youtu.be/B4lpDPX6_5o?si=BtIQDp3WlCM7IaFW
8. 231207목 231204-8주차
https://youtu.be/cUSz1jpKn3A?si=Sg-M1JcXhf4asEUg

## medi xls

### 230903-231204 백업

압축파일: [ hm_data-230903_to_231204.7z.001 ](/hm_data/hm_data-230903_to_231204.7z.001)

1. 230903일
```
 170496  9월  3 11:52  재고현황.xls
```
2. 230912화
```
 192512  9월 11 11:50  재고현황-1.xls
 618496  9월 12 16:58  재고현황-2.xls
```
3. 230913수
```
 399872  9월 13 11:09  230911택배만매출명세서집계.xls
 303104  9월 13 11:09  230912택배만매출명세서집계.xls
 398848  9월 13 11:09  로230912비고모두매출명세서집계.xls
 540672  9월 13 11:09  230911비고모두로매출명세서집계.xls
```
4. 230915금
```
  86950  9월 15 10:53 '#MDL_해외포장_메뉴얼.xlsx'
 299520  9월 15 10:53  2303부터230914리커세트실수불.xls
 273408  9월 15 10:53  230914택배만매출명세서집계.xls
 402944  9월 15 10:53  230914비고모두로매출명세서집계.xls
4355072  9월 15 10:53  거래처관리_230901.xls
 221184  9월 15 10:53  230914택배만매출명세서집계-1.xls
 345600  9월 15 10:53  230914비고모두로매출명세서집계-1.xls
```
5. 231129수
```
 256000 11월 29 20:00 '아오와재고현황_(1).xls'
```
6. 231204월
```
 223232 12월  4 12:00  231201매출명세서집계_택배만.xls
 334336 12월  4 12:00  231201매출명세서집계_전부.xls
 183808 12월  4 12:00  231201_야보스_매출명세서집계_전부.xls
```

## youtube

1. 헝가리가 출산 대박 터진이유. 13:02:01★´`°³о涅槃о³°`‘★ https://www.youtube.com/watch?v=brc-UJFT21k
1. 김우영TV - 경선후보 https://www.youtube.com/@user-gx2mh9ld1n

1. 노년을 누워서 보내기 싫으면 '이것' 무조건 하세요! / 자율신경 분야 1인자 고바야시 히로유키가 검증한 최강의 건강법! / 책읽어주는여자 SODA's 건강 오디오북 ASMR 소리내어읽다 구독자 34.4만명 https://www.youtube.com/watch?v=GGOKD95HMgw
1. 넘어지지도, 다치지도 않고 꼿꼿하게 100세까지 걷는 엉덩이 단련법! / 이렇게 하세요! 낙상, 골절 확 줄어듭니다! / 엉덩이의 힘 / 책읽어주는여자 SODA's 건강 오디오북 소리내어읽다 구독자 34.4만명 https://www.youtube.com/watch?v=76wF8S_NG-M
1. 죽지도 않아 더 괴로운 좀비 세포, 노화 | 질병과도 연결된 노화를 막는 방법은 생활 습관 하나뿐? | 명의 | #EBS건강 EBS 건강 구독자 7.08만명 조회수 1.6만회  3일 전 ※ 이 영상은 2022년 2월 11일에 방송된 ＜명의 - 노화를 막는 다섯가지 열쇠＞의 일부입니다. https://www.youtube.com/watch?v=FOxfuiVKGIU
1. 영혼을 갈아 만든 5000년 한국사 한번에 다보기 (3시간 순삭ver.) 로빈의 역사 기록 / Robin's Historical Records 구독자 25.1만명 조회수 171만회 https://www.youtube.com/watch?v=CaG7fR0q-4A&t=10s
1. 송작두의 예언 적중! "명신이 디올은 가짜, 신세계 명동점에는 가짜도 판다?" / 청탁금지법을 따져보니 고발자만 처벌? / 건희의 허영심, 로저 비비에르 신상! 국내엔 없어요~ 송작가TV 구독자 21.6만명 2023. 12. 18. https://www.youtube.com/watch?v=Om1ywSbl-nQ
1. '뉴스버스'의 수많은 단독, 알려지지 않은 비하인드(이정섭 검사) 정치오락실 구독자 1.51만명 조회수 24,802회  2023. 12. 9. https://www.youtube.com/watch?v=AHMzA77xrYQ&t=542s
1. 한국, 세계 4위권 AI 강국…일본 정부 비상 [창+] / KBS 2023.08.07. KBS News 구독자 267만명 https://www.youtube.com/watch?v=3dUn4ylxs0Q
1. 냉장고 대신 김치냉장고만 구입한 이유! | 김치냉장고만 있어도 될까요? | 김치냉장고 브랜드별 특징 및 구매 가이드 총정리! #딤채 #김치냉장고 #냉장고 피크TV_합리적생활쇼핑가이드 구독자 7.76천명 조회수 23만회  1개월 전 https://www.youtube.com/watch?v=lpNIEk0IKVM


## ddanzi

### 남편이 담은 김장김치
13:16:32 Nikola2 조회 2718 동의29 이의0 https://www.ddanzi.com/index.php?mid=free&statusList=HOT%2CHOTBEST%2CHOTAC%2CHOTBESTAC&document_srl=790967815

17년째 웨이트하는 힘좋은 남편이 김장을 담았네요.

![ 231218-131632nikola2-kimchi-00 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-00.webp)
마트에서 사온 재료들과

![ 231218-131632nikola2-kimchi-01 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-01.webp)
집으로 배달된 절임배추를 물빼고

![ 231218-131632nikola2-kimchi-02 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-02.webp)
믹서기 2대를 이용하여,

![ 231218-131632nikola2-kimchi-03 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-03.webp)
생강, 마늘

![ 231218-131632nikola2-kimchi-04 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-04.webp)
사과,배

![ 231218-131632nikola2-kimchi-05 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-05.webp)
무, 양파

![ 231218-131632nikola2-kimchi-06 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-06.webp)
사과, 배

![ 231218-131632nikola2-kimchi-07 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-07.webp)
까나리액젓, 새우젓 넣어 갈고, 전날 끓여 식혀놓은 찹쌀풀 섞어

![ 231218-131632nikola2-kimchi-08 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-08.webp)
미나리, 쪽파, 홍갓 다듬어서

![ 231218-131632nikola2-kimchi-09 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-09.webp)
완성된 양념장과

![ 231218-131632nikola2-kimchi-10 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-10.webp)
웨이트 트레이닝으로 단련된 팔힘으로 팍팍 치댑니다.

![ 231218-131632nikola2-kimchi-11 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-11.webp)
김치통에 담아

![ 231218-131632nikola2-kimchi-12 ](/ilji/2312/kimchi/231218-131632nikola2-kimchi-12.webp)
오래 두고 먹을 김치엔 건다시마를 얹어 김치냉장고에 넣어 보관하면 끝~~~!

아!.  제가 남편입니다.

---
웃는남자:) 14:02:38 
오 건다시마 꿀팁
감칠맛과 공기차단 까지 ㄷㄷㄷ

---
Nikola2 본문 글쓴이 14:06:59 [ 웃는남자:) ]
감사합니다 웃는남자:)님. ^^
건다시마위에 랩핑은 또 해야합니다.

---


# 231214 목
0930 진도

1. 어제날짜의 백업 데이터만 확인하는 스크립트.

- 백업서버의 로컬 백업폴더 확인.
```
ls -lR /opt/backup/kaosdb/$(date +%Y)/*/$(date +%m)/ | grep $(date -d '1 day ago' +%y%m%d)
```
```
-rw-rw-r-- 1 proenpi proenpi 472275 12월  8 20:30 231208-cadbase-231208-203004.7z
-rw-rw-r-- 1 proenpi proenpi   1985 12월  8 20:30 231208-cadbase-231208-203004.ls-alR
-rw-rw-r-- 1 proenpi proenpi 490107 12월  8 20:30 231208-emailbase-231208-203019.7z
-rw-rw-r-- 1 proenpi proenpi   1078 12월  8 20:30 231208-emailbase-231208-203019.ls-alR
-rw-r--r-- 1 proenpi proenpi 12264631 12월  8 21:10 kaosorder2_231208-211001.sql.7z
-rw-rw-r-- 1 proenpi proenpi  5451250 12월  8 20:31 231208-scanbase-231208-203105.7z
-rw-rw-r-- 1 proenpi proenpi      899 12월  8 20:31 231208-scanbase-231208-203105.ls-alR
```

- 클라우드 서버의 백업폴더 확인.
```
rclone lsl kaosngc:kaosdb/2023/ --include "*/$(date +%m)/*$(date -d '1 day ago' +%y%m%d)*"
```
```
.. 472275 2023-12-08 20:30:06.968000000 cadbase/12/231208-cadbase-231208-203004.7z
     1985 2023-12-08 20:30:05.000000000 cadbase/12/231208-cadbase-231208-203004.ls-alR
   490107 2023-12-08 20:30:19.584000000 emailbase/12/231208-emailbase-231208-203019.7z
     1078 2023-12-08 20:30:19.188000000 emailbase/12/231208-emailbase-231208-203019.ls-alR
 12264631 2023-12-08 21:10:58.000000000 kaosorder2/12/kaosorder2_231208-211001.sql.7z
  5451250 2023-12-08 20:31:08.939000000 scanbase/12/231208-scanbase-231208-203105.7z
      899 2023-12-08 20:31:05.995000000 scanbase/12/231208-scanbase-231208-203105.ls-alR
```

2. bash 쉘에서 ls -l 을 하면 퍼일 이름과 그 사이즈까지 표시가 되는데, 그 사이즈의 합계를 내고 싶어. 이것을 ls -l 명령과 bc 명령을 이용해서 하려면 어떻게 하면 되지?

### BARD:
다음과 같이 하면 됩니다.

```Bash
ls -l | while read line; do
  size=$(echo "$line" | awk '{print $5}')
  sum=$(bc <<< "scale=2; $sum + $size")
done
echo "합계: $sum"
#-- 코드를 사용할 때는 주의하시기 바랍니다. 자세히 알아보기
```

이 명령은 다음과 같이 작동합니다.

- `ls -l` 명령을 사용하여 현재 디렉토리의 파일 목록을 가져옵니다.
- `while read line; do` 블록을 사용하여 파일 목록을 반복합니다.
- `echo "$line" | awk '{print $5}'` 명령을 사용하여 각 파일의 크기를 가져옵니다.
- `bc <<< "scale=2; $sum + $size"` 명령을 사용하여 파일 크기의 합계를 계산합니다.
- `echo "합계: $sum"` 명령을 사용하여 합계를 출력합니다.

예를 들어, 현재 디렉토리에 다음과 같은 파일이 있다고 가정해 보겠습니다.
```
-rw-r--r-- 1 user group 1000 2023-12-14 11:30 file1
-rw-r--r-- 1 user group 2000 2023-12-14 11:31 file2
```
이 명령을 실행하면 다음과 같은 출력이 나타납니다.
```
합계: 3000
```

다른 방법으로, 다음과 같이 할 수도 있습니다.

```Bash
ls -l | awk '{sum += $5} END {print sum}'
#-- 코드를 사용할 때는 주의하시기 바랍니다. 자세히 알아보기
```

이 명령은 다음과 같이 작동합니다.

- `awk '{sum += $5}'` 명령을 사용하여 파일 크기의 합계를 계산합니다.
- `'END {print sum}'` 명령을 사용하여 합계를 출력합니다.

이 방법은 bc 명령을 사용하지 않기 때문에 더 간단합니다.

3. bash 쉘에서 ls -l 을 하면 퍼일 이름과 그 사이즈까지 표시가 되는데, 그 사이즈의 합계를 내고 싶어. 이것을 ls -l 명령과 bc 명령을 이용해서 하려면 어떻게 하면 되지?

### ChatGPT 3.5
ls -l 명령어의 결과에서 파일 크기를 추출하고 그 합계를 계산하기 위해서는 몇 가지 단계가 필요합니다. 아래는 그 단계를 설명한 스크립트입니다.
```bash
#!/bin/bash

# ls -l 명령어로 파일 정보 가져오기, awk를 사용하여 파일 크기 추출
file_sizes=$(ls -l | awk '{sum += $5} END {print sum}')

# 결과 출력
echo "총 파일 크기: $file_sizes 바이트"
```

이 스크립트는 현재 디렉토리에 있는 파일들의 크기 합계를 계산합니다. 스크립트를 작성하고 실행하려면 다음 단계를 따르세요:

- 1. 텍스트 에디터(예: nano, vim, gedit 등)를 사용하여 새 파일을 만듭니다. 예를 들어, calculate_size.sh라는 이름으로 저장할 수 있습니다.
```bash
nano calculate_size.sh
```
- 2. 위의 스크립트를 복사하여 붙여넣고 저장합니다.
- 3. 스크립트에 실행 권한을 부여합니다.
```bash
chmod +x calculate_size.sh
```
- 4. 스크립트를 실행합니다.
```bash
./calculate_size.sh
```

이렇게 하면 현재 디렉토리에 있는 파일들의 크기 합계가 표시됩니다. 주의할 점은 이 스크립트는 현재 디렉토리에 있는 모든 파일의 크기 합계를 계산하므로 원하는 디렉토리에서 실행해야 합니다.

### 위 bard, chatgpt 의 설명을 참고해서, 현재 디렉토리의 파일 사이즈 합계 스크립트를 만들었다.
`cat ~/bin/this-file-size.sh`
```
#!/bin/sh

# ls -l 명령어로 파일 정보 가져오기, awk를 사용하여 파일 크기 추출
file_sizes=$(ls -l | awk '{sum += $5} END {print sum}')

# 결과 출력
totsiz=$(printf "%'.d\n" $file_sizes) #-- 천 (1000) 의 자리마다 콤마를 넣어 표시한다.
echo "파일 크기 합계: $totsiz 바이트"
```

또는, 한줄 스크립트:
```
printf "%'.d\n" $(ls -l | awk '{sum += $5} END {print sum}')
```

평가:
chatgpt 는 ls -l 명령과 bc 명령을 이용하라고 했는데 bc 대신 awk 를 사용했다.
bard 는 지시대로 했지만 sum="0" 초기화 작업이 빠져서 오류가 난다.

# 231213 수
0930 진도

1. https://www.udemy.com/ 유데미 강좌
또는, 웅진씽크빅 https://udemy.wjtb.co.kr/
1. pomodoro 타이머 만들기 1-기획 https://dreamsailor.tistory.com/12
2-실천 + 유데미 https://dreamsailor.tistory.com/43
1. kaos host 백업이 21:10 이므로 그 이후 시각으로 맞춰야 한다.
```
12:48:29수231213 proenpi@pi4b /opt/backup/kaosdb/2023
2023 $ crontab -l
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
#-분-시-일-월-요일(0:일,1:월,2:화,..6:토) 실행프로그램 추가인수 >/dev/null 2>&1
20  08  *  *  *  /bin/sh /opt/backup/wikidb/db-to-cloud.sh wiki >/dev/null 2>&1
03  11  *  *  *  /bin/sh /opt/backup/wikidb/db-to-cloud.sh wiki >/dev/null 2>&1
03  15  *  *  *  /bin/sh /opt/backup/wikidb/db-to-cloud.sh wiki >/dev/null 2>&1
03  20  *  *  *  /bin/sh /opt/backup/wikidb/db-to-cloud.sh wiki >/dev/null 2>&1
# vvvv--- host 백업이 2110 이므로 그 이후 시각으로 맞춰야 한다.
30  21  *  *  *  /bin/sh /opt/backup/kaosdb/copy-from-kaoskr-cegs-Y4M2D2.sh >/dev/null 2>&1
#
12:48:33수231213 proenpi@pi4b /opt/backup/kaosdb/2023
```

## todo

- [X] kaos, wikijs, yosjgc, calls_sms 백업 제대로 되는지 확인하는 스크립트 > kaos host 의 백업 시각이 21:30 이라서 그 시각 이후로 원격백업 스크립트를 실행해야 한다. > proenpi 백업시각을 2130 으로 수정 > 테스트 완료 > 실행 확인 ok
- [X] kaos 백업 정리후 이전 준비
- [X] hm 받은파일 - 231204완

# 231212 화
0800 남동스카이장례식장 발인 1030 안성추모공원 안장 (30-20) 10k입

## 화면녹화
0. 크롬으로 간단하게 브라우저 화면 녹화하기 2022-10-31 23:08:24 https://quizmoa.com/article/view/4/170/#google_vignette
1. 크롬에서 구글 관리콘솔 도구상자 접속: https://toolbox.googleapps.com/apps/main/
1. 좌상단 3선 > 화면녹화 (2) RECORD (1) Record audio=소리도 녹화
1. 전체화면 선택 > 해당화면 클릭 > 공유버튼 활성화 > 공유 클릭 > 녹화 > 공유중지 > DOWNLOAD

## 윈도우10 화면 녹화 기능 사용 방법
David 2023-11-03 15:30:52 • Filed to: 화면녹화 프로그램 리뷰 https://dc.wondershare.kr/screen-recorder/how-to-use-screen-recorder.html

#### 스크롤 긴 웹 페이지 잘리지 않게 한번에 캡쳐 방법 200901-0753
https://sososo882.tistory.com/1

## Windows 10

### 231208 금 IE가 아닌 Windows 탐색기에서 ftp 사이트 바로 가기를 여는 방법


# 231211 월
동희통화 1800 남동스카이장례식장 광희형,동희 내외, 현숙내외, 

# 231210 일

09:45 메가박스 남양주현대아울렛 스페이스원 3관 서울의 봄 F3-6 관람

[부고]
故김간난(이관식의 모친)님께서 선종하셨기에 아래와 같이 부고를 전해 드립니다

남동스카이장례식장
6층 특601호실
인천광역시 남동구 앵고개로697번길 41

■유가족 및 장례식장 위치 확인
https://funein.com/b/f/1436591/1145448/

일일이 연락 드리지 못함을 혜량해주시길 바랍니다.
20:17 이관식

![ 외숙모별세부고 이관식 ](/ilji/2312/231212-1030-bugo.png)

# 231209 토

## sbc barcode

- [ ] Interfacing Thermal Printer with Raspberry Pi to Print Text, Images, Barcodes and QR Codes Published  January 24, 2022 https://circuitdigest.com/microcontroller-projects/thermal-printer-interfacing-with-raspberry-pi-zero-to-print-text-images-and-bar-codes
- [ ] GENERATE QR CODE USING PYTHON WITH RASPBERRY PI June 10, 2021 https://shop.sb-components.co.uk/blogs/posts/generate-qr-code-using-python-with-raspberry-pi
- [ ] 워드프레스 결제 심플페이 – 우커머스 결제 플러그인 By CodeMShop https://wordpress.org/plugins/pgall-for-woocommerce/

# 231208 금
1210 진도

1. 남양주노복1.농업2.행정 지원

## pay
  
1. 231208-1726 토스페이먼츠 1544-7772 (유)노마드컴퍼니 풀스택GPT 99,000완 https://nomadcoders.co/fullstack-gpt/lobby
1. 231208-1732 현대전기2311 21,820완 31101-31130 135kwh 108-643-64-823-019

## sbc barcode

1. Interfacing Thermal Printer with Raspberry Pi to Print Text, Images, Barcodes and QR Codes Published  January 24, 2022 https://circuitdigest.com/microcontroller-projects/thermal-printer-interfacing-with-raspberry-pi-zero-to-print-text-images-and-bar-codes
1. GENERATE QR CODE USING PYTHON WITH RASPBERRY PI June 10, 2021 https://shop.sb-components.co.uk/blogs/posts/generate-qr-code-using-python-with-raspberry-pi
1. 워드프레스 결제 심플페이 – 우커머스 결제 플러그인 By CodeMShop https://wordpress.org/plugins/pgall-for-woocommerce/

## Windows 10

`<PrtScr>` 키로 캡쳐해서 받은 파일을 링크로 만드는 스크립트를 추가한다.
```
231208-130226 $ cat ilji_2312_vsftpd-08.00-15.sh
#!/bin/sh

lll () {
        title=$1
        link=$2
        echo "![ ${title} ](/ilji/2312/${link})"
}

lll "내 PC" vsftpd-08.00-mypc.png
lll "네트워크 위치 추가" vsftpd-08.01-add_network_location.png
lll "사용자 지정 네트워크 위치 선택" vsftpd-08.02-select_custom_network_location.png
lll "웹사이트 위치 지정" vsftpd-08.03-specify_website_location.png
lll "익명 로그온" vsftpd-08.04-anonymous_logon.png
lll "사용자 이름" vsftpd-08.05-user_name.png
lll "위치이름 입력" vsftpd-08.06-enter_location_name.png
lll "위치추가 마법사 완료" vsftpd-08.07-completing_the_add_location_wizard.png
lll "로그온" vsftpd-08.08-logon.png
lll "로그인 완료" vsftpd-08.09-login_completed.png
lll "아래 디렉토리로 가기" vsftpd-08.10-goto-subdir.png
lll "보내기 업로드" vsftpd-08.11-send_upload.png
lll "로그인" vsftpd-08.12-12_click_login.png
lll "사용자 이름" vsftpd-08.13-username.png
lll "비밀번호" vsftpd-08.14-password.png
lll "닫기" vsftpd-08.15-close.png
13:53:23금231208 yosj@gusudong ~/231208-130226
```

실행:
```
231208-130226 $ sh ilji_2312_vsftpd-08.00-15.sh
![ 내 PC ](/ilji/2312/vsftpd-08.00-mypc.png)
![ 네트워크 위치 추가 ](/ilji/2312/vsftpd-08.01-add_network_location.png)
![ 사용자 지정 네트워크 위치 선택 ](/ilji/2312/vsftpd-08.02-select_custom_network_location.png)
![ 웹사이트 위치 지정 ](/ilji/2312/vsftpd-08.03-specify_website_location.png)
![ 익명 로그온 ](/ilji/2312/vsftpd-08.04-anonymous_logon.png)
![ 사용자 이름 ](/ilji/2312/vsftpd-08.05-user_name.png)
![ 위치이름 입력 ](/ilji/2312/vsftpd-08.06-enter_location_name.png)
![ 위치추가 마법사 완료 ](/ilji/2312/vsftpd-08.07-completing_the_add_location_wizard.png)
![ 로그온 ](/ilji/2312/vsftpd-08.08-logon.png)
![ 로그인 완료 ](/ilji/2312/vsftpd-08.09-login_completed.png)
![ 아래 디렉토리로 가기 ](/ilji/2312/vsftpd-08.10-goto-subdir.png)
![ 보내기 업로드 ](/ilji/2312/vsftpd-08.11-send_upload.png)
![ 로그인 ](/ilji/2312/vsftpd-08.12-click_login.png)
![ 사용자 이름 ](/ilji/2312/vsftpd-08.13-username.png)
![ 비밀번호 ](/ilji/2312/vsftpd-08.14-password.png)
![ 닫기 ](/ilji/2312/vsftpd-08.15-close.png)
```

### 231208 금 IE가 아닌 Windows 탐색기에서 ftp 사이트 바로 가기를 여는 방법

출처: https://qastack.kr/superuser/166469/how-to-make-shortcut-to-ftp-site-open-in-windows-explorer-not-ie#:~:text=1%20Windows%20%ED%83%90%EC%83%89%EA%B8%B0%20%EC%B0%BD%EC%9D%84%20%EC%97%BD%EB%8B%88%20%EB%8B%A4%20%28win%20%2B,%ED%83%90%EC%83%89%EA%B8%B0%EC%97%90%EC%84%9C%20%ED%95%AD%EC%83%81%20%EC%97%B4%EB%A6%AC%EB%8A%94%20ftp%20%EC%82%AC%EC%9D%B4%ED%8A%B8%20%EB%B0%94%EB%A1%9C%20%EA%B0%80%EA%B8%B0%EB%A5%BC%20%EB%A7%8C%EB%93%AD%EB%8B%88%EB%8B%A4.

0. Windows 탐색기를 열고, 왼쪽의 탐색 패널에서 `"내 PC"`를 마우스 오른쪽 버튼으로 클릭하십시오.

![ 내 PC ](/ilji/2312/vsftpd-08.00-mypc.png)

1. `"네트워크 위치 추가"` 를 선택하십시오

![ 네트워크 위치 추가 ](/ilji/2312/vsftpd-08.01-add_network_location.png)

2. 마법사를 사용하여 FTP 사이트의 새 네트워크 위치를 작성하십시오.

![ 사용자 지정 네트워크 위치 선택 ](/ilji/2312/vsftpd-08.02-select_custom_network_location.png)

3. 웹사이트 주소를 입력합니다.

![ 웹사이트 위치 지정 ](/ilji/2312/vsftpd-08.03-specify_website_location.png)

4. 익명으로 로그인하는 것을 허용하지 않으므로, 익명 로그온에 있는 `체크표시를 해제`해서 사용자 이름을 입력할 수 있도록 합니다.

![ 익명 로그온의 체크표시를 삭제 ](/ilji/2312/vsftpd-08.04-anonymous_logon.png)

5. 사용자 이름 입력:
![ 사용자 이름 ](/ilji/2312/vsftpd-08.05-user_name.png)

6. 네크워크 위치 이름을 `주소나 ip 번호`로 입력합니다.

![ 위치이름 입력 ](/ilji/2312/vsftpd-08.06-enter_location_name.png)

7. 네트워크 주소 와 사용자명을 입력했으므로, `"마침"` 을 클릭합니다.

![ 위치추가 마법사 완료 ](/ilji/2312/vsftpd-08.07-completing_the_add_location_wizard.png)

8. 네트워크 주소와 사용자 이름을 표시한 상태에서 `비밀번호`를 입력하고 `"로그온"` 을 클릭합니다.

![ 사용자이름 암호 입력으로 로그온 ](/ilji/2312/vsftpd-08.08-logon.png)

9. 로그인 이 된 상태입니다. `upload` 라는 디렉토리 한개만 있는 상태입니다. 해당 디렉토리를 클릭해서 그 디렉토리 안으로 들어갑니다.

![ 로그인 완료 ](/ilji/2312/vsftpd-08.09-login_completed.png)

10. upload 라는 디렉토리 안에는 `vsftpd-restart.sh` 라는 파일 한개만 들어 있습니다.

![ 아래 디렉토리로 가기 ](/ilji/2312/vsftpd-08.10-goto-subdir.png)

11. 연결을 마우스 오른쪽 버튼으로 클릭하고 "보내기"> "바탕 화면 (바로 가기)"을 선택하여 `바로 가기`를 만들면, FTP 사이트가 이제 내 컴퓨터에 `네트워크 위치`로 표시됩니다.
또는,
전송할 파일에서 오른쪽 버튼 클릭하고, "WinSCP" (업로드) 를 클릭해서 파일을 업로드 할 수 있습니다.

![ 보내기 WinSCP업로드 ](/ilji/2312/vsftpd-08.11-send_upload.png)

12. "WinSCP" (업로드) 의 경우, `"로그인"` 을 클릭 합니다.

![ 로그인 클릭 ](/ilji/2312/vsftpd-08.12-click_login.png)

13. 로그인이 되어있지 않으면, `사용자 이름`을 입력합니다.

![ 사용자 이름 ](/ilji/2312/vsftpd-08.13-username.png)

14. `비밀번호`를 입력합니다.

![ 비밀번호 ](/ilji/2312/vsftpd-08.14-password.png)

15. 업로드가 끝나면 `"확인"` 을 눌러서 연결을 닫습니다.

![ 닫기 ](/ilji/2312/vsftpd-08.15-close.png)


# 231207 목
1100 관식동희 복국중식

1. 노복센터방문

# 231206 수
0940 진도

1. Git-Bash 설치시 오류남.
```
USER@PC19 MINGW64 ~
$ rsync -avzr -e 'ssh -p 15822' ntuser.ini proenpi@proen.duckdns.org:a*/
C:/Program Files/Git/usr/bin/rsync.exe: error while loading shared libraries: msys-crypto-1.1.dll: cannot open shared object file: No such file or directory

USER@PC19 MINGW64 ~
```

2. 설치 원본 /etc/vsftpd.conf 에서 설명을 제외함.
`grep "[A-z#]" vsftpd.conf-231206-1015 | grep -v "# " | grep -v "#$" > vsftpd.conf-CUT-REMARK-231206-1019 ; cat vsftpd.conf-CUT-REMARK-231206-1019`
```
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
#write_enable=YES
#local_umask=022
#anon_upload_enable=YES
#anon_mkdir_write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
#chown_uploads=YES
#chown_username=whoever
#xferlog_file=/var/log/vsftpd.log
#xferlog_std_format=YES
#idle_session_timeout=600
#data_connection_timeout=120
#nopriv_user=ftpsecure
#async_abor_enable=YES
#ascii_upload_enable=YES
#ascii_download_enable=YES
#ftpd_banner=Welcome to blah FTP service.
#deny_email_enable=YES
#banned_email_file=/etc/vsftpd.banned_emails
#chroot_local_user=YES
#chroot_local_user=YES
#chroot_list_enable=YES
#chroot_list_file=/etc/vsftpd.chroot_list
#ls_recurse_enable=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
#utf8_filesystem=YES
```

3. [여기보기] 쓸 것인가 말 것인가 그것이 문제로다, FTP 보안 설정 돌아보기 🧐 김용현 | 2023-04-20 https://netmarble.engineering/linux-server-ftp-securiy-setting/


## bard

### Q

vsftpd 프로그램을 ubuntu 2294 시스템에 설치하려고 해.

### A

알겠습니다. Ubuntu 22.04 시스템에 vsftpd 프로그램을 설치하는 방법을 알려드리겠습니다.

1. vsftpd 패키지를 설치합니다.

터미널을 열고 다음 명령을 실행합니다.

sudo apt update
sudo apt install vsftpd
이 명령은 vsftpd 패키지를 설치합니다.

2. vsftpd 서비스를 시작합니다.

터미널을 열고 다음 명령을 실행합니다.

sudo systemctl start vsftpd
이 명령은 vsftpd 서비스를 시작합니다.

3. vsftpd 서비스를 활성화합니다.

터미널을 열고 다음 명령을 실행합니다.

sudo systemctl enable vsftpd
이 명령은 vsftpd 서비스를 부팅 시 자동으로 시작되도록 활성화합니다.

4. vsftpd 설정을 구성합니다.

vsftpd 설정을 구성하려면 다음 파일을 편집합니다.

/etc/vsftpd.conf
이 파일을 편집할 때 다음 사항에 유의하십시오.

anonymous_enable 옵션을 yes로 설정하면 익명 사용자는 FTP를 사용하여 파일을 다운로드할 수 있습니다.
local_enable 옵션을 yes로 설정하면 로컬 사용자는 FTP를 사용하여 파일을 다운로드하고 업로드할 수 있습니다.
chroot_local_user 옵션을 yes로 설정하면 로컬 사용자는 FTP를 사용하여 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다.
passwd_file 옵션은 로컬 사용자의 암호를 저장하는 파일을 지정합니다.
vsftpd 설정을 구성한 후에는 다음 명령을 실행하여 vsftpd 서비스를 다시 시작합니다.

sudo systemctl restart vsftpd
이 명령은 vsftpd 서비스를 다시 시작하여 새 설정을 적용합니다.

5. vsftpd 서비스를 테스트합니다.

vsftpd 서비스를 테스트하려면 다음 단계를 따르세요.

웹 브라우저를 열고 다음 주소로 이동합니다.
ftp://localhost
익명 사용자로 로그인합니다.
username: anonymous
password: anonymous
파일을 다운로드하거나 업로드해 보세요.
vsftpd가 제대로 구성되어 있으면 파일을 다운로드하거나 업로드할 수 있습니다.

추가 구성

vsftpd를 추가로 구성하려면 다음 옵션을 사용할 수 있습니다.

pasv_enable 옵션을 yes로 설정하면 FTP 서버는 포트 21을 통해 데이터를 전송하는 대신 포트 20을 통해 데이터를 전송합니다.
max_clients 옵션은 동시에 연결할 수 있는 최대 FTP 클라이언트 수를 지정합니다.
max_per_ip 옵션은 IP 주소당 동시에 연결할 수 있는 최대 FTP 클라이언트 수를 지정합니다.
user_sub_token 옵션은 익명 사용자의 암호를 생성하는 데 사용할 토큰을 지정합니다.
이러한 옵션에 대한 자세한 내용은 vsftpd 문서를 참조하세요.

### Q

프로필 사진
오! 작업과정이 매우 길구나. 저 설명대로 하나씩 실행해 볼께. 음, 지금 상태는 윈도우 시스템에 virtualbox 7 버전을 이미 설치해 뒀어. 그리고 이 virtualbox 에다가 ubuntu 2204 를 인스톨해서 원격 터미널인 putty 로 로그인 해서 들어가 있는 중이야. 우선 설명대로 진행해 보고 나서, 질문을 해 볼께.

### A

네, 그렇게 진행하시면 됩니다. 작업 과정이 길다고 느껴지실 수도 있지만, 한 단계씩 차근차근 진행하시면 어렵지 않게 설치하실 수 있을 것입니다.

VirtualBox 7 버전과 Ubuntu 22.04가 설치되어 있다는 것은 잘 알고 있습니다. Putty를 사용하여 Ubuntu 시스템에 원격으로 로그인할 수 있다는 것도 알고 있습니다.

설명대로 진행하신 후, 질문이 있으시면 언제든지 알려주세요. 도와드리겠습니다.

추가 팁

vsftpd 설정을 구성할 때는 sudo nano /etc/vsftpd.conf 명령을 사용하여 /etc/vsftpd.conf 파일을 편집하는 것이 좋습니다.
/etc/vsftpd.conf 파일을 편집할 때는 다음 사항에 유의하십시오.
파일의 끝에 도달하기 전에 Ctrl+X를 눌러 종료하세요.
파일을 저장하려면 Y를 누르고 Enter를 누르세요.
vsftpd 서비스를 테스트할 때는 ftp://localhost 주소를 사용하는 대신 ftp://[IP 주소] 주소를 사용할 수도 있습니다.
이러한 팁이 도움이 되기를 바랍니다.

### Q

프로필 사진
A 답안이 더 좋은것 같아. 그리고 nano 는 처음 보는거 같은데. 나는 vi 만 써봤기 때문에 앞으로 설명은 vi 로 해줬으면 해. 저대로 해보고 질문이 있으면 바로 할께.
다른 답안 보기

### A

네, A 답안이 더 좋은 것 같습니다. nano는 vi와 비슷한 편집기이지만, vi에 비해 기능이 적습니다.

vi로 vsftpd 설정을 구성하는 방법은 다음과 같습니다.

vi /etc/vsftpd.conf
이 명령을 실행하면 /etc/vsftpd.conf 파일이 vi 편집기로 열립니다.

/etc/vsftpd.conf 파일을 편집할 때는 다음 사항에 유의하십시오.

i 키를 눌러 삽입 모드로 들어갑니다.
옵션을 편집하려면 커서를 옵션 앞에 놓고 원하는 값을 입력합니다.
옵션을 저장하려면 Esc 키를 누른 다음 :wq를 입력하고 Enter 키를 누릅니다.
vsftpd 설정을 구성하는 방법에 대한 자세한 내용은 vsftpd 문서를 참조하세요.

설명대로 진행해 보고 질문이 있으시면 언제든지 알려주세요. 도와드리겠습니다.
설명대로 진행해 보고 질문이 있으시면 언제든지 알려주세요. 도와드리겠습니다.

### Q

프로필 사진
하라는대로 다 했어. vsftpd 는 virtualbox 에서 실행을 시켰고, vsftpd 서비스를 테스트하기 위해서 virtualbox 가 실행되고 있는 윈도우10 에 winscp 프로그램을 설치했어. 그리고 winscp 에서 vsftpd 가 돌아가고 있는 ubuntu2204 의 ip 인 192.168.100.176 을 입력하고, 사용자로는 현재 등록된 ubuntu 의 사용자를 입력했더니, 정상적으로 접속이 돼서 다른 ftp 서버와 똑같이 사용이 되네! good!
다른 답안 보기

### A

잘하셨습니다! vsftpd를 성공적으로 설치하고 구성하셨습니다.

WinSCP를 사용하여 Ubuntu 22.04의 vsftpd 서비스에 성공적으로 연결하셨습니다. Winscp는 FTP 클라이언트 프로그램으로, Windows 컴퓨터에서 FTP 서버에 연결하여 파일을 전송하고 받을 수 있습니다.

WinSCP를 사용하여 vsftpd 서비스를 테스트하는 방법은 다음과 같습니다.

Winscp를 실행합니다.
Host 필드에 vsftpd 서비스가 실행되고 있는 Ubuntu 22.04의 IP 주소를 입력합니다.
Port 필드에 vsftpd 서비스의 포트 번호(기본값은 21)를 입력합니다.
User 필드에 Ubuntu 22.04의 사용자 이름을 입력합니다.
Password 필드에 사용자의 비밀번호를 입력합니다.
Connect 버튼을 클릭합니다.
WinSCP가 연결에 성공하면 다음과 같은 화면이 표시됩니다.

이제 Winscp를 사용하여 파일을 전송하고 받을 수 있습니다. 파일을 전송하려면 File 메뉴에서 Upload를 선택합니다. 파일을 다운로드하려면 File 메뉴에서 Download를 선택합니다.

vsftpd를 사용하여 파일을 안전하게 전송하고 받을 수 있습니다.

### Q

ok. 그런데, 지금은 ubuntu2204 에 내가 쓰려고 만든 아이디로만 접속이 되고 있는데, 이거 말고 다른 아이디를 새로 만들고 그걸로만 ftp 작업을 하게 하려면 어떻게 해야 되나?

### A

다른 답안 보기

다른 사용자를 추가하려면 다음 단계를 따르세요.

터미널을 열고 다음 명령을 실행합니다.
sudo adduser [사용자 이름]
예:

sudo adduser testuser
이 명령은 새 사용자를 추가합니다.

새 사용자의 비밀번호를 설정합니다.
sudo passwd [사용자 이름]
예:

sudo passwd testuser
이 명령은 새 사용자의 비밀번호를 설정합니다.

새 사용자의 홈 디렉토리를 생성합니다.
sudo mkdir /home/[사용자 이름]
예:

sudo mkdir /home/testuser
이 명령은 새 사용자의 홈 디렉토리를 생성합니다.

새 사용자를 vsftpd의 로컬 사용자로 추가합니다.
vi /etc/vsftpd.conf
이 명령은 /etc/vsftpd.conf 파일을 vi 편집기로 엽니다.

/etc/vsftpd.conf 파일에서 다음 줄을 찾습니다.
```
# local_enable=no
```
이 줄을 다음과 같이 변경합니다.
```
local_enable=yes
```
/etc/vsftpd.conf 파일을 저장하고 종료합니다.

vsftpd 서비스를 다시 시작합니다.
```
sudo systemctl restart vsftpd
```
이 명령은 vsftpd 서비스를 다시 시작하여 새 설정을 적용합니다.

이제 새 사용자로 ftp에 로그인할 수 있습니다.

FTP에 로그인하는 방법

1. FTP 클라이언트 프로그램을 엽니다.
2. Host 필드에 vsftpd 서비스가 실행되고 있는 Ubuntu 22.04의 IP 주소를 입력합니다.
3. Port 필드에 vsftpd 서비스의 포트 번호(기본값은 21)를 입력합니다.
4. User 필드에 새 사용자의 이름을 입력합니다.
5. Password 필드에 새 사용자의 비밀번호를 입력합니다.
6. Connect 버튼을 클릭합니다.

FTP 클라이언트 프로그램이 연결에 성공하면 새 사용자로 로그인된 상태가 됩니다.

### Q

좋아. 새 사용자로 winscp 에서 로그인이 잘 돼. 그런데, 디렉토리를 옮겨다니다 보니, 저 사용자의 상부 디렉토리로도 이동이 되네. 이거는 보안에 문제가 있는거 아닌가? 지금보니 /bin 이나 /lib 디렉토리의 안쪽 파일들, 그리고 /etc/passwd 같은 파일도 그냥 건져서 가져올수가 있네! 이걸 막으려면 어떻게 해야 되나?

### A1


맞습니다. 보안상의 문제가 있습니다. 사용자의 상위 디렉토리로 이동할 수 있으면, 해당 디렉토리에 있는 모든 파일에 액세스할 수 있습니다. 따라서 /bin, /lib, /etc/passwd와 같은 중요한 파일에 액세스할 수 있습니다.

이 문제를 해결하려면 vsftpd의 chroot_local_user 옵션을 사용합니다. 이 옵션을 설정하면 로컬 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다.

chroot_local_user 옵션을 설정하려면 다음 단계를 따르세요.

터미널을 열고 다음 명령을 실행합니다.
vi /etc/vsftpd.conf
이 명령은 /etc/vsftpd.conf 파일을 vi 편집기로 엽니다.

/etc/vsftpd.conf 파일에서 다음 줄을 찾습니다.
chroot_local_user=no
이 줄을 다음과 같이 변경합니다.

chroot_local_user=yes
/etc/vsftpd.conf 파일을 저장하고 종료합니다.

vsftpd 서비스를 다시 시작합니다.

sudo systemctl restart vsftpd
이 명령은 vsftpd 서비스를 다시 시작하여 새 설정을 적용합니다.

이제 chroot_local_user 옵션이 설정되어 있으므로, 새 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다.

chroot_local_user 옵션의 작동 방식

chroot_local_user 옵션은 사용자의 홈 디렉토리로 사용자를 가두어 둡니다. 즉, 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다.

chroot_local_user 옵션은 보안을 강화하는 데 도움이 되는 유용한 기능입니다.

### A

chroot_local_user=YES 를 추가하고 vsftpd 서비스를 다시 실행했어. 그런데 사용자 디렉토리에서 하나 올라가서 /home 디렉토리에 있는 다른 사용자로 들어가려면 

chroot_local_user 옵션을 설정하면 로컬 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다. 따라서 사용자 디렉토리에서 하나 올라가서 /home 디렉토리에 있는 다른 사용자로 들어가려면 에러 메시지가 표시됩니다.

이 문제를 해결하려면 chroot_local_user 옵션을 해제해야 합니다. 다음 단계를 따르세요.

터미널을 열고 다음 명령을 실행합니다.
vi /etc/vsftpd.conf
이 명령은 /etc/vsftpd.conf 파일을 vi 편집기로 엽니다.

/etc/vsftpd.conf 파일에서 다음 줄을 찾습니다.
chroot_local_user=yes
이 줄을 다음과 같이 변경합니다.

chroot_local_user=no
/etc/vsftpd.conf 파일을 저장하고 종료합니다.

vsftpd 서비스를 다시 시작합니다.

sudo systemctl restart vsftpd
이 명령은 vsftpd 서비스를 다시 시작하여 새 설정을 적용합니다.

이제 chroot_local_user 옵션이 해제되었으므로, 새 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 있습니다. 따라서 사용자 디렉토리에서 하나 올라가서 /home 디렉토리에 있는 다른 사용자로 들어갈 수 있습니다.

### Q

엔터가 눌려서 글이 중단됐어. 자신의 홈 디렉토리에서 하나 올라가서 "/home" 디렉토리로 가는것이 되고, 다른 사용자 이름도 다 보이는데, 다른 사용자 디렉토리를 클릭해서 거길 들어가려고 하면 "Permission denied" 라고 나오면서 들어가질 못해. 이게 원래 원하는 것이거든. 그래서 이것은 잘 됐는데, 거기서 하나 더 올라가면 "/" 루트 디렉토리가 되고 모든 디렉토리가 다 보여. 여기서 /etc 디렉토리를 클릭하면 그냥 들어가지고, 다시 passwd 파일을 클릭하면 그 파일이 다운로드돼서 그 내용이 다 보여진다고. 그러니, 처음 로그인 했을때는, 원래의 내 홈 디렉토리로 가고, 위쪽 디렉토리로 가려고 하면 permissin denied 가 나면서 올라가지 못하도록 해야 되는데, 이걸 어떻게 하지?

### A

다른 답안 보기


chroot_local_user 옵션을 사용하면 로컬 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다. 따라서 사용자 디렉토리에서 하나 올라가서 /home 디렉토리에 있는 다른 사용자로 들어가려고 하면 에러 메시지가 표시됩니다.

그러나 /home 디렉토리로 올라가면 루트 디렉토리로 이동할 수 있습니다. 루트 디렉토리로 이동하면 모든 디렉토리에 액세스할 수 있습니다.

이 문제를 해결하려면 chroot_local_user 옵션을 사용하고, chroot_list_enable 옵션을 사용합니다. chroot_list_enable 옵션을 사용하면 사용자를 특정 디렉토리로 제한할 수 있습니다.

chroot_local_user 옵션과 chroot_list_enable 옵션을 설정하려면 다음 단계를 따르세요.

1. 터미널을 열고 다음 명령을 실행합니다.
vi /etc/vsftpd.conf
이 명령은 /etc/vsftpd.conf 파일을 vi 편집기로 엽니다.

2. /etc/vsftpd.conf 파일에서 다음 줄을 찾습니다.
chroot_local_user=no
이 줄을 다음과 같이 변경합니다.

chroot_local_user=yes
3. 다음 줄을 추가합니다.
chroot_list_enable=yes
4. 다음 줄을 추가합니다.
chroot_list_file=/etc/vsftpd/chroot_list
5. /etc/vsftpd/chroot_list 파일을 만듭니다.
sudo touch /etc/vsftpd/chroot_list
6. /etc/vsftpd/chroot_list 파일에 다음 내용을 추가합니다.
/home/[사용자 이름]
예:

/home/testuser
7. /etc/vsftpd.conf 파일을 저장하고 종료합니다.

vsftpd 서비스를 다시 시작합니다.

sudo systemctl restart vsftpd
이제 chroot_local_user 옵션과 chroot_list_enable 옵션이 설정되었습니다. 따라서 로컬 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다. /home 디렉토리로 올라가면 루트 디렉토리로 이동할 수 없습니다.

chroot_local_user 옵션과 chroot_list_enable 옵션의 작동 방식

chroot_local_user 옵션은 사용자의 홈 디렉토리로 사용자를 가두어 둡니다. 즉, 사용자는 자신의 홈 디렉토리 외부의 파일에 액세스할 수 없습니다.

chroot_list_enable 옵션은 사용자를 특정 디렉토리로 제한하는 데 사용됩니다. 이 옵션을 사용하면 chroot_list_file 파일에 나열된 디렉토리로만 사용자를 제한할 수 있습니다.

이러한 옵션을 조합하면 로컬 사용자의 액세스를 제한하여 보안을 강화할 수 있습니다.

### Q


# 231205 화
1020 푸른숲

1. vsftpd 설치후 winscp 로그인하고 상위폴더 접근통제가 안됨.

# 231204 월
1010 푸른숲


## vsftpd

### Setting up vsftpd as a sftp server on Ubuntu
https://unix.stackexchange.com/questions/704714/setting-up-vsftpd-as-a-sftp-server-on-ubuntu

### How to install VSFTPD to Setup FTP Server on Ubuntu 22.04
Last Updated on: April 3, 2023 by Heyan Maurya https://linux.how2shout.com/how-to-install-vsftpd-to-setup-ftp-server-on-ubuntu-22-04/

#### 1. Update Ubuntu 22.04

Let’s start with the running of the system update command because we are going to use an APT package manager to install VSFTPD. Therefore, this step ensures all the latest available updates are on our system.
```
sudo apt update && sudo apt upgrade
```

#### 2. Install VSFTPD on Ubuntu 22.04

We don’t need to add any third-party repository or download any deb binary manually because the official Ubuntu repository is enough; use the APT package manager command given below and you are done:
```
sudo apt install vsftpd
```

#### 3. Check Vsftpd service is active

Once the installation is completed, let’s check the service of this FTP server is running in the background without producing any errors.
```
systemctl status vsftpd --no-pager -l
```

#### 4. Create a user for FTP on Ubuntu 22.04

Let’s create a user that will not have sudo access and we only use it to access a specific folder under its home directory for FTP to read and write files.
```
sudo adduser jjuser
#---- ---- --^^^^^^
```
Note: Change `jjuser` with whatever name you want to give to your user. The above command will also ask you to set the password for the user.

#### 5. Create the FTP folder:

Now, let’s create a folder under the home directory of the newly created user so that the user can only access that to upload and download files. However, to restrict the user’s access to only some specific directory `vsftpd` uses `chroot` that we also need to enable, which we do later in this article. Yet, there is one more problem, it is VSFTPD will not allow a user to connect to the FTP server if the home directory is writable. Therefore, we create a root directory for a user named- FTP under the user’s home that will act as `chroot`, and inside that, there will be another directory known as upload to hold the files.

Note: Don’t forget to Replace `jjuser` with your created user.
```
sudo mkdir /home/jjuser/ftp
#---- ---- ---- -^^^^^^
```

Configure ownership:
```
sudo chown nobody:nogroup /home/jjuser/ftp
#---- ---- ---- ---- ---- ---- -^^^^^^
```

Remove the root FTP folder writable permission:
```
sudo chmod a-w /home/jjuser/ftp
```

Create a directory to upload files, which going to hold your files:
```
sudo mkdir /home/jjuser/ftp/upload
```

Give created upload  folder ownership to our FTP user
```
sudo chown jjuser:jjuser /home/jjuser/ftp/upload
```

Now to test, let’s a create demo file inside the upload folder:
```
echo "My FTP Server" | sudo tee /home/jjuser/ftp/upload/demo.txt
```

Finally, check the permission for the FTP directory:
```
sudo ls -la /home/jjuser/ftp
```

#### 6. Configuring VSFTPD on Ubuntu 22.04

After installation, the configuration file `/etc/vsftpd.conf` must be adapted to your own needs with an editor. The file is commented on in detail. Nevertheless, the most important settings are explained below.
```
sudo nano /etc/vsftpd.conf
```

#### 7. How to enable Anonymous user

(optional) By default due to security reasons, nobody can log in to the FTP server anonymously (without using a valid user). However, due to any reason, if you want to enable it then find a line- `anonymous_enable=No` and change **NO** to **YES**.

#### 8. Enable Local FTP user

Well, to access the FTP server using the users you have created and available on your system, you can look for a line given below in Vsftpd config file on Ubuntu 22.04:
```
local_enable=YES
```
**By default**, it is set to **YES** or enabled, hence there is no need to do anything.

#### 9. Enable file & folder upload

In the basic configuration, no user is allowed to write via FTP. Neither local users (if they are allowed by “local_enable=YES”), nor anonymous users.  To enable the uploading of files to the FTP server, we need to

**#** Uncomment this to enable any form of FTP to write a command.
```
write_enable=YES
```

#### 10. Restrict local users to their home directory

Now, restrict local users to their home directories. So, that they can’t access the files outside of their home directories. Find the below line and remove the # given in front of it to enable it.
```
chroot_local_user=YES
```

Scroll to the end of the file and the following lines, this will ensure that when a user login the FTP server, it routes to the directory that is meant to be accessed.
```
user_sub_token=$USER
local_root=/home/$USER/ftp
Set Passive ports:
```

The Vsftpd uses active mode by default on ports – 20 / 21 to communicate if you want to set up passive mode as well which works if there is some firewall issue between the client and server. However, both the server and the client must support passive FTP mode for this process to work. However, the passive ports must be allowed in the server firewall. [ Know about its configuration ](https://documentation.meraki.com/MX/NAT_and_Port_Forwarding/Active_and_Passive_FTP_Overview_and_Configuration#:~:text=Passive%20FTP%20is%20an%20FTP,the%20connection%20to%20the%20server.).
```
pasv_min_port=30000
pasv_max_port=31000
```

Also, add the following lines which make sure the VSFTPD only allows the access of users to the FTP server which are in its list not anyone randomly.
```
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
```

Save the file using **Ctrl+O**, hit the **Enter** Key, and Exit the file using **Ctrl+X**.

Also, don’t forget to open ports in the firewall, if you are using UFW then use this command other wiser open the system in your cloud or network firewall. Port 900 is for TLS.
```
sudo ufw allow 20,21,990/tcp
```
```
sudo ufw allow 30000:31000/tcp
```

#### 11. Add created user to the VSFTPD User list

Next, add the created user to the VSFTPD user list file, so that it allows that user to log in and access the FTP server.
```
echo "jjarchive" | sudo tee -a /etc/vsftpd.userlist
```
Note: Replace `jjarchive` with your created user.

#### 12. Restart the VSFTPD Server
To apply the changes we have made so far, restart the FTP server service once:
```
sudo systemctl restart vsftpd
```

#### /etc/vsftpd.conf 변경

- FTP는 어떻게 사용하나요? https://cafe24.zendesk.com/hc/ko/articles/5729931658649-FTP%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EC%82%AC%EC%9A%A9%ED%95%98%EB%82%98%EC%9A%94-
- vsftpd 설정 및 config 정리 210422 https://blog.innern.net/16
- vsftpd 설치 및 설정 https://help.iwinv.kr/manual/read.html?idx=91

- 최종 수정본
```
13:57:34화231205 yosj@gusudong ~
~ $ sudo systemctl restart vsftpd ; systemctl status vsftpd --no-pager -l
● vsftpd.service - vsftpd FTP server
     Loaded: loaded (/lib/systemd/system/vsftpd.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-12-05 13:57:40 KST; 6ms ago
    Process: 4778 ExecStartPre=/bin/mkdir -p /var/run/vsftpd/empty (code=exited, status=0/SUCCESS)
   Main PID: 4779 (vsftpd)
      Tasks: 1 (limit: 4558)
     Memory: 920.0K
        CPU: 5ms
     CGroup: /system.slice/vsftpd.service
             └─4779 /usr/sbin/vsftpd /etc/vsftpd.conf

12월 05 13:57:40 gusudong systemd[1]: Starting vsftpd FTP server...
12월 05 13:57:40 gusudong systemd[1]: Started vsftpd FTP server.
13:57:40화231205 yosj@gusudong ~
~ $ sudo /usr/sbin/vsftpd /etc/vsftpd.conf
500 OOPS: could not bind listening IPv6 socket

15:30:51화231205 yosj@gusudong /etc
etc $ cat /etc/vsftpd.conf
# Example config file /etc/vsftpd.conf
#
# The default compiled in settings are fairly paranoid. This sample file
# loosens things up a bit, to make the ftp daemon more usable.
# Please see vsftpd.conf.5 for all compiled in defaults.
#
# READ THIS: This example file is NOT an exhaustive list of vsftpd options.
# Please read the vsftpd.conf.5 manual page to get a full idea of vsftpd's
# capabilities.
#
#
# Run standalone?  vsftpd can run either from an inetd or as a standalone
# daemon started from an initscript.
listen=NO
#
# This directive enables listening on IPv6 sockets. By default, listening
# on the IPv6 "any" address (::) will accept connections from both IPv6
# and IPv4 clients. It is not necessary to listen on *both* IPv4 and IPv6
# sockets. If you want that (perhaps because you want to listen on specific
# addresses) then you must run two copies of vsftpd with two configuration
# files.
listen_ipv6=YES
#
# Allow anonymous FTP? (Disabled by default).
anonymous_enable=NO
#
# Uncomment this to allow local users to log in.
local_enable=YES
#
# Uncomment this to enable any form of FTP write command.
write_enable=YES
#--- 업로드를 허용할 경우만 '#'주석 해제 (원래 # 있음)
#
# Default umask for local users is 077. You may wish to change this to 022,
# if your users expect that (022 is used by most other ftpd's)
#local_umask=022
#
# Uncomment this to allow the anonymous FTP user to upload files. This only
# has an effect if the above global write enable is activated. Also, you will
# obviously need to create a directory writable by the FTP user.
#anon_upload_enable=YES
#
# Uncomment this if you want the anonymous FTP user to be able to create
# new directories.
#anon_mkdir_write_enable=YES
#
# Activate directory messages - messages given to remote users when they
# go into a certain directory.
dirmessage_enable=YES
#
# If enabled, vsftpd will display directory listings with the time
# in  your  local  time  zone.  The default is to display GMT. The
# times returned by the MDTM FTP command are also affected by this
# option.
use_localtime=YES
#
# Activate logging of uploads/downloads.
xferlog_enable=YES
#
# Make sure PORT transfer connections originate from port 20 (ftp-data).
connect_from_port_20=YES
#
# If you want, you can arrange for uploaded anonymous files to be owned by
# a different user. Note! Using "root" for uploaded files is not
# recommended!
#chown_uploads=YES
#chown_username=whoever
#
# You may override where the log file goes if you like. The default is shown
# below.
#xferlog_file=/var/log/vsftpd.log
#
# If you want, you can have your log file in standard ftpd xferlog format.
# Note that the default log file location is /var/log/xferlog in this case.
#xferlog_std_format=YES
#
# You may change the default value for timing out an idle session.
#idle_session_timeout=600
#
# You may change the default value for timing out a data connection.
#data_connection_timeout=120
#
# It is recommended that you define on your system a unique user which the
# ftp server can use as a totally isolated and unprivileged user.
#nopriv_user=ftpsecure
#
# Enable this and the server will recognise asynchronous ABOR requests. Not
# recommended for security (the code is non-trivial). Not enabling it,
# however, may confuse older FTP clients.
#async_abor_enable=YES
#
# By default the server will pretend to allow ASCII mode but in fact ignore
# the request. Turn on the below options to have the server actually do ASCII
# mangling on files when in ASCII mode.
# Beware that on some FTP servers, ASCII support allows a denial of service
# attack (DoS) via the command "SIZE /big/file" in ASCII mode. vsftpd
# predicted this attack and has always been safe, reporting the size of the
# raw file.
# ASCII mangling is a horrible feature of the protocol.
#ascii_upload_enable=YES
#ascii_download_enable=YES
#
# You may fully customise the login banner string:
#ftpd_banner=Welcome to blah FTP service.
#
# You may specify a file of disallowed anonymous e-mail addresses. Apparently
# useful for combatting certain DoS attacks.
#deny_email_enable=YES
# (default follows)
#banned_email_file=/etc/vsftpd.banned_emails
#
# You may restrict local users to their home directories.  See the FAQ for
# the possible risks in this before using chroot_local_user or
# chroot_list_enable below.
###chroot_local_user=YES
#--- 로컬 사용자가 홈 디렉토리 외부 액세스 못하게 할 경우만 '#'주석 해제 (원래 # 있음)
user_sub_token=$USER
#--- 로그인시 디렉토리로 라우팅 (추가)
local_root=/home/$USER/ftp
#--- (추가)
#Set Passive ports: #--- (추가)
pasv_enable=YES
pasv_min_port=30000
#--- 수동 FTP 모드의 포트 범위. port 20 = 기본 활성모드 (추가)
pasv_max_port=31000
#--- (추가)
userlist_enable=YES
#--- 목록에 있는 사용자 액세스만 허용 (추가)
userlist_file=/etc/vsftpd.userlist
allow_writeable_chroot=YES
#--- (추가)
userlist_deny=NO
#--- (추가)
#--- 이 경우 다음과 같이 방화벽에서 포트를 열어야 한다. (추가)
#--- sudo ufw allow 20,21,990/tcp #--- (추가)
#--- sudo ufw allow 30000:31000/tcp #--- (추가)
#--- echo "jjuser" | sudo tee -a /etc/vsftpd.userlist #--- 생성된 사용자를 VSFTPD 사용자 목록에 추가하고, (추가)
#--- sudo systemctl restart vsftpd ; systemctl status vsftpd --no-pager -l #--- VSFTPD 서버를 다시 시작하고 확인 (추가)
# You may specify an explicit list of local users to chroot() to their home
# directory. If chroot_local_user is YES, then this list becomes a list of
# users to NOT chroot().
# (Warning! chroot'ing can be very dangerous. If using chroot, make sure that
# the user does not have write access to the top level directory within the
# chroot)
chroot_local_user=NO
chroot_list_enable=YES
# "jj" -> chroot_list
# | chroot_local_user | chroot_list_enable | login
# | YES               | YES                | "jj" -> pwd -> /home/jj ; cd .. -> /home
# | YES               | YES                | "xxx" -> pwd -> / ; cd .. -> /
#
# | YES               | NO                 | "jj" -> pwd -> / ; cd .. -> /
# | YES               | NO                 | "xxx" -> pwd -> / ; cd .. -> /
#
# | NO                | YES                | "jj" -> pwd -> / ; cd .. -> /
# | NO                | YES                | "xxx" -> pwd -> /home/xxx ; cd .. -> /home
#
# | NO                | NO                 | "jj" -> pwd -> /home/jj ; cd .. -> /home
# | NO                | NO                 | "xxx -> pwd -> /home/xxx; cd .. -> /home
# (default follows)
chroot_list_file=/etc/vsftpd.login_chroot_list
#
# You may activate the "-R" option to the builtin ls. This is disabled by
# default to avoid remote users being able to cause excessive I/O on large
# sites. However, some broken FTP clients such as "ncftp" and "mirror" assume
# the presence of the "-R" option, so there is a strong case for enabling it.
#ls_recurse_enable=YES
#
# Customization
#
# Some of vsftpd's settings don't fit the filesystem layout by
# default.
#
# This option should be the name of a directory which is empty.  Also, the
# directory should not be writable by the ftp user. This directory is used
# as a secure chroot() jail at times vsftpd does not require filesystem
# access.
secure_chroot_dir=/var/run/vsftpd/empty
#
# This string is the name of the PAM service vsftpd will use.
pam_service_name=vsftpd
#
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO

#
# Uncomment this to indicate that vsftpd use a utf8 filesystem.
#utf8_filesystem=YES
16:28:55화231205 yosj@gusudong /etc
```

- 수정전 원본
```
# Example config file /etc/vsftpd.conf
#
# The default compiled in settings are fairly paranoid. This sample file
# loosens things up a bit, to make the ftp daemon more usable.
# Please see vsftpd.conf.5 for all compiled in defaults.
#
# READ THIS: This example file is NOT an exhaustive list of vsftpd options.
# Please read the vsftpd.conf.5 manual page to get a full idea of vsftpd's
# capabilities.
#
#
# Run standalone?  vsftpd can run either from an inetd or as a standalone
# daemon started from an initscript.
listen=NO
#
# This directive enables listening on IPv6 sockets. By default, listening
# on the IPv6 "any" address (::) will accept connections from both IPv6
# and IPv4 clients. It is not necessary to listen on *both* IPv4 and IPv6
# sockets. If you want that (perhaps because you want to listen on specific
# addresses) then you must run two copies of vsftpd with two configuration
# files.
listen_ipv6=YES
#
# Allow anonymous FTP? (Disabled by default).
anonymous_enable=NO
#
# Uncomment this to allow local users to log in.
local_enable=YES
#
# Uncomment this to enable any form of FTP write command.
#write_enable=YES
#
# Default umask for local users is 077. You may wish to change this to 022,
# if your users expect that (022 is used by most other ftpd's)
#local_umask=022
#
# Uncomment this to allow the anonymous FTP user to upload files. This only
# has an effect if the above global write enable is activated. Also, you will
# obviously need to create a directory writable by the FTP user.
#anon_upload_enable=YES
#
# Uncomment this if you want the anonymous FTP user to be able to create
# new directories.
#anon_mkdir_write_enable=YES
#
# Activate directory messages - messages given to remote users when they
# go into a certain directory.
dirmessage_enable=YES
#
# If enabled, vsftpd will display directory listings with the time
# in  your  local  time  zone.  The default is to display GMT. The
# times returned by the MDTM FTP command are also affected by this
# option.
use_localtime=YES
#
# Activate logging of uploads/downloads.
xferlog_enable=YES
#
# Make sure PORT transfer connections originate from port 20 (ftp-data).
connect_from_port_20=YES
#
# If you want, you can arrange for uploaded anonymous files to be owned by
# a different user. Note! Using "root" for uploaded files is not
# recommended!
#chown_uploads=YES
#chown_username=whoever
#
# You may override where the log file goes if you like. The default is shown
# below.
#xferlog_file=/var/log/vsftpd.log
#
# If you want, you can have your log file in standard ftpd xferlog format.
# Note that the default log file location is /var/log/xferlog in this case.
#xferlog_std_format=YES
#
# You may change the default value for timing out an idle session.
#idle_session_timeout=600
#
# You may change the default value for timing out a data connection.
#data_connection_timeout=120
#
# It is recommended that you define on your system a unique user which the
# ftp server can use as a totally isolated and unprivileged user.
#nopriv_user=ftpsecure
#
# Enable this and the server will recognise asynchronous ABOR requests. Not
# recommended for security (the code is non-trivial). Not enabling it,
# however, may confuse older FTP clients.
#async_abor_enable=YES
#
# By default the server will pretend to allow ASCII mode but in fact ignore
# the request. Turn on the below options to have the server actually do ASCII
# mangling on files when in ASCII mode.
# Beware that on some FTP servers, ASCII support allows a denial of service
# attack (DoS) via the command "SIZE /big/file" in ASCII mode. vsftpd
# predicted this attack and has always been safe, reporting the size of the
# raw file.
# ASCII mangling is a horrible feature of the protocol.
#ascii_upload_enable=YES
#ascii_download_enable=YES
#
# You may fully customise the login banner string:
#ftpd_banner=Welcome to blah FTP service.
#
# You may specify a file of disallowed anonymous e-mail addresses. Apparently
# useful for combatting certain DoS attacks.
#deny_email_enable=YES
# (default follows)
#banned_email_file=/etc/vsftpd.banned_emails
#
# You may restrict local users to their home directories.  See the FAQ for
# the possible risks in this before using chroot_local_user or
# chroot_list_enable below.
#chroot_local_user=YES
#
# You may specify an explicit list of local users to chroot() to their home
# directory. If chroot_local_user is YES, then this list becomes a list of
# users to NOT chroot().
# (Warning! chroot'ing can be very dangerous. If using chroot, make sure that
# the user does not have write access to the top level directory within the
# chroot)
#chroot_local_user=YES
#chroot_list_enable=YES
# (default follows)
#chroot_list_file=/etc/vsftpd.chroot_list
#
# You may activate the "-R" option to the builtin ls. This is disabled by
# default to avoid remote users being able to cause excessive I/O on large
# sites. However, some broken FTP clients such as "ncftp" and "mirror" assume
# the presence of the "-R" option, so there is a strong case for enabling it.
#ls_recurse_enable=YES
#
# Customization
#
# Some of vsftpd's settings don't fit the filesystem layout by
# default.
#
# This option should be the name of a directory which is empty.  Also, the
# directory should not be writable by the ftp user. This directory is used
# as a secure chroot() jail at times vsftpd does not require filesystem
# access.
secure_chroot_dir=/var/run/vsftpd/empty
#
# This string is the name of the PAM service vsftpd will use.
pam_service_name=vsftpd
#
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO

#
# Uncomment this to indicate that vsftpd use a utf8 filesystem.
#utf8_filesystem=YES
```

- 오류 수정전 `diff vsftpd.conf-old-220224 /etc/vsftpd.conf`
```
31c31
< #write_enable=YES
---
> #write_enable=YES #--- 업로드를 허용할 경우만 '#'주석 해제 (원래 # 있음)
114,115c114,127
< #chroot_local_user=YES
< #
---
> chroot_local_user=YES #--- 로컬 사용자가 홈 디렉토리 외부 액세스 못하게 할 경우만 '#'주석 해제 (원래 # 있음)
> user_sub_token=$USER #--- 로그인시 디렉토리로 라우팅 (추가)
> local_root=/home/$USER/ftp #--- (추가)
> Set Passive ports: #--- (추가)
> pasv_min_port=30000 #--- 수동 FTP 모드의 포트 범위. port 20 = 기본 활성모드 (추가)
> pasv_max_port=31000 #--- (추가)
> userlist_enable=YES #--- 목록에 있는 사용자 액세스만 허용 (추가)
> userlist_file=/etc/vsftpd.userlist #--- (추가)
> userlist_deny=NO #--- (추가)
> #--- 이 경우 다음과 같이 방화벽에서 포트를 열어야 한다. (추가)
> #--- sudo ufw allow 20,21,990/tcp #--- (추가)
> #--- sudo ufw allow 30000:31000/tcp #--- (추가)
> #--- echo "jjuser" | sudo tee -a /etc/vsftpd.userlist #--- 생성된 사용자를 VSFTPD 사용자 목록에 추가하고, (추가)
> #--- sudo systemctl restart vsftpd #--- VSFTPD 서버를 다시 시작 (추가)
```

#### 13. Connect to Test your FTP Server

We can use both the command line and GUI app to test the server to know whether it is working or not. Let’s first try with the command line:

Using Command line
-p is for passive mode
```
ftp -p 192.168.135.129
```

Note: Replace `192.168.135.129` with your Ubuntu 22.04 Server address where VSFTPD is installed.

As it asked for a **Name**, enter the FTP server **username** and then the **password**, you have set. If you have configured everything right, you will be able to log in.

#### Test Using File Zilla

Here we are using GUI FTP client FileZilla, you can use any other you have. On your FTP client enter the IP address of the Ubuntu 22.04 server where you have configured the VSFTPD. After that add the username and password.

#### 14. Setup SSL/TSL for Vsftpd on Ubuntu 22.04

By default, the data transfer using the Vsftpd FTP server will not be in an encrypted format even the credentials, to remove this security flaw we can configure SSL using OpenSSL to provide encryption.

On your command terminal, first, run:
```
sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
```

This will generate the required 2048-bit private key and self-signed SSL certificate.

Once you have generated the SSL certificate, edit the VSFTPD configuration file and add the location of the Private key and SSL certificate to that.
```
sudo nano /etc/vsftpd.conf
```

Scroll down to find the following lines and change their values as shown further:

rsa_cert_file=~~/etc/ssl/certs/ssl-cert-snakeoil.pem~~
rsa_private_key_file=~~/etc/ssl/private/ssl-cert-snakeoil.key~~
ssl_enable=~~NO~~

Change the values of `rsa_cert_file` and `rsa_private_key_file` directives with the path of the SSL & Private key file we have generated. Also, change `ssl_enable=NO` to `ssl_enable=YES`. As shown below:
```
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
ssl_enable=YES
```

Also, scroll to the end of the file and add:
```
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
```

This will deny access to Anonymous connection over SSL and force users to transfer data and log in using SSL only:

Save the file using <kbd>Ctrl</kbd>+<kbd>O</kbd>, hit the <kbd>Enter</kbd> key, and then exit using <kbd>Ctrl</kbd>+<kbd>X</kbd>.

Restart the FTP server:
```
sudo systemctl restart vsftpd
```

Now, check whether we can access the FTP server over TSL or not. Here we are using again the FileZilla:

#### 15. How to update VSFTPD

As we have used the default system repository to install this open-source FTP server, hence we can use the system update and upgrade command as well to get future updates for this server application.
```
sudo apt update && sudo apt upgrade
```

#### 16. Uninstall or Remove

To completely uninstall VSFTPD from Ubuntu 22.04, in case you don’t require this FTP server anymore on your system. Then, here is the command to follow:
```
sudo apt autoremove --purge vsftpd*
```

#### FAQ

- What does Vsftpd stand for?

VSFTPD stands for Very Secure FTP Daemon. It is an open-source FTP server for Unix and Linux to transfer data from the FTP client to the server and vice versa.

- What is the difference between FTP and Vsftpd?

FTP is a file transfer protocol (FTP for short) whereas VSFTP is a server application that provides a platform to use FTP protocol efficiently and securely. FTP is used in large networks or servers to exchange files between server and PC or network and PC. We can use the FTP protocol to create, move, or delete directories on the server or network.

- Is Vsftpd safe?

Yes, VSFTPD is one of the safest open-source FTP servers available to use free of cost. Apart from being secure it also offers fast speed and stability.

- What protocol does Vsftpd use?

Vsftpd uses FTP protocol (stands for File transfer) to transfer the data and it stands for “Very Secure FTP Daemon“.

- Is Vsftpd open source?

Yes, VSFTPD is an open-source server application licensed under the GNU General Public License. Therefore, the source code of VSFTPD is available for everyone.

- Other Articles:

[ How to install FileZilla Server on Ubuntu 20.04/18.04 Linux ](https://www.how2shout.com/linux/install-filezilla-server-on-ubuntu-20-04-18-04-linux/)
[ How to Install FileZilla FTP Client on Ubuntu 22.04 LTS Jammy ](https://www.how2shout.com/linux/how-to-install-filezilla-ftp-client-on-ubuntu-22-04-lts-jammy/)
[ 2 ways to Install LibreCAD on Ubuntu 22.04 LTS Jammy Linux ](https://www.how2shout.com/linux/2-ways-to-install-librecad-on-ubuntu-22-04-lts-jammy-linux/)
[ Install Foxit PDF Reader on Ubuntu 22.04 LTS Linux ](https://www.how2shout.com/linux/install-foxit-pdf-reader-on-ubuntu-22-04-lts-linux/)
[ Create a New User in Ubuntu 22.04 or 20.04 using GUI or Terminal ](https://www.how2shout.com/linux/create-a-new-user-in-ubuntu-22-04-or-20-04-using-gui-or-terminal/)


# 231201 금
0920 진도

## 파일이름 변경 스크립트

- 파일 이름에 공백 또는 특수문자가 들어있어서 스크립트로 처리시 문제가 발생하므로, 다음 스크립트로 파일의 이름을 수정하였다.

`cat ~/git-projects/fedora-sh/rclone-all-list/change_name_char.sh`

```
#!/bin/sh

for fn in *
do
    new_fn=$(echo ${fn} | sed 's/\[//g' | sed 's/\]//g' | sed 's/(//g' | sed 's/)//g' | sed 's/,/./g' | sed 's/／/-/g' | sed 's/ - /-/g' | sed 's/ /_/g')
    if [ "x$fn" = "x$new_fn" ]; then
        cat <<__EOF__

#-- ---- ---- ----
$(ls -l ${new_fn})
__EOF__
    else
        cat <<__EOF__

#-- ---- ---- ----
$(ls -l "${fn}")

__EOF__
        cat <<__EOF__
mv "${fn}" ${new_fn}
----> press Enter: ['n' = 이름을 바꾸지 않음]
__EOF__
        read a
        if [ "x$a" != "xn" ]; then
            mv "${fn}" ${new_fn}
            ls -l ${new_fn}
        fi
    fi
done
```
- `ls -l` 명령으로 파일 이름을 확인할때, 이름에 공백이 들어가면 이름이 분리되므로, 이런때는 ` "${fn}"` 처럼 큰따옴표를 앞뒤로 해 주어야 한다.


## 클라우드 목록에서 이름 추출

### 1. 목록의 내역

```
    414004 2021-07-30 07:10:52.000000000 yosjgc:Life/책메모/BOOK-vue.js-2-시작하기/386.jpg
       288 2021-07-30 08:23:03.000000000 yosjgc:Life/책메모/BOOK-vue.js-2-시작하기/a.sh
   4081426 2020-06-12 17:09:55.106000000 yosjgc:Life/책메모/IMG_20200612_164347.jpg
   5165799 2020-06-12 17:10:37.041000000 yosjgc:Life/책메모/IMG_20200612_170827.jpg
        -1 2020-05-11 00:36:32.866000000 yosjgc:Life/책메모/노자/이경숙 노자도덕경.docx
        -1 2020-07-12 20:52:38.039000000 yosjgc:Life/책메모/채근담/채근담 전집-100 완역.docx
```

### 2. 목록에서 사이즈가 -1 인것만 추출

`grep " -1 " ../16-yosjgc-231130목143424.lsl`
```
        -1 2020-05-11 00:36:32.866000000 yosjgc:Life/책메모/노자/이경숙 노자도덕경.docx
        -1 2020-07-12 20:52:38.039000000 yosjgc:Life/책메모/채근담/채근담 전집-100 완역.docx
```

`grep " -1 " ../16-yosjgc-231130목143424.lsl | awk -F"yosj" '{print "yosj"$2}'`
```
yosjgc:Life/책메모/노자/이경숙 노자도덕경.docx
yosjgc:Life/책메모/채근담/채근담 전집-100 완역.docx
```

`grep " -1 " ../16-yosjgc-231130목143424.lsl | awk -F"yosj" '{print "yosj"$2}' | grep 책메모 | awk -F"/" '{print $NF}'
`
```
이경숙 노자도덕경.docx
채근담 전집-100 완역.docx
채근담 전집-225 원본.docx
채근담 후집-134 완역.docx
채근담 후집-134 원본.docx
춘향전(春香傳) 3.docx
```

### 3. 파일 이름만 표시

- ls 내용에서 사이즈 -1 만 골라내고 거기서 파일 디렉토리 빼고 파일 이름만 표시한다.

```
rclone ls yosjgc:Life/Job/01-서원타이어/서원자료 | grep " -1 " | awk -F" -1 " '{print "/"$2}' | awk -F"/" '{print $NF}'
```

### 4. 파일 이름이 중복해서 나타남

```
test01-1337 $ rclone delete "yosjgc:현대 공유/Old files/changed_2020_고정비_지출.xlsx.7z"
15:24:47금231201 yosj@gusudong ~/231130-143152/download_yosj_to_hear-231130-1700/test01-1337
test01-1337 $ rclone lsl "yosjgc:현대 공유/Old files/"
    21223 2023-12-01 15:19:41.801000000 changed2_2020_고정비_지출.xlsx.7z
       -1 2022-01-02 12:24:34.069000000 2021-1 2 3 가계부.xlsx
    21223 2023-12-01 14:47:10.367000000 2020 고정비 지출.xlsx.7z/2020 고정비 지출.xlsx.7z
15:25:00금231201 yosj@gusudong ~/231130-143152/download_yosj_to_hear-231130-1700/test01-1337
test01-1337 $ ll
total 160
-rw-rw-r-- 1 yosj yosj 110113  1월  2  2022 '2020 고정비 지출.xlsx'
-rw-rw-r-- 1 yosj yosj  21223 12월  1 14:47 '2020 고정비 지출.xlsx.7z'
-rw-rw-r-- 1 yosj yosj    829 12월  1 14:47  a.sh
-rw-rw-r-- 1 yosj yosj  21223 12월  1 15:19  changed2_2020_고정비_지출.xlsx.7z
15:25:26금231201 yosj@gusudong ~/231130-143152/download_yosj_to_hear-231130-1700/test01-1337
test01-1337 $ cat a.sh
#!/bin/sh

echo "----> (1) fn=\"현대 공유/Old files/2020 고정비 지출.xlsx\""
fn="현대 공유/Old files/2020 고정비 지출.xlsx"
echo "----> (2) nameonly=\$(echo \${fn} | awk -F\"/\" '{print \$NF}')"
nameonly=$(echo ${fn} | awk -F"/" '{print $NF}')
echo "----> (3) dirname=\"\${fn/\$nameonly/''}\" #-- dir=\"\$fn\".replace(\"\${nameonly}\",\"\")<-- 안됨"
dirname="${fn/$nameonly/''}"
echo "----> (4) dirname='${dirname}' ; nameonly='${nameonly}' ; rclone copy \"yosjgc:${fn}\" ."
rclone copy "yosjgc:${fn}" .
echo "----> (5) 7za a -mx=9 \"${nameonly}.7z\" \"${nameonly}\""
7za a -mx=9 "${nameonly}.7z" "${nameonly}"
echo "----> (6) rclone copyto \"${nameonly}.7z\" \"yosjgc:${fn}.7z\""
rclone copyto "${nameonly}.7z" "yosjgc:${fn}.7z"
echo "----> (7) rclone ls \"yosjgc:${dirname}\""
rclone ls "yosjgc:${dirname}"
```

### 5. 최종 작업본

`cat minus1-resave-7zip.sh`
```
#!/bin/sh

echo "----> rclone ls yosjgc: | grep ' -1 ' | awk -F' -1 ' '{print $2}' | while read fn"
rclone ls yosjgc: | grep ' -1 ' | awk -F' -1 ' '{print $2}' | while read fn
do
        nameonly=$(echo ${fn} | awk -F"/" '{print $NF}')
        #-- Replacing a Substring With Another String in Bash Learn how to replace a single or multiple occurrences of a substring inside a string in Bash.  Sep 24, 2021 — Avimanyu Bandyopadhyay https://linuxhandbook.com/replace-string-bash/
        #-- ${원본문자열/바꾸려는문자열/바꿔넣을문자열}
        dirname="${fn/$nameonly/''}"
        rclone copy "yosjgc:${fn}" .
        echo "^^^ rclone copy "yosjgc:${fn}" . ^^^"
        7za a -mx=9 "${nameonly}.7z" "${nameonly}"
        echo "^^^ 7za a -mx=9 "${nameonly}.7z" "${nameonly}" ^^^"
        rclone copy "${nameonly}.7z" "yosjgc:${fn}.7z"
        echo "^^^ rclone copy "${nameonly}.7z" "yosjgc:${fn}.7z" ^^^"
done
rclone ls "yosjgc:${dirname}"
echo "^^^ rclone ls "yosjgc:${dirname}" ^^^"
```

## bash

### vi 매크로
1. `q` 로 시작 + (`a` ~ `z` 글자 중에서) `a`자 를 선택해서 담기로 함. 
1. 이후에는 보통 vi 에서 하듯이 작업할 내용을 입력.
1. 끝내려면 `q` 를 눌러서 마감한다.

#### vi 매크로 예제
```
-1 2011-12-01 18:15:38.631000000 yosjgc:root/Google 노트에서 가져온 문서 - 노트 1.docx
^^^^^|||||^^^^^|||||^^^^^|||||^^^                                                  ^^^^^
```
-1 의 앞에 공백이 8개 있다.
위 파일을 아래와 같이 수정하려고 한다.
```
rclone copy yosjgc:root/Google\ 노트에서\ 가져온\ 문서\ -\ 노트\ 1.docx .
^^^^^|||||^^                                                       ^^^
```

#### 매크로를 'a'에 등록
```
qa0kj41srclon_copy_<ESC>A .<ESC>0jq
||--------(3) 매크로-작업-----------|
||--------------------------------+--- (4) 매크로 끝
|+--- (2) 알파벳 'a' 에 매크로를 기록한다.
+--- (1) 매크로 시작
```

#### 'a' 매크로를 실행
```
@a
```
#### 'a' 매크로를 (예를 들어) 5번 실행
```
5@a
```


## todo

- [ ] kaos, wikijs, yosjgc, calls_sms 백업 제대로 되는지 확인하는 스크립트
- [ ] kaos 백업 정리후 이전 준비
- [ ] orangepi 에서 wordpress 운영
- [ ] chrome extension
- [ ] spring boot + svelte + nextjs
- [ ] prisma 로 database 입문
1. prisma 빠른 시작 https://www.prisma.io/docs/getting-started/quickstart
- [ ] github.com 계정생성
- [ ] 엑셀 원본파일을 google drive 에서 열고 작업 (저장), vftpd 로 업로드, winscp 로 다운로드, google 엑셀에서 vlookup 으로 채우기

## youtube



┏━┳┓
┃╌┃┃🇰🇷
┣━╋┫
┗━┻┛

### `날짜 역순` 으로 `한달치만` 기록하고, 달이 바뀌면 다음과 같이 처리한다.

1. Page Action --> Move/Rename --> Pages 에서 옮기려는 `2023-11 일지` 를 클릭 --> 아랫쪽 `[en v]`옆의 Path 에 `/ ilji/2311` 입력하고 --> `[v Select]` 클릭해서  파일 이름을 바꾼다.

1. 다시 불러오기 `Ctrl + R` 하면 --> 윗작업의 결과로 `"/ home"` 파일이 `"/ ilji/2311"` 파일로 바뀌었기 때문에 `"/ home"` 파일이 없으므로 --> 나온 화면에서 `[+ CREATE HOME PAGE]` 를 누른 다음,
Title:
`2023-12 일지`
Short:
`작성중`
Path:
`/ home`
으로 지정해서 `"/ home"` 파일을 새로 만든다.

1. HP ENVY-7640 printer 인쇄시 (레이아웃 `세로방향` / 설정 더보기 > 용지 크기 (`A4`) / 시트당 페이지 수 (`1`) / 여백 맞춤 > 상하 `10m/m`, 좌우 `5m/m` / 양면 `[v]`양면에 인쇄 / `[-]` 위로 넘김)

✨
✨

### Zoom 테스트
Zoom 테스트 미팅 https://support.zoom.us/hc/ko-kr/articles/115002262083-Zoom-%ED%85%8C%EC%8A%A4%ED%8A%B8-%EB%AF%B8%ED%8C%85-%EC%B0%B8%EC%97%AC%ED%95%98%EA%B8%B0

남양주평생학습포털다산서당
https://dasanedu.nyj.go.kr/home/myLectureList.do

1. 💗❤️💚🐾📌😊😃😝🤣🤗🌞🔥🍊🍓●➡️➜🔎📈🔽✅⌚⭐❱❱💡🔋🔉💸
💰🎁1️⃣2️⃣3️⃣🔗👈👉🔼🎨👀🚀🎯💰🔑⚡☕💬🎂✨🧩🛍️🚩🐈🐾🐱🐕
🐒 🎗 ☢️️️️ 👹 🌙
🇰🇷🌳🚲🔵🚙🔱 ✍

💗 ❤️ 💚 🐾 📌 😊 😃 😝 🤣 🤗 🌞 🔥 🍊 🍓 ● ➡️ ➜ 🔎 📈 🔽 ✅
⌚ ⭐ ❱ ❱ 💡 🔋 🔉 💸 💰 🎁 1️⃣ 2️⃣ 3️⃣ 🔗 👈 👉 🔼 🎨 👀 🚀 🎯
💰 🔑 ⚡ ☕ 💬 🎂 ✨ 🧩 🛍️ 🚩 🐈 🐾 🐱 🐕 🐒 🎗 ☢️️️️ 👹 🌙 🇰🇷
🌳 🚲 🔵 🚙 🔱

💗❤️💚🐾📌😊😃😝🤣🤗🌞🔥🍊🍓●➡️➜🔎📈🔽✅⌚⭐❱❱💡🔋🔉💸
💰🎁1️⃣2️⃣3️⃣🔗👈👉🔼🎨👀🚀🎯💰🔑⚡☕💬🎂✨🧩🛍️🚩🐈🐾🐱🐕
🐒🎗☢️️️️👹🌙🇰🇷🌳🚲🔵🚙🔱

🎵   🎶   🔔   📢   🖍️

📌 유니코드 상자그리기 기호 wepplication.github.io/tools/charMap/#unicode-2500-257F
📌 이모지 https://wepplication.github.io/tools/charMap/#emoji
📌 특수문자 이모티콘 모음 https://wepplication.github.io/tools/charMap/#specialChar

✨
✨

### 오늘의 링크

1.  스마트폰 VS 멍청이폰(?) 미국 Z세대가 전화, 문자만 되는 휴대폰을 사용하는 이유 l라이트폰l 인디샵 MAGAZINE 구독자 3.43천명조회수 15만회  2개월 전 https://www.youtube.com/watch?v=r6y616ogdqU
1. 아무말 없는 교황 꾸짖은 터키 에르도안. 교황 팔레스타인 독립국이 답이다. 세상돌아보기Gust&Thunder 구독자 4.91만명 조회수 9.8천회  2일 전 https://www.youtube.com/watch?v=aYvopEMdx4I

### 세상 돌아보기

1. 맨눈으로 절대 못 보는 수소와 산소를 발견한 과학자들! 도대체 어떻게 발견했을까?  리뷰엉이: Owl's Review 구독자 151만명 조회수 612,208회  2022. 10. 15. https://www.youtube.com/watch?v=SoVV8KHpM3U
도서 '다정한 물리학'은 아래 링크로 구매할 수 있습니다.
교보문고 : https://bit.ly/3VoO5N8
예스24 : https://bit.ly/3CXjWgJ
알라딘 : https://bit.ly/3SZW6q1

| corner | gigabyte | corner | rasp4b | corner | orange2w |
|:---:|---|:---:|---|:---:|---|
| 13022 | 13:22 ssh | 5822 | 58:22 ssh | 5922 | 59:22 ssh |
|       |           | 15822 | 158:22 ssh-w | 15922 | 159:22 ssh-w |
|       |           | 5840 | 58:5800 wiki | 15980 | 159:8081 wdPress |
|       |           | 15840 | 158:5800 wiki | 15999 | 159:9900 wiki |

### 컴활은 즐거워

1. Run Linux on ESP32 - how to run the Linux kernel on an ESP32 Tam Hanna 구독자 2.39천명 조회수 3.2만회  9일 전 https://www.youtube.com/watch?v=5oKeVyxgwzk
1. 웹개발 이렇게 쉬웠나? 웹사이트 7분만에 개발하고 실전 배포하기 조코딩 JoCoding 구독자 55.2만명 조회수 35만회  1년 전  조코딩의 코딩 기초와 웹 프로그래밍 (2022) https://www.youtube.com/watch?v=4mRae9N2pU4
1. 코딩 교육 끝판왕 등장?! 코딩쌤과 코린이를 위한 교재 추천! / 아두이노로 만드는 20가지 프로젝트 키트/파이썬과 마이크로비트로 배우는 실전 코딩 프로젝트 키트(+이벤트안내) 나도메이커 구독자 1.3만명 조회수 17회  51분 전 https://www.youtube.com/watch?v=5Qr7ymcFa38
1. Build RESTful APIs Using Kotlin and Spring Boot [Video] By Dilip Sundarraj $49.99 Video https://subscription.packtpub.com/video/web-development/9781804616451/p10/video10_6/integration-test-for-the-get-endpoint-to-retrieve-all-the-courses
1. Jetpack 및 Kotlin을 사용하여 최신 Android 개발을 시작하세요. https://subscription.packtpub.com/book/mobile/9781801811071/pref
1. Jetpack Compose를 사용한 Android UI 개발 https://subscription.packtpub.com/book/business-and-other/9781801812160/1
git clone https://github.com/PacktPublishing/Android-UI-Development-with-Jetpack-Compose.git
1. LibreOffice Calc Guide 7.2 https://books.libreoffice.org/en/CG72/CG72.html
1. 2023년 가을 ChatGPT 업데이트로 대화 기능이 사용되면서 프롬프트 세팅으로 무한 영어회화 공부 가능하게 되었습니다. 어떤 프롬프트 사용하면 되는가! 안될공학 - IT 테크 신기술 구독자 17.5만명 조회수 17만회  2주 전 https://www.youtube.com/watch?v=4dDkUxR7dIE
1. 2023.10.18. 오후 7:04 (15시간 전) AI를 사용하여 가짜 리뷰와 사기를 감지합니다. Amazon, eBay, Walmart, Bestbuy 등에서 지원됩니다. 무료입니다 100만 명 이상의  쇼핑객이 Fakespot을 신뢰합니다 JR at Android Intelligence https://www.fakespot.com/

### 앱개발

1. (2023-01-01 522.p) PostgreSQL 15 마스터하기 - 제5판 https://subscription.packtpub.com/book/business-other/9781803248349/1
1. (2023-05 704p) Kotlin으로 Android 앱을 빌드하는 방법-제 2 판 How to Build Android Apps with Kotlin - Second Edition https://subscription.packtpub.com/book/mobile/9781837634934/pref
1. (2022-01 356p) Kotlin 디자인 패턴 및 모범 사례 - 제2판 https://subscription.packtpub.com/book/programming/9781801815727/2/ch02lvl1sec12/classes-and-inheritance
1. (2018-08 178.p) Kotlin Quick Start Guide By Marko Devcic $25.99 Publication ISBN 9781789344189 https://subscription.packtpub.com/book/programming/9781789344189/1
1. (2022-03 184.p) Kotlin 다중 플랫폼 모바일로 애플리케이션 개발 간소화 로베르트 나기 https://subscription.packtpub.com/book/programming/9781801812580/3
1. (2018-05 310.p) Spring 5 및 Kotlin으로 애플리케이션 구축
작업 환경 준비 https://subscription.packtpub.com/book/web-development/9781788394802/1/ch01lvl1sec05/preparing-the-working-environment
1. (2019-01 392.p) Android 애플리케이션 개발을 위한 Spring 배우기
(4) Android용 스프링 모듈 https://subscription.packtpub.com/book/programming/9781789349252/4
1. (2022-12 270.p) Spring Boot 3.0 학습 - 제3판 그렉 L. 턴키 스트 $35.99 ISBN 9781803233307 https://subscription.packtpub.com/book/web-development/9781803233307/2/ch02lvl1sec03/technical-requirements

### 땜쟁이의 힌트

1. I fixed a C64 using a $20 OSCILLOSCOPE Sayaka's Digital Attic 구독자 3.08천명 조회수 3.4만회 https://www.youtube.com/watch?v=7kkzIV5yTPQ
1. Testing out the Milk-V Duo - The new $9 RISC-V eSBC that runs Linux!  Platima Tinkers 구독자 2.19천명 조회수 31,009회  2023. 9. 2. https://www.youtube.com/watch?v=YqUtGk0DHbQ&t=1231s
1. brave 브라우저 설치후: 고정글꼴 lucida console, 검색엔진 google
1. 긴 스크롤 웹사이트 크롬에서 간단히 캡쳐하기! 달새 (이영민) Apr 17, 2019 https://birdmoon.medium.com/%EA%B8%B4-%EC%8A%A4%ED%81%AC%EB%A1%A4-%EC%9B%B9%EC%82%AC%EC%9D%B4%ED%8A%B8-%ED%81%AC%EB%A1%AC%EC%97%90%EC%84%9C-%EA%B0%84%EB%8B%A8%ED%9E%88-%EC%BA%A1%EC%B3%90%ED%95%98%EA%B8%B0-26867b95819e
chrome > `Ctrl+Shift+C` = 개발자도구 > `Ctrl+Shift+P` 우상단 확장메뉴 > Capture `full` size screenshot 클릭

1. 정리 정돈은 이 영상으로 마무리 하세요! (윤선현 정리컨설턴트 풀영상) 스터디언 구독자 183만명 https://www.youtube.com/watch?v=g4U20zISp4g
조회수 19,033회  2023. 10. 15.  #미니멀리스트 #정리수납 #정리
하루에 15분씩만 정리 했더니 집이 2배로 넓어졌다. (윤선현 정리컨설턴트)
윤선현 정리컨설턴트 [이대로는 안 되겠다 싶은 순간 정리를 시작했다]📘 👉 https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbEU5dUwwbm1ydThiLTNUczJLWm1KY2lxSjQ2QXxBQ3Jtc0trX3FHbW5saU5fLV9BSTVhWEZ5X29CVjJXaDBLZEZwZWRiQkY1cDZFWlMwVm5nT0F1NWtWZ0RLTDZFdjA1WG1BRWRxNThBV21lTUtXM3R0YTdIc2d6T2RHdlc0SGk3bHpXTmx6amNtOXZ3Z0c4Q0xXTQ&q=https%3A%2F%2Fproduct.kyobobook.co.kr%2Fdetail%2FS000001887770&v=g4U20zISp4g
유튜브 [바른정리학교] 👉 / @verygoodceo
네이버 카페 [매일, 조금씩, 꾸준히 정리력] 👉 https://cafe.naver.com/2010ceo
인스타그램 [@culman7] 👉 https://www.instagram.com/culman7/
오늘의 게스트: 윤선현 정리컨설턴트 (주)베리굿정리컨설팅 대표이사 📓오로다 PLAN · DO · SEE 다이어리(2024년) 구매 👉 https://bit.ly/3MIl8IB
📢문의: info@changeground.com
📢스터디언 출연 신청: https://forms.gle/a2YoNJyU2jpZ1YxSA
00:00 집이 2배로 넓어지는 하루 15분 정리 꿀팁 대방출
13:26 시간이 정말로 없는 걸까?? '시간도 정리다!' 시간 정리법 2가지

1. orangepi zero 2w 의 ubuntu locale 한글로 설정하기  2019-11-04 https://jinmay.github.io/2019/11/04/linux/linux-change-locale-to-korean/
```
sudo apt-get install language-pack-ko
sudo timedatectl set-timezone 'Asia/Seoul' ; date #-- ubuntu 에서 시각 지정
```
위 명령으로 설치후, 다음의 선언을 추가한다.
```
~ $ sudo cat /etc/default/locale
#  File generated by update-locale
# Ubuntu locale 한글로 설정하기  2019-11-04 https://jinmay.github.io/2019/11/04/linux/linux-change-locale-to-korean/
LANG=ko_KR.UTF-8
LC_MESSAGES=POSIX
LANGUAGE=ko_KR.UTF-8
```
3. orangepi zero 2w 의 ubuntu 에서 ~/.bashrc 에 추가하는 부분.
```
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#----> 부터 추가
# ..... user 3x:글자색 4x:바탕색 0회 1빨 2초 3노 4청 5보 6파 7흰
# 00 01 02 흐림 03 이탤릭 04 밑줄 05 깜빡거림 06 07 반전 08 09 글자에 줄긋기 10
PS1='\e[0;36m\t\e[0m\e[0;33m\D{%a}\e[0;35m\D{%y}\e[0;36m\D{%m}\e[0;31m\D{%d} \e[0;36m\u\e[0;33m@\e[0;34m\h\e[0m \e[04;32m\w\e[0m\n\W $ '
#........ 11:35:04 .......... 화 .......... 23 .......... 10 .......... 17 ........ yosj ..... @ . orangepizero2w .. 디렉토리전체 .. 줄바꾸고 최종디렉토리
export EDITOR=vi
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias more='more -e'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
#<---- 까지 추가
```
1. 브라우저에서, `google keep 사용법`
1. Ubuntu Docker Compose 설치 방법(22.04 기준) 2023-02-15 by 나루 https://osg.kr/archives/2108
1. Docker Compose와 함께 Wiki.js 설치  21 1 월 2023 https://www.heyvaldemar.com/install-wikijs-with-docker-compose/
1. Ubuntu 22.04 LT 에 Wiki.js 설치 https://docs.requarks.io/install/ubuntu
5. Docker Compose를 사용하여 Wiki.js 설치  2023년 1월 21일 https://www.heyvaldemar.com/install-wikijs-with-docker-compose/
1. WordPress 샘플 https://docs.docker.com/samples/wordpress/
1. docker-compose 로 만드는 WordPress https://github.com/docker/awesome-compose/tree/master/official-documentation-samples/wordpress/
1. [docker-compose] 로 wordpress 서비스 구현하기 woo0_hooo·2021년 4월 15일 https://velog.io/@woo0_hooo/docker-compose-docker-compose%EB%A1%9C-wordpress
1. 종묘는 어떻게 세계유산이 되었을까? 종묘는 조선 왕조의 제사를 모시는 곳이 아닙니다 건물 하나하나가 조선의 모든 정신을 담은 조선 자체입니다 스토리, 여행에 말을 걸다 성세정TV https://www.youtube.com/watch?v=XfGwBLBfaiw
1. KBS TV조선왕조실록 – 개국프로젝트 제1호 종묘 / KBS 19970325 방송 KBS역사저널 그날 구독자 81.2만명 조회수 5.5만회  1년 전 https://www.youtube.com/watch?v=M148kXHT2Jg
1. Orange Pi zero 2W 에서 인터넷 설정 http://proen.duckdns.org:15840/en/yosj/opizero2w_install
1. OctoPrint 설정 및 구성을위한 Orange Pi Zero 2 키트 https://www.obico.io/docs/user-guides/install-octoprint-orange-pi-zero-2-kit/
1. 리눅스 명령어 삼대장: find, grep, awk Jaeyeon Baek 2018. 2. 7. 08:15 https://jybaek.tistory.com/704
1. How to set a static IP address http://www.orangepi.org/orangepiwiki/index.php/How_to_set_a_static_IP_address

### 나불나불 공염불

1. 매일 이 주식을 사모으세요. 역대급 부자 될 기회를 절대 놓치지 마세요! (중국전문가 어반대 교수 안유화) 월급쟁이부자들TV 구독자 116만명 조회수 22만회  2주 전 https://www.youtube.com/watch?v=tdUKslC-HlM
1. 나이들어 재밌게 사는 사람들의 특징, 이거 10가지를 팍 줄이며 살고 있더라. 내 노후의 품격은 자식도 배우자도 아닌 바로 나 자신이 결정합니다. 유쾌한 킴교장 구독자 2.23만명 조회수 18만회  2주 전 https://www.youtube.com/watch?v=Ozqv6KGB2XQ
1. #퇴직후 꼭 필요한 취미생활 10가지(저렴하게 즐기는 취미생활)/퇴직자들이 직접 경험하고 추천한 취미활동. 유쾌한 킴교장 구독자 2.23만명 조회수 29만회 https://www.youtube.com/watch?v=JgvlyKwpQZo
1. 납치당한 사람 맞아?ㅋㅋㅋㅋ 똘망한 눈 동그랗게 뜨고 따박따박할 말 다 하는 윤세리에 말린 리정혁 아빠 | #백만뷰 #사랑의불시착 | CJ ENM 200118 방송 백만뷰 구독자 70.8만명 조회수 742만회  2년 전 https://www.youtube.com/watch?v=UjDJgdElO8g
1. 최근 일본 어른들 충격에 빠뜨린 일본 여학생 90%가 한글을 쓰는 이유는... 감동돋보기 구독자 1.4만명 조회수 33만회  13일 전 일본 한 가정의 저녁식사 시간 https://www.youtube.com/watch?v=96OO488wsZE
1. 노년에 시작해도 수명 20년 늘려주는 생활 습관 I 노화에 시달리지 않고 젊고 건강하게 나이 드는 법 I 책읽어주는여자 I 오디오북 인생의 향기 구독자 7.49만명 조회수 24만회  5일 전 https://www.youtube.com/watch?v=lFR2Ty3sU8c
1. 저도 지난달에 연금저축펀드 라는 놈을 알았습니다. 유튜브에 치면 수두룩빽빽하게 정보가 나오는 데요,, 공부한번 해보세요..
https://youtu.be/ScxCsOWrnmk?si=eF8WlEkq3GXmWz0g
https://youtu.be/olsB3ZcUkD4?si=fY1D6NIKnhGiCpHE
돈 넣고 세액공제라도 받으시기를~~~
1. 46세 저는 머하고 사나 싶네요. [72]16:39:45프리캐스트 https://www.ddanzi.com/index.php?mid=free&statusList=HOT%2CHOTBEST%2CHOTAC%2CHOTBESTAC&document_srl=785153265

### 광고사절

1. 웹소설 > 작가연재 > 현대판타지, 드라마 독점 "이번 생에는 음악의 전설이 되었다" 글 에어콘1https://novel.munpia.com/381966/page/1/neSrl/5690057

### 난중일기

1. 231023-211024검죄자암살단모집-일본산 방사능 재료 사용여부 확인법-0 https://www.ddanzi.com/free/785758255
1. 김경록PB의 첫 유튜브 영상 kyungrok kim 구독자 107명 조회수 236회  45분 전 https://www.youtube.com/watch?v=32nMYFoosEQ
1. [LIVE] 최강욱의 인간시대.. 조국 편 (ft. 조국, 박시영) 박시영TV 구독자 46.8만명 조회수 30,696회  이전 실시간 스트리밍: 2시간 전 후원계좌 안내 : 기업은행 221-456011-04-028 주식회사박시영 https://www.youtube.com/watch?v=0cIfUy1nhMc

### 오늘의 건강

1. 돈한푼 안 들이고, 녹아내리는 잇몸병 없애는 가장 확실한 방법 (박창진 원장 2부) 지식인사이드 구독자 115만명 조회수 89만회  1개월 전 https://www.youtube.com/watch?v=LVTxnrFPrNM
👇지식인사이드 네이버 카페 가입하기 https://cafe.naver.com/knowledgeins
1. 이 영상 보면 평생 치과 안 갑니다 치석 쌓일 틈 없는 신기한 칫솔 교육하는 의사! 이동환TV 구독자 88.2만명 조회수 29만회  2주 전 https://www.youtube.com/watch?v=8k9uWfN--IE
1. 치아에 구멍 생기기 싫다면 이 '3가지' 음식은 당장 끊으세요. (박창진 원장 1부) 지식인사이드 구독자 114만명 조회수 3.2만회  1일 전 https://www.youtube.com/watch?v=G4YIdQkLcLo
1. “젊게 살고 싶다면 ‘이 습관’ 반드시 바꾸세요” 정희원 교수 (서울아산병원 노년내과 전문의) 빅퀘스천 1부 | 노년의 건강, 어떻게 지킬 것인가? SBS Biz 날리지 knowledge 구독자 25.2만명 조회수 126만회  2개월 전 https://www.youtube.com/watch?v=utQZNZdSxCk&t=25s

## FOSS Weekly #23.42: Ubuntu 23.10 릴리스, 설명 자막 등
작성자: Abhishek Prakash • 2023년 10월 19일

1. 자막 없이는 실시간 시청이 불가능한가요? 자막 경험을 최고로 끌어올리기 위한 몇 가지 팁과 도구는 다음과 같습니다.
- [ 자막을 VLC와 빠르게 동기화 ](https://itsfoss.com/r/289d2dc7?m=b228f09d-f18a-42df-b499-4d9519985eda)
- [VLC에는 더 많은 자막 트릭이 있습니다.](https://itsfoss.com/r/e717a099?m=b228f09d-f18a-42df-b499-4d9519985eda)
- 깔끔한 트릭으로 [TV에서 자막과 함께 로컬 미디어 재생이](https://itsfoss.com/r/d763a55d?m=b228f09d-f18a-42df-b499-4d9519985eda) 가능합니다

제가 가장 좋아하는 자막 도구 두 가지는 다음과 같습니다.
- [SubSync](https://itsfoss.com/r/13cff648?m=b228f09d-f18a-42df-b499-4d9519985eda) : 품질이 좋지 않은 자막을 자동으로 동기화합니다.
- [펭귄 자막 플레이어](https://itsfoss.com/r/b5280384?m=b228f09d-f18a-42df-b499-4d9519985eda) : 모든 비디오 또는 온라인 플레이어에 자막을 추가할 수 있습니다.

Fig 4.2a: Screenshot showing “Library” and “Add New” option of “Media”
Fig 4.2b: Screenshot showing already uploaded images in the “Library” option
Fig 4.4: How to delete any page from a website
Fig 6.2.5: Arrow points at Add Items
Fig 6.2.8: The new look showing the newly created menu item “Our Books”
Fig 7.7: Arrow points at the Header
Fig 7.1.6: www.teachkindle.com before changing of its title and description
Fig 7.2.1: Arrow points at the Publish tab in Site Identity section
Fig 8.6: The position of the done button shown
Fig 8.8: Selecting Header as the area I want to have my Gallery
Fig 8.1.7: Arrow points at Add images button
Fig 10.2.1: Selecting the image symbol
