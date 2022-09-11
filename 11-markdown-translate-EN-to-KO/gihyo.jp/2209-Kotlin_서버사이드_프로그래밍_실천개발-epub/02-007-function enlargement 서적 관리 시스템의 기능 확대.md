

0C```^[^Mk0 ------- @ Q
0i```^M-^[^M0i```^[0 ------- @ W
0^Mi```^M^M^[kk ------- @ E
0i#### ^[$a^M^[ ------- @ A
0i##### ^[$a^M^[ ------- @ S


40,$s/Kotlinサーバーサイドプログラミング実践/Kotlin서버사이드프로그래밍실천/g
40,$s/他のユーザーが貸出中の商品です/다른 유저가 대출중입니다./g
40,$s/該当するユーザーが存在しません/해당 유저가 없습니다./g
40,$s/該当する書籍が存在しません/해당서적이 없습니다./g
40,$s/ロギングに関する設定/로깅에 대한 설정/g
40,$s/本処理の結果の返却/본처리 결과의 반환/g
40,$s/既に存在する書籍ID/이미 존재하는 책 id/g
40,$s/貸出中の商品です/대출중인 상품입니다./g
40,$s/存在しない書籍ID/존재하지 않는 책 id/g
40,$s/貸出中のチェック/대출중 체크/g
40,$s/未貸出の商品です/대출하지 않은 상품입니다./g
40,$s/本処理の実行/본처리의 실행/g
40,$s/コトリン太郎/코틀리니/g
40,$s/ジャヴァ太郎/자바니/g
40,$s/出力は省略/출력은 생략함/g
40,$s/Kotlin入門/Kotlin입문/g
40,$s/貸出期間/대출기간/g
40,$s/竹端尚人/저자명/g
40,$s/Java入門/Java입문/g
40,$s/ユーザー/유저/g
40,$s/前処理/전처리/g
40,$s/後処理/후처리/g
40,$s/管理者/관리자/g
40,$s/追加/추가/g
40,$s/省略/생략/g
40,$s/注/주/g




# 제7장　서적 관리 시스템의 기능 확대

제7장에서는, 제6장에서 작성한 어플리케이션의 나머지의 기능(대출, 반환)을 주로 구현해 갑니다. 거기에 당해 유저 정보를 취급하도록(듯이) 할 필요가 있기 (위해)때문에, Spring Security를 사용한 인증, 인가의 기구의 구현 방법을 해설합니다. 또, 추가의 요소로서 Spring AOP에 의한 로깅의 구현도 해 나갈 것입니다. Spring Framework에는 다양한 모듈이 준비되어 있어 이러한 많은 제품에 공통으로 필요한 기능도 비교적 간단하게 구현할 수 있습니다. 이 장에서는 이러한 기능을 구현하여보다 실용적인 응용 프로그램에 접근할 것입니다.

### 1　Spring Security에서 사용자 인증, 권한 부여 메커니즘 구현

여기까지 서적에 대한 각종 조작의 API를 구현해 왔습니다만, 다음은 사용자 인증, 인가의 기구를 구현해 갑니다. 구현에는 Spring Security를 사용합니다. Spring Security는 Spring 프로젝트 중 하나로 웹 애플리케이션에서 인증, 권한 부여 등 보안 관련 기능을 실현하기 위한 프레임워크입니다.

제6장에서 작성한 어플리케이션에 로그인의 구조를 구현해, 전술한 바와 같이 검색계 기능, 갱신계 기능으로 액세스 권한을 나눕니다.

#### build.gradle.kts에 종속성 추가

먼저 Spring Security를 사용하기 위해 build.gradle.kts에 종속성을 추가합니다. dependencies 에 Listing 7.1.1 을 추가한다.

Listing 7.1.1
```
implementation("org.springframework.boot:spring-boot-starter-security")
```

spring-boot-starter-security 는 Spring Security를 사용하기 위한 starter입니다. MyBatis의 starter와 마찬가지로, 이 기술로 Spring Security와 함께 필요한 종속성을 모두 추가해 줍니다.

#### Spring Security 기본 설정

SecurityConfig(이름은 임의)라는 클래스를 Listing 7.1.2 의 내용으로 생성한다. 또, 이 중에서 참조하고 있는 이하의 클래스는, 후술하는 설명 중에서 작성해 가기 때문에, 이 클래스만을 작성한 시점에서는 참조할 수 없게 컴파일 에러가 됩니다. 모든 필요한 클래스를 작성한 후에 동작 확인이 되기 때문에, 일단 에러는 그대로의 상태로 읽어 진행해 주세요.

- 인증 서비스
- BookManagerUserDetails서비스
- BookManagerAuthenticationSuccessHandler
- BookManagerAuthenticationFailureHandler
- BookManagerAuthenticationEntryPoint
- BookManagerAccessDeniedHandler

Listing 7.1.2.jpeg

여기 Spring Security에 필요한 다양한 설정을 설명합니다. WebSecurityConfigurerAdapter 클래스를 상속하고 @EnableWebSecurity 주석을 부여해야 합니다.

##### 인증, 권한 부여 설정

처음에는 맨 위 HttpSecurity 를 인수로 사용하는 configure 함수에서 설명합니다. 여기에서는 주로 인증, 허가에 관한 설정을 하고 있습니다.

우선, Listing 7.1.3 부분에서 권한 설정(액세스 권한 설정)을 하고 있다.

Listing 7.1.3 (Listing 7.1.2의 ①  을 발췌)
```
http.authorizeRequests()
    .mvcMatchers("/login").permitAll()
    .mvcMatchers("/admin/**").hasAuthority(RoleType.ADMIN.toString())
    .anyRequest().authenticated()
```

mvcMatchers 에서 대상 API의 경로를 지정하고 뒤에 체인하는 함수에서 권한을 설정합니다. 여기에서는 다음의 설정을 하고 있습니다.

- /login에서 로그인 API(아래 참조)에 permitAll을 지정하고 인증되지 않은 사용자를 포함한 모든 액세스 허용
- /admin에서 시작하는 API(이번에 말하면 업데이트 시스템의 API)에 대해 hasAuthority를 사용하여 관리자 권한의 사용자만 액세스를 허용
- anyRequest().authenticated()에서 위 이외의 API는 인증된 사용자(모든 권한)만 액세스를 허용

다음 은 Listing 7.1.4 에서 인증을 설정한다.

Listing 7.1.4 (Listing 7.1.2의 ②  를 발췌)
```
.formLogin()
.loginProcessingUrl("/login")
.usernameParameter("email")
.passwordParameter("pass")
```

여기에서는 다음의 설정을 하고 있습니다.

- formLogin에서 양식 로그인(사용자 이름, 비밀번호로 로그인) 사용
- loginProcessingUrl에서 로그인 API 경로를 /login으로 설정
- usernameParameter로 로그인 API에 전달하는 사용자 이름의 매개 변수 이름을 email로 설정
- passwordParameter에서 로그인 API에 전달하는 비밀번호 매개 변수 이름을 pass로 설정

Spring Security는 로그인 처리를 수행하는 API를 제공하며, 그 곳을 사용하여 인증 메커니즘을 구현할 수 있습니다. 인증 방식으로서 OAuth2나 LDAP등 몇가지 준비되어 있습니다만, 본서에서는 단순한 폼 인증을 설정하고 있습니다. 이렇게하면 양식 인증에서 로그인 API를 사용할 수 있습니다. 그리고 로그인 API는 사용자 이름과 비밀번호를 매개 변수로 받기 때문에 매개 변수 이름을 임의로 지정할 수 있습니다.

##### 인증, 인가시 각종 핸들러 설정

인증, 인가 아래에 있는 것이 리스트 7.1.5 의 부분으로, 인증, 인가시의 각종 핸들러를 설정하고 있습니다.

Listing 7.1.5 (Listing 7.1.2의 ③을 발췌)
```
.successHandler(BookManagerAuthenticationSuccessHandler())
.failureHandler(BookManagerAuthenticationFailureHandler())
.and()
.exceptionHandling()
.authenticationEntryPoint(BookManagerAuthenticationEntryPoint())
.accessDeniedHandler(BookManagerAccessDeniedHandler())
```

각각 다음의 설정이 됩니다.

- successHandler로 인증 성공시 실행할 핸들러 설정
- failureHandler로 인증 실패시 실행할 핸들러 설정
- authenticationEntryPoint에서 인증되지 않은 핸들러 설정
- accessDeniedHandler에서 권한 실패시 핸들러 설정

이것들로 설정하고 있는 각종 핸들러는, Spring Security의 인터페이스를 사용해 스스로 구현합니다. 이에 대해서는 후술합니다.

##### CORS 관련 설정

마지막으로 Listing 7.1.6 부분에서 CORS (Cross-Origin Resource Sharing) 설정을하고있다.

Listing 7.1.6 (Listing 7.1.2의 ④ 발췌)
```
.and()
.cors()
.configurationSource(corsConfigurationSource())
```

cors 함수에 체인하여 configurationSource 를 호출 설정합니다. 설정하는 처리는 Listing 7.1.7 의 private 함수로 잘라낸다.

Listing 7.1.7 (Listing 7.1.2의 ⑤ 발췌)
```
private fun corsConfigurationSource(): CorsConfigurationSource {
    val corsConfiguration = CorsConfiguration()
    corsConfiguration.addAllowedMethod(CorsConfiguration.ALL)
    corsConfiguration.addAllowedHeader(CorsConfiguration.ALL)
    corsConfiguration.addAllowedOrigin("http://localhost:8081")
    corsConfiguration.allowCredentials = true

    val corsConfigurationSource = UrlBasedCorsConfigurationSource()
    corsConfigurationSource.registerCorsConfiguration("/**", corsConfiguration)

    return corsConfigurationSource
}
```

CorsConfiguration 이라는 클래스에서 CORS에 관한 각종의 허가 설정을 합니다. 여기에서는 addAllowedMethod , addAllowedHeader 로 메소드와 헤더를 모두 허가, addAllowedOrigin 로 액세스원의 도메인을 허가하고 있습니다. 여기에서는 프런트 엔드의 샘플 코드로 사용하고 있는 localhost:8081 을 허가하고 있습니다만, 각자의 환경에 따라서 변경이 필요합니다. 또, 여기에서는 샘플을 위해서 코드에 직접 도메인을 기술하고 있습니다만, 실천으로 사용할 때에는 환경(프로덕션 환경, 개발 환경등)마다의 설정 파일에 잘라내는 등 하는 것이 좋을 것입니다.

##### 인증 처리 관련 설정

Listing 7.1.8 의 AuthenticationManagerBuilder 를 인수로 취하는 configure 함수로 설정에서 인증 처리에 관한 설정을하고 있다.

Listing 7.1.8 (Listing 7.1.2의 ⑥  발췌)
```
override fun configure(auth: AuthenticationManagerBuilder) {
    auth.userDetailsService(BookManagerUserDetailsService(authenticationService))
        .passwordEncoder(BCryptPasswordEncoder())
}
```

- userDetailsService 클래스에서 인증 처리를 실행하는 클래스 지정
- passwordEncoder에서 암호 암호화 알고리즘을 BCrypt로 지정

userDetailsService 클래스에서 지정하는 것은 로그인 API에서 호출되는 인증 처리를 구현한 클래스입니다. 핸들러와 마찬가지로 Spring Security 인터페이스를 사용하여 직접 구현합니다. 이쪽에 대해서도 본 장에서 후술합니다.

또, passwordEncoder 에 사용하고 싶은 알고리즘의 인코더의 클래스를 지정하는 것으로, 패스워드를 암호화해 취급할 수 있습니다. 자세한 내용은 인증 처리 구현 섹션에서 설명합니다.

#### 인증 처리 구현

다음으로, 인증 처리를 구현해 갑니다. Spring Security의 메커니즘을 사용하면 최소한의 구현으로 실현할 수 있습니다.

##### 이메일 주소에서 사용자 정보를 검색하는 프로세스 구현

인증 프로세스에서 매개변수로 받은 사용자 이름을 사용하여 사용자 정보를 검색해야 합니다. 이 응용 프로그램은 이메일 주소를 사용자 이름으로 사용하므로 이메일 주소에서 사용자 정보를 검색하는 프로세스를 제공합니다.

먼저, 사용자를 나타내는 도메인 객체인 Listing 7.1.9 의 User 클래스를 생성한다.

Listing 7.1.9
```
data class User(
    val id: Long,
    val email: String,
    val password: String,
    val name: String,
    val roleType: RoleType
)
```

그런 다음 Listing 7.1.10 의 UserRepository 인터페이스를 작성한다.

Listing 7.1.10
```
interface UserRepository {
    fun find(email: String): User?
}
```

구현 클래스로 Listing 7.1.11 의 UserRepositoryImpl 클래스를 생성한다. 제6장의 「4. 검색계 기능(일람 취득, 상세 취득)의 API 구현」에서도 몇 가지 있었습니다만, IDE상의 보완으로 잘 할 수 없는 것이 있기 때문에, 여기에서도 import문을 포함해 기재하고 있습니다 .

Listing 7.1.11
```
import com.book.manager.domain.model.User
import com.book.manager.domain.repository.UserRepository
import com.book.manager.infrastructure.database.mapper.UserDynamicSqlSupport
import com.book.manager.infrastructure.database.mapper.UserMapper
import com.book.manager.infrastructure.database.mapper.selectOne
import com.book.manager.infrastructure.database.record.UserRecord
import org.mybatis.dynamic.sql.SqlBuilder.isEqualTo
import org.springframework.stereotype.Repository

@Suppress("SpringJavaInjectionPointsAutowiringInspection")
@Repository
class UserRepositoryImpl(
    private val mapper: UserMapper
) : UserRepository {
    override fun find(email: String): User? {
        val record = mapper.selectOne {
            where(UserDynamicSqlSupport.User.email, isEqualTo(email))
        }
        return record?.let { toModel(it) }
    }

    private fun toModel(record: UserRecord): User {
        return User(
            record.id!!,
            record.email!!,
            record.password!!,
            record.name!!,
            record.roleType!!
        )
    }
}
```

메일 주소를 인수로 받아, where 로 지정해 일치하는 데이터를 취득해, User 클래스에 변환해 반환하고 있습니다.

그리고 이 find 함수를 호출하는 AuthenticationService 클래스를 만듭니다 ( Listing 7.1.12 ).

Listing 7.1.12
```
@Service
class AuthenticationService(private val userRepository: UserRepository) {
    fun findUser(email: String): User? {
        return userRepository.find(email)
    }
}
```

이 함수는 후술하는 인증 처리에 사용합니다.

##### Spring Security 인증 처리와 관련된 인터페이스 구현

그리고 인증 처리의 구현입니다. Listing 7.1.13 의 BookManagerUserDetailsService 클래스를 구현한다.

Listing 7.1.13
```
class BookManagerUserDetailsService(
    private val authenticationService: AuthenticationService
) : UserDetailsService {
    override fun loadUserByUsername(username: String): UserDetails? {
        val user = authenticationService.findUser(username)
        return user?.let { BookManagerUserDetails(user) }
    }
}

data class BookManagerUserDetails(val id: Long, val email: String, val pass: String, RoleType) :
    UserDetails {

    constructor(user: User) : this(user.id, user.email, user.password, user.roleType)

    override fun getAuthorities(): MutableCollection<out GrantedAuthority> {
        return AuthorityUtils.createAuthorityList(this.roleType.toString())
    }

    override fun isEnabled(): Boolean {
        return true
    }

    override fun getUsername(): String {
        return this.email
    }

    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    override fun getPassword(): String {
        return this.pass
    }

    override fun isAccountNonExpired(): Boolean {
        return true
    }

    override fun isAccountNonLocked(): Boolean {
        return true
    }
}
```

같은 파일내에, UserDetails 인터페이스를 구현한, BookManagerUserDetails 클래스 (이름은 임의)를 데이터 클래스로서 작성합니다. 이것은 로그인시에 입력한 값으로부터 취득한 유저 데이터를 포함해, 인증 처리로 사용되는 것이 됩니다. 또, 인증 후에는 로그인중의 유저 정보로서 세션에 보관 유지되는 것이 됩니다.

몇 가지 함수를 재정의하고 있지만, 이번 포인트가되는 것은 다음과 같습니다.

- getPassword -- 패스워드 취득. 로그인 시 입력한 비밀번호와 비교하는 데 사용
- getAuthorities -- 권한의 취득(복수의 권한을 보관 유지하는 것도 가능). 권한이 필요한 경로의 경우이 함수에서 얻은 권한 정보로 확인됩니다.

그리고 이 UserDetails 형의 오브젝트를 취득하는 함수가 loadUserByUsername 이 됩니다. UserDetailsService 인터페이스를 구현한 클래스로 재정의합니다. 사용자 이름을 인수로 받고 방금 만든 AuthenticationService 클래스의 처리를 호출하여 사용자 정보를 검색하고 결과를 사용하여 BookManagerUserDetails 의 개체를 생성하고 반환합니다.

이 loadUserByUsername 으로 취득한 UserDetails 형의 오브젝트를 사용해, 패스워드의 비교나 허가 처리를 프레임워크측에서 실현해 줍니다. 그리고 그 때에 전술한 패스워드의 암호화 처리도 사용됩니다.

흐름을 간단하게 정리하면 다음과 같이 됩니다(프레임워크측에서 그 밖에도 처리를 하고 있습니다만, 주된 포인트만 짜서 정리하고 있습니다).

①  입력한 유저명, 패스워드를 파라미터로 로그인 API를 실행
②  loadUserByUsername으로 사용자명에 해당하는 사용자 정보의 UserDetails형의 오브젝트를 취득
③  ②  에서 취득한 UserDetails의 getPassword로 취득한 값과 입력된 패스워드를 BCrypt로 해시화한 값과 비교
④  허가가 필요한 경우 ②에서 취득한 UserDetails의 getAuthorities에서 취득한 권한의 List에 필요한 것이 포함되어 있는지 확인
이와 같이 유저 정보의 취득 처리등을 정의해 두면, 실제의 인증을 실시하는 부분의 처리는 Spring Security가 실현해 줍니다. 여기에서는 단순히 이메일 주소를 사용하여 user 테이블에서 정보를 얻는 형태로 구현하고 있습니다만, 어플리케이션의 설계에 따라 임의의 처리를 쓸 수 있습니다.

#### 다양한 핸들러 구현

전술한 SecurityConfig 클래스로 인증, 인가시의 각종 핸들러의 설정을 했습니다만, 다음은 그 핸들러의 구현을 해 갑니다.

핸들러는 설정하지 않은 경우에도 Spring Security에서 기본 처리를 정의합니다. 예를 들어 인증에 실패하면 로그인 페이지의 URL로 리디렉션됩니다. 하지만 이번 애플리케이션처럼 REST API로 구현하는 경우 리디렉션해도 API가 접히는 것만으로 화면을 전환할 수 없기 때문에 이 핸들링은 프런트 엔드에서 수행하고 싶습니다.

따라서 다양한 핸들러를 구현하고 리디렉션하는 대신 상황에 맞는 HTTP 상태를 응답으로 반환하는 처리로 다시 씁니다.

##### 인증 성공 시 핸들러

우선 인증 성공시의 핸들러입니다. 로그인 API로 인증 성공했을 때에 실행되는 처리가 됩니다. Listing 7.1.14 와 같이 AuthenticationSuccessHandler 인터페이스를 구현한 임의의 이름 (여기서는 BookManagerAuthenticationSuccessHandler )의 클래스를 작성한다.

Listing 7.1.14
```
class BookManagerAuthenticationSuccessHandler : AuthenticationSuccessHandler {
    override fun onAuthenticationSuccess(
        request: HttpServletRequest,
        response: HttpServletResponse,
        authentication: Authentication
    ) {
        response.status = HttpServletResponse.SC_OK
    }
}
```

오버라이드(override) 된 onAuthenticationSuccess 함수에 로그인 API 로 인증 성공했을 경우의 처리를 기술합니다. HttpServletResponse 형식의 인수의 status 속성에서 반환 시 HTTP 상태를 설정할 수 있습니다. 그러면 성공 HTTP 상태(200)가 헤더에 설정된 응답이 반환됩니다. Kotlin에서 호출하기 때문에 속성으로 설정하는 것처럼 쓰지만 HttpServletResponse 는 Java 클래스이며 실제로 setStatus 라는 메서드를 호출하는 것과 같습니다.

여기에서는 HTTP 상태의 설정만 하고 있습니다만, 그 밖에도 인수로 받고 있는 정보를 사용해 인증 성공시에 필요한 처리를 기술할 수가 있습니다.

Spring Security의 핸들러는, 이와 같이 프레임워크측에서 준비된 인터페이스를 구현해, 함수를 오버라이드(override) 하는 것으로 처리를 정의하는 것이 기본이 됩니다. 후술하는 핸들러도 같은 형태로 실장해 갑니다.

##### 인증 실패 시 핸들러

다음은 인증 실패시의 핸들러입니다. 로그인 API로 인증 실패했을 때 실행되는 처리가 됩니다. Listing 7.1.15 와 같이 AuthenticationFailureHandler 인터페이스를 구현한 클래스를 생성한다.

Listing 7.1.15
```
class BookManagerAuthenticationFailureHandler : AuthenticationFailureHandler {
    override fun onAuthenticationFailure(
        request: HttpServletRequest,
        response: HttpServletResponse,
        exception: AuthenticationException
    ) {
        response.status = HttpServletResponse.SC_UNAUTHORIZED
    }
}
```

onAuthenticationFailure 함수를 재정의하여 인증에 실패한 경우의 처리를 설명합니다. 여기도 인증 성공시와 마찬가지로 HTTP 상태만 설정합니다.

인증 실패로 인해 UNAUTHORIZED(401)를 설정했습니다.

##### 인증되지 않은 핸들러

다음은 인증되지 않은 핸들러입니다. 인증되지 않은 상태의 사용자가 인증이 필요한 API에 액세스할 때 수행되는 처리입니다. Listing 7.1.16 과 같이 AuthenticationEntryPoint 인터페이스를 구현한 클래스를 생성한다.

Listing 7.1.16
```
class BookManagerAuthenticationEntryPoint : AuthenticationEntryPoint {
    override fun commence(
        request: HttpServletRequest,
        response: HttpServletResponse,
        authException: AuthenticationException
    ) {
        response.status = HttpServletResponse.SC_UNAUTHORIZED
    }
}
```

commence 함수를 재정의하여 인증되지 않은 경우의 처리를 설명합니다. UNAUTHORIZED(401)의 HTTP 상태를 설정합니다.

##### 권한 실패시 핸들러

마지막으로 허가 실패시의 핸들러입니다. 필요한 액세스 권한이 없는 사용자가 API에 액세스할 때 수행되는 작업입니다. Listing 7.1.17 과 같이 AccessDeniedHandler 인터페이스를 구현한 클래스를 생성한다. import문을 기재하고 있습니다만, 이것은 AccessDeniedException 이라는 이름의 클래스가 Kotlin의 표준 라이브러리에도 존재하고 있어 import하지 않으면 그쪽이 사용되어 버려 컴파일 에러가 되기 때문입니다.

Listing 7.1.17
```
import org.springframework.security.access.AccessDeniedException
// 생략

class BookManagerAccessDeniedHandler : AccessDeniedHandler {
    override fun handle(
        request: HttpServletRequest,
        response: HttpServletResponse,
        accessDeniedException: AccessDeniedException
    ) {
        response.status = HttpServletResponse.SC_FORBIDDEN
    }
}
```

handle 함수를 오버라이드(override) 해, 허가 실패했을 경우의 처리를 기술합니다. 여기는 권한 오류로 인해 FORBIDDEN(403)의 HTTP 상태를 설정합니다.

#### 인증, 허가 동작 확인

여기까지 Spring Security에 의한 인증, 허가의 처리를 한번에 구현할 수 있었으므로, 동작 확인을 합니다. Listing 7.1.2 에서 만든 SecurityConfig 클래스로 구현한 각 클래스를 가져와서 진행한다.

##### 로그인하여 API 실행

응용 프로그램을 시작하고 먼저 7.1.18 명령 의 curl 명령을 실행하여 도서 목록 검색 API에 액세스합니다.

명령 7.1.18
```
$ curl -i http://localhost:8080/book/list
```

-i 는 헤더 정보를 응답에 포함하는 옵션입니다. 그러면 Listing 7.1.19 와 같은 결과가 표시됩니다.

Listing 7.1.19
```
HTTP/1.1 401
Vary: Origin
Vary: Access-Control-Request-Method
Vary: Access-Control-Request-Headers
（생략）
```

인증되지 않은 상태로 액세스했기 때문에 인증 오류(401)가 반환되었습니다.

다음으로 로그인합니다. 명령 7.1.20 의 명령을 실행합니다.

명령 7.1.20
```
$ curl -i -c cookie.txt -H 'Content-Type:application/x-www-form-urlencoded' -X POST -d 'email=user@test.com' -d 'pass=user' http://localhost:8080/login
HTTP/1.1 200
（생략）
```

테스트 데이터로 등록한 "사용자"의 사용자 정보 (id가 2 인 데이터)를 매개 변수로 전달하고 로그인 API를 실행합니다. 이 장의 "Spring Security 기본 설정"에서도 나왔지만 /login 은 Listing 7.1.2 의 configure 함수에서 loginProcessingUrl 로 설정한 경로로 Spring Security에서 기본적으로 제공되는 로그인 API를 실행한다. 수 있습니다. 이것에 SecurityConfig 클래스로 설정하고 있던 email , pass 라는 이름으로 유저명과 패스워드를 파라미터로서 건네주면, 인증 처리를 실행할 수 있습니다.

-c 는 쿠키 정보를 저장하는 옵션입니다. 옵션 뒤에 붙은 파일 (여기서는 cookie.txt)에 출력됩니다. 인증, 인증으로 쿠키의 세션 정보를 이용하기 위해 저장하고 있습니다.

생성된 쿠키.txt를 열면 Listing 7.1.21 과 같은 형태로 쿠키 정보가 저장된다.

Listing 7.1.21
```
# Netscape HTTP Cookie File
# https://curl.haxx.se/docs/http-cookies.html
# This file was generated by libcurl! Edit at your own risk.

#HttpOnly_localhost   FALSE   /   FALSE   0   JSESSIONID   BB6F44D73F67072157CF916C90392FD8
```

그리고 이 쿠키의 정보를 부가해, 다시 리스트 취득 API를 실행합니다. 명령 7.1.22 와 같이 -b 파일 이름 을 선택적으로 지정하면 저장된 쿠키를 보낼 수 있습니다.

명령 7.1.22
```
$ curl -i -b cookie.txt http://localhost:8080/book/list
HTTP/1.1 200
（생략）

{"book_list":[{"id":100,"title":"Kotlin입문","author":"코틀리니","is_rental""title":"Java입문","author":"자바니","is_rental":false}
```

이번에는 HTTP 상태 200이 되어 데이터도 취득할 수 있게 되었습니다. 그건 그렇고, 로그인 API가 인증 실패 (예 : 암호 실수)는 명령 7.1.23 과 같이 인증 오류를 반환합니다.

명령 7.1.23
```
$ curl -i -c cookie.txt -H 'Content-Type:application/x-www-form-urlencoded' -X POST -d 'email=user@test.com' -d 'pass=test' http://localhost:8080/login
HTTP/1.1 401
（생략）
```

##### 권한이 필요한 API 실행

그런 다음 권한 동작을 확인합니다. 다시 명령 7.1.20 을 실행하여 로그인한 후 명령 7.1.24 의 명령을 실행하여 도서 등록 API에 액세스합니다.

명령 7.1.24
```
$ curl -i -b cookie.txt -H 'Content-Type:application/json' -X POST -d '{"id":400,"title":"Kotlin서버사이드프로그래밍실천","author":"저자명","release_date":"2020-12-24"}' http://localhost:8080/admin/book/register
HTTP/1.1 403
（생략）
```

도서 등록 API는 SecurityConfig 로 작성된 설정으로 ADMIN 권한이 있는 사용자만 액세스할 수 있습니다. USER 권한의 "사용자"는 액세스 권한이 없으므로 권한 부여 오류(403)가 리턴됩니다.

이번에는 ADMIN 권한을 가진 "관리자"로 로그인하고 다시 도서 등록 API를 실행합니다 ( 명령 7.1.25 ).

명령 7.1.25
```
$ curl -i -c cookie.txt -H 'Content-Type:application/x-www-form-urlencoded' -X POST -d 'email=admin@test.com' -d 'pass=admin' http://localhost:8080/login
HTTP/1.1 200
（생략）

$ curl -i -b cookie.txt -H 'Content-Type:application/json' -X POST -d '{"id":400バーサイドプログラミング実践","author":"저자명","release_date":"2020-12-24"}' http://localhost:8080/admin/book/register
HTTP/1.1 200
（생략）
```

성공하고 책을 등록할 수 있었습니다. 여기까지 SecurityConfig , 각종 핸들러로 설정한 대로의 거동으로 처리가 행해지고 있는 것을 확인할 수 있었습니다.

이것으로 인증, 인가는 구현이 완료됩니다. 이러한 응답을 사용하여 프런트 엔드 프로그램에서 다양한 화면 전환을 구현하거나 세션 정보를 사용하여 사용자 데이터를 처리하는 프로세스를 구현할 수 있습니다.

##### 프런트 엔드와의 소통

마지막으로 프런트 엔드와 소통을 하고 로그인 화면에서 인증을 실행해 봅니다.

먼저 브라우저에서 http://localhost:8081/login으로 이동하여 로그인 화면을 엽니다( 그림 7.1 ).

Figure 7.1 login

그런 다음 사용자 이름과 암호에 다음 정보를 입력합니다.

- 사용자 이름: user@test.com
- 암호: user

로그인 버튼을 누르면 인증이 성공하고 책 목록 화면이 표시됩니다 ( 그림 7.2 ).

Figure 7.2 book list

로그인 후 기본적으로 표시하는 페이지는 프런트 엔드 측에서 제어하여 책 목록 페이지로 리디렉션하도록 구현하고 있습니다.

또한 로그인하지 않은 상태나 세션이 만료된 상태에서 http://localhost:8081/book/list 등에 액세스하면 로그인 화면으로 리디렉션됩니다.

#### 세션 정보 저장을 Redis로 변경

지금까지 소개한 방법은 세션 정보를 시작된 Spring Boot 응용 프로그램의 메모리 영역에 저장합니다. 그 때문에 어플리케이션을 정지하면 사라져 버리고, 재기동했을 때에는 재차 인증을 요구할 수 있게 되어 버립니다.

따라서 실제 제품에서는 KVS(Key-Value Store) 등의 미들웨어를 사용하여 그곳에 세션 정보를 보관하는 경우가 많습니다. Spring Security에서도 KVS의 일종인 Redis 주 1 에 보관 유지하는 구조를 간단하게 실장하는 방법이 준비되어 있으므로, 그쪽을 소개합니다.

##### Docker로 Redis 시작

먼저 Redis를 시작합니다. MySQL과 마찬가지로 Docker를 사용하여 쉽게 시작할 수 있습니다. 터미널에서 docker-compose.yml을 배치하는 디렉토리 아래로 이동하고 명령 7.1.26 의 명령으로 한 번 중지합니다.

명령 7.1.26
```
$ docker-compose down
```

그런 다음 6장에서 만든 docker-compose.yml을 Listing 7.1.27 과 같이 다시 작성한다.

Listing 7.1.27
```
version: '3'
services:
  # MySQL
  db:
    image: mysql:8.0.23
    ports:
      - "3306:3306"
    container_name: mysql_host
    environment:
      MYSQL_ROOT_PASSWORD: mysql
    command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
    volumes:
      - ./db/data:/var/lib/mysql
      - ./db/my.cnf:/etc/mysql/conf.d/my.cnf
      - ./db/sql:/docker-entrypoint-initdb.d
  # Redis
  redis:
    image: "redis:latest"
    ports:
      - "6379:6379"
    volumes:
      - "./redis:/data"
```

redis 블록은 Redis의 Docker 이미지를 가져와 컨테이너를 시작하는 설정을 설명합니다.

그런 다음 명령 7.1.28 의 명령으로 다시 시작합니다.

명령 7.1.28
```
$ docker-compose up -d
```

docker container ls 명령을 실행하면 명령 7.1.29 와 같이 MySQL과 Redis 컨테이너가 시작되었음을 알 수 있습니다.

Command 7.1.29

##### build.gradle.kts에 종속성 추가

build.gradle.kts의 dependencies 에 Listing 7.1.30 의 두 종속성을 추가한다.

Listing 7.1.30
```
implementation("org.springframework.session:spring-session-data-redis")
implementation("redis.clients:jedis")
```

spring-session-data-redis 는 세션 정보를 Redis에 보관하는 구현에 필요한 모듈입니다. jedis 는 Redis에 액세스하는 데 사용하는 Java 라이브러리이며 spring-session-data-redis 에서 구현할 때 필요합니다.

##### 세션 정보를 저장할 위치를 Redis로 보내는 구성 클래스 만들기

Redis에 세션 정보를 저장하기위한 구현은 간단하며 목록 7.1.31 과 같은 임의의 이름의 클래스 (여기서는 HttpSessionConfig )를 작성하기 만하면됩니다.

Listing 7.1.31
```
@EnableRedisHttpSession
class HttpSessionConfig {
    @Bean
    fun connectionFactory(): JedisConnectionFactory {
        return JedisConnectionFactory()
    }
}
```

포인트로 @EnableRedisHttpSession 을 부여하여 Spring과 Redis에서 세션 관리를 활성화합니다. 그리고 @Bean 어노테이션을 부여한 임의의 이름의 함수 (여기서는 connectionFactory )로 Redis와의 커넥션을 생성하는데 사용하는 JedisConnectionFactory 클래스의 인스턴스를 생성합니다.

Srping Framework에서 클래스의 인스턴스를 반환하는 함수를 정의하고 @Bean 이라는 주석을 추가하면 해당 함수에서 반환한 인스턴스가 DI 컨테이너에 등록됩니다. 그리고 그 인스턴스를 DI에서 사용할 수 있습니다. 이 JedisConnectionFactory 클래스에 관해서는 명시적으로 DI 하는 것은 아니지만, spring-session-data-redis 안에서 내부적으로 사용됩니다.

이러한 구현을 하는 의미는 DI에서 사용하는 인스턴스의 내용을 변경할 수 있다는 것입니다. Listing 7.1.31 은 기본 상태의 인스턴스를 반환하기 때문에 그다지 의미를 느끼지 않을 수 있지만, 예를 들어 Listing 7.1.32 와 같이 Redis에 대한 연결 설정을 변경할 수도 있습니다.

Listing 7.1.32
```
@EnableRedisHttpSession
class HttpSessionConfig {
    @Bean
    fun connectionFactory(): JedisConnectionFactory {
        val redisStandaloneConfiguration = RedisStandaloneConfiguration().also {
            it.hostName = "kotlin-redis"
            it.port = 16379
        }
        return JedisConnectionFactory(redisStandaloneConfiguration)
    }
}
```

RedisStandaloneConfiguration 클래스의 각 속성에 사용할 값을 설정하고 생성자의 인수로 전달하여 모든 설정을 사용하여 연결을 설정하는 JedisConnectionFactory 클래스의 인스턴스를 생성할 수 있습니다. 여기에서는 Redis의 호스트 이름과 포트 번호를 지정합니다. 아무것도 지정하지 않으면 localhost와 6379 (Redis의 기본 포트)로 기본값으로 연결됩니다.

이 구현을 하는 것으로, 함수내에서 값이 설정된 JedisConnectionFactory 클래스의 인스턴스가 DI 컨테이너에 등록되어 spring-session-data-redis 에서의 Redis 접속시에 사용되는 형태가 됩니다.

##### 동작 확인

세션 관리에 Redis가 사용되고 있는지의 동작을 확인합니다.

먼저 명령 7.1.33 에서 로그인 API를 실행하여 로그인한 다음 명령 7.1.34 에서 도서 목록 API를 실행하여 결과를 검색합니다.

명령 7.1.33
```
$ curl -c cookie.txt -H 'Content-Type:application/x-www-form-urlencoded' -X POST -d 'email=user@test.com' -d 'pass=user' http://localhost:8080/login
```

명령 7.1.34
```
$ curl -b cookie.txt http://localhost:8080/book/list
{"book_list":[{"id":100,"title":"Kotlin입문","author":"코틀리니","is_rental":false},{"id":200,"title":"Java입문","author":"자바니","is_rental":false},{"id":400,"title":"Kotlin서버사이드프로그래밍실천","author":"저자명","is_rental":false}]}
```

그런 다음 응용 프로그램을 다시 시작한 다음 명령 7.1.34 의 curl 명령으로 책 목록 API를 다시 실행합니다. 인증 에러가 되지 않고, 같은 결과가 얻어지면 성공입니다.

### 2　대출, 반환 기능의 API 구현

유저의 인증, 인가를 사용할 수 있게 되었으므로, 나머지의 대출, 반환 기능의 API를 여기에서 구현해 갑니다.

#### 대출 기능 구현

우선은 대출 기능의 구현입니다. 대상 책의 ID를 받고 로그인 중인 사용자로 대출 정보를 등록합니다.

##### 화면 이미지

대출 API를 사용하는 화면 이미지는 그림 7.3 입니다.

Figure 7.3 book detail

도서 상세 화면에서 [대출] 링크를 누르면 확인 팝업이 표시되고 [OK]를 누르면 실행됩니다.

##### Repository 구현

먼저 Listing 7.2.1 의 RentalRepository 인터페이스를 작성한다.

Listing 7.2.1
```
interface RentalRepository {
    fun startRental(rental: Rental)
}
```

그리고 Listing 7.2.2 의 RentalRepositoryImpl 클래스를 만든다. 여기의 import문도 IDE에서의 보완이 잘 되지 않는 것이 포함되어 있기 때문에 기재하고 있습니다.

Listing 7.2.2
```
import com.book.manager.domain.model.Rental
import com.book.manager.domain.repository.RentalRepository
import com.book.manager.infrastructure.database.mapper.RentalMapper
import com.book.manager.infrastructure.database.mapper.insert
import com.book.manager.infrastructure.database.record.RentalRecord
import org.springframework.stereotype.Repository

@Suppress("SpringJavaInjectionPointsAutowiringInspection")
@Repository
class RentalRepositoryImpl(
    private val rentalMapper: RentalMapper
) : RentalRepository {
    override fun startRental(rental: Rental) {
        rentalMapper.insert(toRecord(rental))
    }

    private fun toRecord(model: Rental): RentalRecord {
        return RentalRecord(model.bookId, model.userId, model.rentalDatetime, model.returnDeadline)
    }
}
```

이쪽은 대출시에 불려 가는 처리로, rental 테이블에의 데이터의 등록을 하고 있습니다. 아울러 Rental 클래스에서 RentalRecord 클래스로의 변환 처리도 정의하고 있습니다.

또한 UserRepository 인터페이스에 Listing 7.2.3 , UserRepositoryImpl 클래스에 Listing 7.2.4 의 함수를 추가한다.

Listing 7.2.3
```
fun find(id: Long): User?
```

Listing 7.2.4
```
override fun find(id: Long): User? {
    val record = mapper.selectByPrimaryKey(id)
    return record?.let { toModel(it) }
}
```

기본 키 ID로 사용자 테이블을 검색하는 함수입니다. 세션에 등록된 사용자 ID로 데이터를 검색할 때 사용합니다.

##### 서비스 구현

다음으로 Service의 구현입니다. Listing 7.2.5 의 RentalService 클래스를 생성한다.

Listing 7.2.5
```
// 대출기간
private const val RENTAL_TERM_DAYS = 14L

@Service
class RentalService(
    private val userRepository: UserRepository,
    private val bookRepository: BookRepository,
    private val rentalRepository: RentalRepository
) {
    @Transactional
    fun startRental(bookId: Long, userId: Long) {
        userRepository.find(userId) ?: throw IllegalArgumentException("해당 유저가 없습니다. userId:${userId}")
        val book = bookRepository.findWithRental(bookId) ?: throw IllegalArgumentException("해당서적이 없습니다. bookId:${bookId}")

        // 대출중 체크
        if (book.isRental) throw IllegalStateException("대출중인 상품입니다. bookId:${bookId}")

        val rentalDateTime = LocalDateTime.now()
        val returnDeadline = rentalDateTime.plusDays(RENTAL_TERM_DAYS)
        val rental = Rental(bookId, userId, rentalDateTime, returnDeadline)

        rentalRepository.startRental(rental)
    }
}
```

대상 서적의 ID와 대여하는 사용자의 ID를 인수로 받아 대출 정보를 등록합니다.

우선, 유저 ID로 유저 정보를 취득해, 존재 체크를 하고 있습니다. 존재하지 않으면 예외를 던집니다.

다음에 대상의 서적 정보를 취득해, 이쪽도 존재하지 않는 경우는 예외를 던집니다. 또한 Book 클래스의 isRental 을 사용하여 대출 상황을 확인합니다. 이미 대출 중인 서적이었다면 예외를 던집니다.

여기까지의 체크가 대로, 대출 가능한 서적이었던 경우는, 대출 정보의 등록을 실행합니다. 대출 일시에는 현재 일시, 반환 예정일에는 대출 기간(여기에서는 14일간)을 더한 일시를 설정하고 있습니다.

##### 컨트롤러 구현

그리고 Controller의 구현입니다. 앞에서 설명한 인증된 사용자 정보를 처리합니다. RentalForm.kt(이름은 임의)라는 파일을 만들고 Listing 7.2.6 의 데이터 클래스를 추가한다.

Listing 7.2.6
```
data class RentalStartRequest(
    val bookId: Long
)
```

대출 API의 요청 매개 변수입니다. 책 ID만 있습니다. 그리고 Listing 7.2.7 의 Controller 클래스를 만든다.

Listing 7.2.7
```
@RestController
@RequestMapping("rental")
@CrossOrigin
class RentalController(
    private val rentalService: RentalService
) {
    @PostMapping("/start")
    fun startRental(@RequestBody request: RentalStartRequest) {
        val user = SecurityContextHolder.getContext().authentication.principal as BookManagerUserDetails
        rentalService.startRental(request.bookId, user.id)
    }
}
```

/rental 을 루트 경로로 하고 /start 의 경로에서 대출 처리의 함수를 정의하고 있습니다. 포인트는 Listing 7.2.8 의 부분이 된다.

Listing 7.2.8
```
val user = SecurityContextHolder.getContext().authentication.principal as BookManagerUserDetails
```

이 SecurityContextHolder 안에 인증한 유저의 정보가 보관 유지되어 있어 그것을 취득하고 있습니다. 취득되는 principal 는 Object 형으로서 정의되고 있기 (위해)때문에, BookManagerUserDetails 로 캐스트 하고 있습니다.

이제 ID 및 이메일 주소와 같은 정보가 들어있는 사용자 정보를 처리 할 수 있으므로 RentalService 클래스의 함수를 사용합니다.

##### 동작 확인

대출 API를 실행해 보겠습니다. 대출 기능은 USER 권한으로 액세스할 수 있으므로 '사용자'로 로그인하여 액세스합니다. 명령 7.2.9 를 실행하고 책 ID가 200인 'Java 시작'을 빌립니다.

명령 7.2.9
```
$ curl -c cookie.txt -H 'Content-Type:application/x-www-form-urlencoded' -X POST -d 'email=user@test.com' -d 'pass=user' http://localhost:8080/login

$ curl -b cookie.txt -H 'Content-Type:application/json' -X POST -d '{"book_id":200}:8080/rental/start
```

그런 다음 명령 7.2.10 의 curl 명령으로 상세 검색 API를 실행하여 대출 상태를 확인합니다.

명령 7.2.10
```
$ curl -b cookie.txt http://localhost:8080/book/detail/200
{"id":200,"title":"Java입문","author":"자바니","release_date":"2005-08-29","rental_info":{"user_id":2,"rental_datetime":"2021-01-24T21:01:41","return_deadline":"2021-02-07T21:01:41"}}
```

대출 정보가 등록되어 있기 때문에 rental_info 의 정보가 들어간 상태로 돌아오게 되었습니다. 또한이 상태에서 동일한 책에 대출 API를 실행하면 오류가 반환됩니다 ( 명령 7.2.11 ).

명령 7.2.11
```
$ curl -b cookie.txt -H 'Content-Type:application/json' -X POST -d '{"book_id":200}' http://localhost:8080/rental/start
{"timestamp":"2020-08-01T02:28:03.397+00:00","status":500,"error":"Internal Server Error","message":"","path":"/rental/start"}
```

##### 프런트 엔드와의 소통

완성된 API를 프런트 엔드와 소통합니다. 브라우저에서 http://localhost:8081/book/detail/200(200 부분은 임의의 도서 ID를 입력)에 액세스하여 도서 상세 화면을 표시하고 [대출] 링크를 누르십시오. 그림 7.4 와 같은 대출 확인 팝업이 표시됩니다.

Figure 7.4 book loan detail.jpeg

[OK]를 눌러 그림 7.5 와 같은 화면이 표시되면 성공합니다.

Figure 7.5 book loan ok.jpeg

같은 도서 상세 화면이지만 반환 예정일 등의 대출 정보가 표시되고 반환 링크가 표시됩니다. 반환 링크는 빌린 사용자가 액세스한 경우에만 표시됩니다.

#### 반환 기능 구현

다음은 반환 기능의 구현입니다. 이제 기능별 API 구현이 끝납니다. 대출 기능과 마찬가지로 대상 서적 ID를 받고 로그인 중인 사용자 정보를 사용하여 반환 처리를 합니다.

반환 처리는 rental 테이블의 레코드를 삭제함으로써 실현됩니다.

##### 화면 이미지

대출 API를 사용하는 화면 이미지는 그림 7.6 입니다.

그림 7.6
Figure 7.6 book return.jpeg

빌린 도서의 도서 상세 페이지로 이동하면 표시되는 [반환] 링크를 누르면 확인 팝업이 표시되고 [OK]를 누르면 실행됩니다.

##### Repository 구현

RentalRepository 인터페이스에 Listing 7.2.12 , RentalRepositoryImpl 클래스에 Listing 7.2.13 의 함수를 추가한다.

Listing 7.2.12
```
fun endRental(bookId: Long)
```

Listing 7.2.13
```
override fun endRental(bookId: Long) {
    rentalMapper.deleteByPrimaryKey(bookId)
}
```

반환 대상 책 ID를 인수로 받고 rental 테이블의 레코드를 삭제합니다.

##### 서비스 구현

다음으로 Service의 구현입니다. RentalService 클래스에 Listing 7.2.14 의 함수를 추가한다.

Listing 7.2.14
```
@Transactional
fun endRental(bookId: Long, userId: Long) {
    userRepository.find(userId) ?: throw IllegalArgumentException("해당 유저가 없습니다. userId:${userId}")
    val book = bookRepository.findWithRental(bookId) ?: throw IllegalArgumentException("해당서적이 없습니다. bookId:${bookId}")

    // 대출중 체크
    if (!book.isRental) throw IllegalStateException("대출하지 않은 상품입니다. bookId:${bookId}")
    if (book.rental!!.userId != userId) throw IllegalStateException("다른 유저가 대출중입니다. userId:${userId} bookId:${bookId}")

    rentalRepository.endRental(bookId)
}
```

대상 서적 ID와 대출 사용자 ID를 인수로 받아 대출 정보를 삭제합니다.

대출 기능과 마찬가지로 유저 ID와 서적 ID로 각각의 존재 체크를 하고 있습니다. 존재하지 않으면 예외를 던집니다.

그런 다음 Book 클래스의 isRental 을 사용하여 대출 상황을 확인하고 대출중인 책이 아니면 예외를 던집니다.

게다가 대출중이었던 경우도 대출 유저가 파라미터로 보내져 온 ID의 유저인지 체크해, 다른 경우는 예외를 던집니다.

지금까지 확인을 통과 한 후 리포지토리 처리를 호출 데이터 삭제를 수행합니다.

##### 컨트롤러 구현

그리고 Controller의 구현입니다. 반환 처리에서도 인증한 사용자 정보를 취급합니다.

RentalController 클래스에 Listing 7.2.15 의 함수를 추가한다.

Listing 7.2.15
```
@DeleteMapping("/end/{book_id}")
fun endRental(@PathVariable("book_id") bookId: Long) {
    val user = SecurityContextHolder.getContext().authentication.principal as BookManagerUserDetails
    rentalService.endRental(bookId, user.id)
}
```

/end 라는 패스에 패스 파라미터로 반환 대상의 서적 ID를 받아, SecurityContextHolder 로부터 세션의 유저 정보를 취득해, 반환 처리를 실행하고 있습니다.

##### 동작 확인

반환 API 실행입니다. 명령 7.2.16 의 curl 명령을 사용하여 위의 대출 API에서 빌린 책을 반환합니다(세션이 만료된 경우 먼저 로그인 API를 실행하십시오).

명령 7.2.16
```
$ curl -b cookie.txt -X DELETE http://localhost:8080/rental/end/200
```

그런 다음 명령 7.2.17 의 curl 명령을 사용하여 도서 세부 정보 검색 API를 실행하여 대출 상태를 확인합니다.

명령 7.2.17
```
$ curl -b cookie.txt http://localhost:8080/book/detail/200
{"id":200,"title":"Java입문","author":"자바니","release_date":"2005-08-29","rental_info":null}
```

대출 정보가 삭제되고 rental_info 가 null가 된 상태로 돌아옵니다.

이것으로 모든 API 구현이 완료되었습니다.

##### 프런트 엔드와의 소통

완성된 API를 프런트 엔드와 소통합니다. 책을 빌린 사용자로 로그인하고 브라우저에서 http://localhost:8081/book/detail/200(200 부분은 임의의 책 ID를 입력)에 액세스하여 책 상세 화면을 표시하고 [반환 ] 링크를 누르십시오. 그림 7.7 과 같은 대출 확인 팝업이 표시됩니다.

Figure 7.7 your return.jpeg

[OK]를 눌러 그림 7.8 과 같은 화면이 표시되면 성공합니다.

Figure 7.8 return ok.jpeg

반환이 완료되었으므로 대출 정보가 사라지고 대출 링크가 표시되고 대출 전 상태 세부 정보 페이지에 표시가 반환됩니다.

### 3　Spring AOP에서 로그 출력

다음은, 어플리케이션의 공통 기구로서, API 액세스시의 로그 출력을 할 수 있도록(듯이) 합니다. Spring AOP라는 기능을 사용하여 매 API 액세스에 대한 로그 출력 처리를 연결하는 처리를 구현합니다.

#### Spring AOP란?

Spring AOP는 AOP(Aspect Oriented Programming, Aspect Directed Programming)를 실현하기 위한 Spring Framework의 라이브러리입니다. AOP는 로깅과 같이 다양한 오브젝트에서 실행되는 처리(횡단적 관심사라고 합니다)를 잘라내어, 각 오브젝트로부터 직접 호출하지 않고 실행되는 공통의 처리로서 정의하는 프로그래밍 패러다임이 됩니다.

#### build.gradle.kts에 종속성 추가

Spring AOP를 사용하는 종속성을 build.gradle.kts에 추가합니다. dependencies 에 Listing 7.3.1 을 추가한다.

Listing 7.3.1
```
implementation("org.springframework.boot:spring-boot-starter-aop")
```

#### application.yml 로깅 설정 추가

로깅 설정을 추가합니다. 6장에서 만든 application.yml을 Listing 7.3.2 와 같이 다시 작성한다.

Listing 7.3.2
```
spring:
  datasource:
    url: jdbc:mysql://127.0.0.1:3306/book_manager?characterEncoding=utf8
    username: root
    password: mysql
    driverClassName: com.mysql.jdbc.Driver
  jackson:
    property-naming-strategy: SNAKE_CASE
# 로깅에 대한 설정
logging:
  level:
    root: INFO
```

logging 이하의 부분이 로깅에 관한 설정입니다. 여기에서는 level 로 로그 레벨을 정의하고 있어, 로그 레벨이 INFO 이상의 것만 출력되도록(듯이) 설정하고 있습니다.

#### @Before, @After에서 Controller 전후에 로깅 추가

먼저 각 API에서 액세스되는 Controller 전후에 액세스된 함수의 정보를 출력하는 처리를 정의합니다. Listing 7.3.3 의 LoggingAdvice 클래스(이름은 임의)를 생성한다.

Listing 7.3.3
```
private val logger = LoggerFactory.getLogger(LoggingAdvice::class.java)

@Aspect
@Component
class LoggingAdvice {
    @Before("execution(* com.book.manager.presentation.controller..*.*(..))")
    fun beforeLog(joinPoint: JoinPoint) {
        val user = SecurityContextHolder.getContext().authentication.principal as BookManagerUserDetails
        logger.info("Start: ${joinPoint.signature} userId=${user.id}")
        logger.info("Class: ${joinPoint.target.javaClass}")
        logger.info("Session: ${(RequestContextHolder.getRequestAttributes() as ServletRequestAttributes).request.session.id}")
    }

    @After("execution(* com.book.manager.presentation.controller..*.*(..))")
    fun afterLog(joinPoint: JoinPoint) {
        val user = SecurityContextHolder.getContext().authentication.principal as BookManagerUserDetails
        logger.info("End: ${joinPoint.signature} userId=${user.id}")
    }
}
```

클래스명에 포함되어 있는 Advice (어드바이스)는, AOP에서 「횡단적 관심사」의 처리를 정의하는 것을 가리킵니다. 정의하는 클래스에는 @Aspect 어노테이션을 부여합니다.

그리고 이 클래스내에서 정의되고 있는 beforeLog , afterLog 라고 하는 함수로 쓰여져 있는 것이 처리의 내용이 됩니다. @Before 의 어노테이션이 부여된 함수가 전처리, @After 의 부여된 함수가 후처리를 구현하고 있어, 각각 어노테이션의 인수로 지정한 클래스에 대해서 기능합니다.

##### 주석 인수

execution 을 사용하여 대상 함수를 지정할 수 있습니다. 인수로 정의하는 값의 의미는 다음과 같습니다.

(반환 값 패키지 이름, 클래스 이름, 함수 이름 (인수 유형))

* 로 지정한 부분은 임의의 문자열을 나타냅니다. 이 예에서는 패키지명만을 지정해, 그 외의 파라미터는 모두 임의의 캐릭터 라인으로 하고 있습니다. com.book.manager.presentation.controller 아래의 클래스, 즉 각 API의 Controller 클래스의 처리가 호출되기 전후에 이 함수의 처리가 실행됩니다. 여기에서는 샘플 프로젝트에 맞추고 있습니다만, 다른 이름을 사용하고 있는 경우는 자신의 환경에 맞추어, Controller 클래스를 배치하고 있는 패키지로 변경해 주세요.

##### 대상 처리 정보 얻기

함수의 인수로 지정하고 있는 JoinPoint 에는, 이 Before , After 의 처리가 불려 가는 대상의 처리 (여기에서는 Controller 클래스의 처리)의 정보가 포함되어 있습니다. 여기서는 joinPoint.signature 를 호출하여 함수의 서명 정보를 출력합니다.

##### SLF4J 로거에 의한 로그 출력

톱 레벨로 정의하고 있는 LoggerFactory. getLogger(LoggingAdvice::class.java) 로, 로거를 생성하고 있습니다. 이것은 SLF4J라는 Java 로그 라이브러리를 사용합니다. info , error 등 로그 레벨 마다의 메소드가 준비되어 있어, 여기에서는 INFO로 함수의 시그니쳐, 세션으로부터 취득한 유저 ID를 출력하고 있습니다.

##### 동작 확인

로그인하여 도서 목록 검색 API를 실행합니다 ( 명령 7.3.4 ).

명령 7.3.4
```
$ curl -c cookie.txt -H 'Content-Type:application/x-www-form-urlencoded' -X POST -d 'email=user@test.com' -d 'pass=user' http://localhost:8080/login

$ curl -b cookie.txt http://localhost:8080/book/list
{"book_list":[{"id":100,"title":"Kotlin입문","author":"코틀리니","is_rental":false},{"id":200,"title":"Java입문","author":"자바니","is_rental":false}]}
```

실행중인 터미널 (IntelliJ IDEA에서 실행중인 경우 IntelliJ IDEA의 Run 뷰)에 목록 7.3.5 와 같은 로그가 출력됩니다.

Listing 7.3.5
```
INFO 49745 --- [nio-8080-exec-1] com.book.manager.aop.LoggingAdvice       : Start: GetBookListResponse com.book.manager.presentation.controller.BookController.getList() userId=2

（생략）

INFO 49745 --- [nio-8080-exec-1] com.book.manager.aop.LoggingAdvice       : End: GetBoocom.book.manager.presentation.controller.BookController.getList() userId=2
```

GetBookListResponse com.book.manager.controller.BookController.getList() 가 joinPoint.signature 로 출력하고 있는 것입니다. 반환값의 형태와 패키지명, 클래스명, 함수명이 출력됩니다.

##### @Around에 의한 전후 처리의 삽입

전후에 처리를 꽂는 것은, @Around 라는 어노테이션을 사용해도 실현할 수 있습니다. LoggingAdvice 클래스에 Listing 7.3.6 의 함수를 추가한다.

Listing 7.3.6
```
@Around("execution(* com.book.manager.presentation.controller..*.*(..))")
fun aroundLog(joinPoint: ProceedingJoinPoint): Any? {
    // 전처리
    val user = SecurityContextHolder.getContext().authentication.principal as BookManagerUserDetails
    logger.info("Start Proceed: ${joinPoint.signature} userId=${user.id}")

    // 본처리의 실행
    val result = joinPoint.proceed()

    // 후처리
    logger.info("End Proceed: ${joinPoint.signature} userId=${user.id}")

    // 본처리 결과의 반환
    return result
}
```

ProceedingJoinPoint 라는 형식의 값을 인수로 사용합니다. 이 인수의 proceed() 메소드를 실행하면, AOP의 대상의 처리를 실행합니다. 그 전후에 처리를 쓰는 것으로 공통의 전처리, 후처리를 실현할 수 있어 보다 유연한 실장이 가능합니다. 어노테이션의 인수 지정은 @Before , @After 와 같습니다.

도서 목록 검색 API를 실행하면 목록 7.3.7 과 같은 로그가 출력됩니다.

Listing 7.3.7
```
2020-08-09 10:25:47.660  INFO 49888 --- [nio-8080-exec-1] com.book.manager.aop.LoggingAdvice       : Start Proceed: GetBookListResponse com.book.manager.presentation.controller.BookController.getList() userId=2

（생략）

2020-08-09 10:25:47.950  INFO 49888 --- [nio-8080-exec-1] com.book.manager.aop.LoggingAEnd Proceed: GetBookListResponse com.book.manager.presentation.controller.BookController.getList() userId=2
```

#### @AfterReturning, @AfterThrowing에 의한 후처리 병합

단순히 처리 전후뿐만 아니라 반환 값이나 예외에 따라 후 처리를 정의 할 수도 있습니다.

##### @AfterReturning -- 반환값에 따라 실행하는 후처리

@AfterReturning 은 반환 값에 따라 수행할 처리를 정의합니다. Listing 7.3.8 과 같이 구현한다.

Listing 7.3.8
```
@AfterReturning("execution(* com.book.manager.presentation.controller..*.*(..))", returning = "returnValue")
fun afterReturningLog(joinPoint: JoinPoint, returnValue: Any?) {
    logger.info("End: ${joinPoint.signature} returnValue=${returnValue}")
}
```

returning 에서 지정한 이름으로 대상 처리의 반환값을 처리할 수 있습니다. 같은 이름의 인수를 afterReturningLog 함수에 정의하고 로깅합니다. Listing 7.3.9 와 같은 로그가 출력된다.

Listing 7.3.9
```
INFO 50378 --- [nio-8080-exec-3] com.book.manager.aop.LoggingAdvice       : End: GetBookListResponse com.book.manager.presentation.controller.BookController.getList() returnValue=GetBookListResponse(bookList=[BookInfo(id=100, title=Kotlin입문, author=코틀리니, isRental=false), BookInfo(id=200, title=Java입문, author=자바니, isRental=false), BookInfo(id=400, title=Kotlin서버사이드프로그래밍실천, author=저자명, isRental=false)])
```

도서 목록 취득 API의 응답 값이 출력됩니다.

##### @AfterThrowing -- 예외의 종류에 따라서 실행하는 후처리

@AfterThrowing 은 예외가 throw될 때 throw된 예외 유형에 따라 수행할 처리를 정의할 수 있습니다. Listing 7.3.10 과 같이 구현한다.

Listing 7.3.10
```
@AfterThrowing("execution(* com.book.manager.presentation.controller..*.*(..))", throwing = "e")
fun afterThrowingLog(joinPoint: JoinPoint, e: Throwable) {
    logger.error("Exception: ${e.javaClass} signature=${joinPoint.signature} message=${e.message}")
}
```

@AfterReturning 과 비슷하며 throwing 으로 지정한 이름으로 함수의 인수에 예외를 전달합니다. 여기에서는 throw 된 예외의 클래스명과 메세지를 출력하고 있습니다.

도서 상세 검색 API에 존재하지 않는 ID를 전달하여 실행하여 예외를 발생시킵니다 ( 명령 7.3.11 ).

명령 7.3.11
```
$ curl -b cookie.txt http://localhost:8080/book/detail/1
```

Listing 7.3.12 와 같이 throw 된 IllegalArgumentException 과 메시지가 출력된다.

Listing 7.3.12
```
ERROR 50818 --- [nio-8080-exec-1] com.book.manager.aop.LoggingAdvice       : Exception: class java.lang.IllegalArgumentException signature=GetBookDetailResponse com.book.manager.presentation.controller.BookController.getDetail(long) message=존재하지 않는 책 id: 1
```

이 예에서는 Throwable 형을 인수로서 정의했기 때문에 모든 예외가 발생했을 때에 불려집니다만, 특정의 예외 클래스의 형태를 지정하는 것으로, 그 형태의 예외가 Throw 되었을 때만 실행되도록(듯이) 하는 것도 가능합니다. 예를 들어 Listing 7.3.13 과 같이 구현하면 IllegalArgumentException 이 throw 될 때만 afterThrowingLog 처리가 실행됩니다.

Listing 7.3.13
```
@AfterThrowing("execution(* com.book.manager.presentation.controller..*.*(..))", throwing = "e")
fun afterThrowingLog(joinPoint: JoinPoint, e: IllegalArgumentException) {
    logger.error("Exception: ${e.javaClass} signature=${joinPoint.signature} message=${e.message}")
}
```

참고 1 　 https://redis.io/

( 본문으로 돌아가기 )

