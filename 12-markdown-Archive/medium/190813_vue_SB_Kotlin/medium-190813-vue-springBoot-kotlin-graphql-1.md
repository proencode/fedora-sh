2019년 8월 13일s

## Vue.js, Spring Boot, Kotlin 및 GraphQL: 최신 앱 구축 — 1부
https://medium.com/@auth0/vue-js-spring-boot-kotlin-and-graphql-building-modern-apps-part-1-5e77cc710a58

### (1) 전제 조건

1. JDK 8 이상 x64 RPM Package 161.40 MB https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.rpm
2. Node.js 및 NPM. Node.js https://nodejs.org/en/download/ Linux Binaries (x64)
3.  Vue CLI https://cli.vuejs.org/guide/installation.html
```
npm install -g @vue/cli
# OR
yarn global add @vue/cli

vue --version
```

### (2) 최신 웹 앱 아키텍처

백엔드 API와 통신하는 SPA (단일 페이지 애플리케이션)

### (3) 무엇을 만들 것인가

1. 사용자가 감독과 함께 좋아하는 영화를 보고 평가할 수 있는 응용 프로그램인 "Movie Review Board" 앱을 구축.
2. Vue.js, Vuex, Vue 라우터, Vue의 이벤트 버스를 사용하여 SPA를 구축.
3. Spring Boot, Kotlin 및 GraphQL을 사용하여 백엔드 API를 구축.

### (4) 스프링 부트 애플리케이션 부트스트랩

1. Spring Initializr 로 이동하여 필요한 도구와 라이브러리를 선택.

- Project: Gradle Project
- Language: Kotlin
- Spring Boot: 2.1.5
- Group: com.example
- Artifact: MovieReviewBoard

![ Spring Initializr ]( /medium/190813_vue_SB_Kotlin/4101 Spring Initializr.webp
)

2. “Dependencies” 종속성 섹션에서 , `Web`, `H2`, `JPA 라이브러리` 를 설치.

![ Dependencies ]( /medium/190813_vue_SB_Kotlin/4102 Dependencies.webp
)

3. [`프로젝트 생성`] 클릭 > .zip 파일 다운로드 됨.
4. .zip 파일 압축을 풀고, 그 폴더 안에 backend/ 폴더를 만든다.
5. MovieReviewBoard 폴더에 들어있는 모든 내용을 backend/ 폴더로 옮겨넣는다.

- 참고:
기본적으로 Spring Boot의 서블릿 컨테이너는 포트 8080에서 수신 대기하므로, Webpack 의 포트와 중복되기 때문에,
/MovieReviewBoard/backend/src/main/resources/application.properties 파일에 server.port=8888 을 추가해야 한다.
이러면, 이제 Spring Boot는 8080 대신 포트 8888에서 수신 대기하게 된다.

6. com.example.MovieReviewBoard 패키지에 HelloWorldController.kt 를 만들어서, helloworld 엔드포인트를 만든다.

```
import org.springframework.boot.web.servlet.FilterRegistrationBean
import org.springframework.context.annotation.Bean
import org.springframework.core.Ordered
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.UrlBasedCorsConfigurationSource
import org.springframework.web.filter.CorsFilter
import java.util.*
import javax.servlet.Filter

@RestController
class HelloWorldController {

	@GetMapping("/helloworld")
	fun greet(): String {
		return "helloworld!"
	}

	@Bean fun simpleCorsFilter():
	FilterRegistrationBean<*> {
		val source = UrlBasedCorsConfigurationSource()
		val config = CorsConfiguration()
		config.allowCredentials = true // *** URL below needs to match the Vue client URL and port ***
		config.allowedOrigins = Collections.singletonList("http://localhost:8080")
		config.allowedMethods = Collections.singletonList("*")
		config.allowedHeaders = Collections.singletonList("*")
		source.registerCorsConfiguration("/**", config)
		val bean = FilterRegistrationBean<Filter>(CorsFilter(source))
		bean.setOrder(Ordered.HIGHEST_PRECEDENCE)
		return bean
	}
}
```
참고: 이 simpleCorsFilter()메서드는 백엔드 API에 교차 출처 지원을 추가합니다. 이 메서드는 Access-Control-Allow-Origin서버에서 보낸 HTTP 응답의 헤더를 설정합니다. 이 헤더의 값을 설정하면 http://localhost:8080이 도메인이 서버에 요청해도 괜찮다는 신호를 브라우저에 알릴 수 있습니다. ./gradlew bootRun그런 다음 명령줄 을 MovieReviewBoard/backend/통해 실행하거나 IDE에서 실행하여 백엔드 서버를 실행 합니다. 이제 브라우저에서 http://localhost:8888/helloworld 를 방문하면 다음 페이지가 표시되어야 합니다.

![ helloworld ]( /medium/190813_vue_SB_Kotlin/4103 helloworld.webp
)

### (5) Vue.js 앱 부트스트랩

백엔드의 빌딩 블록이 있으므로 Vue CLI를 사용하여 프론트엔드 애플리케이션을 스캐폴딩해야 합니다. 위의 전제 조건 섹션의 지침에 따라 Vue CLI가 설치되어 있는지 확인하십시오. 앱을 스캐폴딩하려면 터미널을 열고 MovieReviewBoard 디렉터리로 이동하여 다음 명령을 실행합니다.

```
vue create frontend
```

이렇게 하면 다음과 같이 대답해야 하는 설정 질문이 포함된 대화 상자가 터미널에 생성됩니다.

![ Vue CLI ]( /medium/190813_vue_SB_Kotlin/4104 Vue CLI.webp
)

