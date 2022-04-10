원본 링크: https://subscription.packtpub.com/book/virtualization-and-cloud/9781789538830/pref
Path:
packtpub/bashQuickStartGuide/100
Title:
100 Preface
Short Description:
Bash Quick Start Guide 머리말
작성: 2022-04-10 일 20:22:18

@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


원본 제목: Chapter 3: Flutter versus Other Frameworks
원본 제목: Chapter 3: Flutter versus Other Frameworks
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
길:
packtpub/flutter4beginners2/103
packtpub / flutter4beginners2 / 103.
Title:
제목:
103 Flutter versus Other Frameworks
103 다른 프레임 워크 대 플러 터스
Short Description:
간단한 설명:
Flutter for Beginners Second Edition 플러터와 다른 프레임워크 비교
Flutter for Beginners Second Edition 플러터와 다른 프레임워크 비교

![Figure 3.6 - Example pub.dev search ](/flutter4beginners2_img/figure_3.6_-_example_pub.dev_search.jpg)
! [그림 3.6 - 예제 pub.dev 검색] (/ flutter4beginners2_img / figure_3.6 _-_ example_pub.dev_search.jpg)
- cut line
- 절단 선


# Chapter 3: Flutter versus Other Frameworks
# 제 3 장 : 파워 대 다른 프레임 워크와
Flutter for Beginners Second Edition
초보자를위한 펄럭스 2 초판

Making a technology choice is rarely simple, and generally requires understanding the pros and cons of the different options, and eventually a leap of faith. You may be at the point where you are deciding whether your next project is going to be Flutter based, you may have dabbled with Flutter and want to solidify your knowledge before pushing forward with it, or you may be experienced and want a knowledge refresher. Regardless of your experience, it is always useful to understand the technology landscape and understand the synergies between different frameworks.
기술 선택을하는 것은 거의 간단하지 않으며 일반적으로 다른 옵션의 장단점을 이해하고 결국 믿음의 도약을 요구합니다.다음 프로젝트가 펄럭이는 지 여부를 결정할 수있는 지점에있을 수 있습니다. 앞으로 나아가기 전에 펄럭이고 지식을 고정 시키거나 경험이있을 수 있고 지식을 재교육하고 싶을 수도 있습니다.귀하의 경험에 관계없이 기술 환경을 이해하고 다른 프레임 워크 간의 시너지 효과를 이해하는 것이 항상 유용합니다.

In this chapter, you will see how Flutter compares to other frameworks: the similarities and differences, the pros and cons of the different options, and how existing knowledge of another framework can be applied to Flutter. Even if you are fully decided on using Flutter in the future, it is worth reviewing this chapter as it gives context to some of the design decisions that have been made.
이 장에서는 다른 프레임 워크와 다른 옵션의 찬반 양식과 다른 프레임 워크의 기존 지식이 펄럭임에 어떻게 적용될 수 있는지 다른 프레임 워크와 비교하는 방법을 볼 수 있습니다.미래에 펄럭임을 사용하여 완전히 결정 되더라도이 장 에서이 장을 검토 할 가치가 있으므로 설계 결정 중 일부에 맥락을 제공합니다.

The following topics will be covered in this chapter:
이 장에서는 다음 주제가 다루어집니다.

- Native development
- 네이티브 개발
- Cross-platform frameworks
- 플랫폼 크로스 프레임 워크
- Flutter community
- 펄럭이있는 커뮤니티
- Flutter strengths and weaknesses
- 강력한 강점과 약점

# Native development
# 네이티브 개발

Often cited as the purest solution, native development refers to writing apps in the language common to the platform of the device. For iOS this is Swift (or previously, Objective-C), for Android it is Kotlin (or previously, Java), and for the web it is generally HTML/JavaScript:
가장 순수한 해결책으로 종종 인용되면 원시 개발은 장치의 플랫폼에 공통된 언어로 앱을 작성하는 것을 의미합니다.iOS의 경우 이것은 Swift (또는 이전, objective-c), kotlin (또는 이전에, Java)이며, 일반적으로 HTML / JavaScript입니다.

![Figure 3.1 - Swift and Kotlin logos ](/flutter4beginners2_img/figure_3.1_-_swift_and_kotlin_logos.jpg)
! [그림 3.1 - 스위프트 및 Kotlin 로고] (/ flutter4beginners2_img / figure_3.1 _-_ swift_and_kotlin_logos.jpg)

Native is seen as the purest solution because there is no bridge between the app and the platform, or no transpilation of code. Therefore, the code that is developed is the code that is run and talks directly to the features available from the platform, be that iOS, Android, or the web browser. Once you move away from native development, you introduce certain risks, such as the following:
앱과 플랫폼 간의 다리가 없거나 코드의 동작이 없기 때문에 원주민은 가장 순수한 해결책으로 간주됩니다.따라서 개발 된 코드는 실행중인 코드이며 플랫폼에서 사용할 수있는 기능으로 직접 대화하는 코드, iOS, Android 또는 웹 브라우저가됩니다.원시 개발에서 벗어나면 다음과 같은 특정 위험을 도입합니다.

- The software bridge having slow performance or deep, difficult to diagnose, bugs
- 성능이 느린 또는 깊은 소프트웨어 브리지, 진단하기가 어렵고, 버그
- The transpilation process having deep, difficult to diagnose, bugs
- 깊고 진단하기가 어렵고 버그가있는 트랜스 션 프로세스
- A lack of access to key platform features
- 주요 플랫폼 기능에 대한 액세스가 부족합니다

It is therefore critically important that the quality of alternatives is assessed when moving away from native programming as a fundamental problem in an alternative framework can block and even invalidate an app.
따라서 대체 프레임 워크에서 기본 프로그래밍에서 멀리 이동할 때 원시 프로그래밍에서 벗어나는 경우 대안의 품질이 평가되는 것이 중요합니다.

## Learning from experience 1
## 경험에서 배우기 1

A real-world example of a framework problem invalidating an app happened to me a few years ago. We were using a cross-platform solution and were developing and testing on iOS. The framework effectively used a software bridge by embedding a web browser in the app, with the app running within the embedded web browser (we will see examples of this later). Once the app was nearing completion, we started testing on Android and found that the software bridge had serious performance issues that were fundamental and could not be worked around. After much heartache, the app was eventually only released on iOS, and an important lesson had been learned!
앱을 무효화하는 프레임 워크 문제의 실제 예제는 몇 년 전에 나에게 일어났습니다.우리는 크로스 플랫폼 솔루션을 사용하고 있으며 iOS를 개발하고 테스트했습니다.프레임 워크는 앱에 웹 브라우저를 삽입하여 소프트웨어 브리지를 효과적으로 사용하여 앱이 내장 된 웹 브라우저에서 실행되는 앱을 사용하여 (나중에 예제를 볼 수 있습니다).앱이 완료되면 우리는 Android에서 테스트를 시작했으며 소프트웨어 브리지가 근본적이었고 주변에서 일할 수 없었던 심각한 성능 문제가 있음을 발견했습니다.훨씬 상심 후, 앱은 결국 iOS에서만 발표되었으며, 중요한 교훈은 배웠습니다!

So, if native development is likely to have the best performance, the least chance of fundamental issues, and is the least likely to have deep bugs, why would you ever move away from native? There are many reasons, but like I said earlier, a technology decision is rarely clear-cut. Let's explore the many factors that can contribute to taking the decision to move away from native programming.
따라서 원주민 발전이 최상의 성능을 갖기 위해 최상의 문제가 발생할 가능성이 있으며 깊은 버그가 가장 적은 것은 무엇인가 원주민에서 멀리 이동할 것입니까?많은 이유가 있지만, 내가 말했듯이, 기술 결정은 거의 분명하지 않습니다.네이티브 프로그래밍에서 벗어나기로 결정을 내리는 데 기여할 수있는 많은 요인을 탐색합시다.

### Developers
### 개발자

Many software projects have their technology choices decided not by careful consideration of the different technology options, cross-referenced against expected development timelines, with performance benchmarks and UI studies brought to bear. Let's be honest, most technology choices are either based on the skillset available, or the skillset that developers would like to learn next.
많은 소프트웨어 프로젝트는 기술적 인 기술 옵션을주의 깊게 고려하여 예상 개발 타임 라인을 상호 참조하지 않고 성능 벤치 마크 및 UI 연구가 끌어 올리고 있습니다.솔직히 말해서, 대부분의 기술 선택은 이용 가능한 스킬 셋 또는 개발자가 다음을 배우고 싶은 스킬 셋을 기반으로합니다.

Learning a new programming language and framework will delay a project, sometimes seriously, and the code developed early in the project will be rewritten many times as developers learn to structure their code better, encounter different design methodologies, and optimize the execution flows.
새로운 프로그래밍 언어와 프레임 워크를 배우는 것은 때로는 프로젝트를 지연시키고 때로는 프로젝트 초기에 개발 된 코드가 개발자가 자신의 코드를 더 잘 구조화하고, 다른 설계 방법론을 만나고 실행 흐름을 최적화하는 것에 따라 여러 번 재 작성됩니다.

This initial delay has to be taken into account when assessing technology choices; the best technology choice may not be the best project choice. If you already have a pool of developers, then the benefits of a technology change may be more than consumed by the reduction in productivity.
이 초기 지연은 기술 선택을 평가할 때 고려해야합니다.최고의 기술 선택은 최상의 프로젝트 선택이 아닐 수도 있습니다.이미 개발자 풀이있는 경우 기술 변화의 이점은 생산성 감소에 의해 소비 될 수 있습니다.

On the flip side, native developers tend to be more expensive and in higher demand than developers for other technologies. Additionally, learning a new skillset may initially reduce productivity, but for longer-running projects you would expect productivity to recover.
플립 측면에서 원시 개발자는 다른 기술을위한 개발자보다 더 비싸고 더 높은 수요가되는 경향이 있습니다.또한 새로운 스킬 셋을 배우는 것은 처음에는 생산성을 낮추지 만 생산성을 기대할 수있는 장기간 프로젝트의 경우 생산성이 발생할 수 있습니다.

### Project management
### 프로젝트 관리

Unless you are developing for one platform, you will need several teams of developers to develop natively. This is because a Swift developer is generally not also a Kotlin developer, or if they are, the context switching between the two languages and development environments can seriously impact productivity.
하나의 플랫폼을 개발하지 않는 한, 여러 개발자 팀이 기본적으로 개발할 수 있습니다.이는 신속 개발자가 일반적으로 Kotlin 개발자가 아니거나 두 언어와 개발 환경 간의 컨텍스트 전환이 생산성에 심각한 영향을 미칠 수 있기 때문입니다.

Project managing several development teams where the resources are not fungible (that is,you cannot move a developer from one team to another) can lead to complications in ensuring feature parity and defect resolution.
프로젝트는 자원이 펑키되지 않은 여러 개발 팀을 관리하는 경우 (즉, 한 팀의 개발자를 다른 팀에서 다른 팀으로 이동할 수없는 경우) 기능 패리티 및 결함 해상도를 보장하는 데 합병증으로 이어질 수 있습니다.

For example, suppose that there is an iOS development team and an Android development team working on the same backlog of features for an app, aiming for a shared release date.
예를 들어, 공유 릴리스 날짜를 목표로하는 앱의 동일한 백 로그로 작업하는 iOS 개발 팀과 Android 개발 팀이 있다고 가정합니다.

Imagine that the iOS development team encounters a defect that is complex to diagnose and fix, while the Android development team continues development at a high velocity. As the release deadline approaches, the Android team has many more features completed than the iOS team. At this point, the project manager has to earn their money by deciding whether to do the following:
IOS 개발 팀이 진단하고 수정하기 위해 복잡한 결함이있는 반면 안드로이드 개발 팀은 높은 속도로 개발을 계속한다고 상상해보십시오.릴리스 마감일이 접근하면 Android 팀은 iOS 팀보다 많은 기능을 완료했습니다.이 시점에서 Project Manager는 다음을 수행할지 여부를 결정함으로써 돈을 벌어야합니다.

- Release the apps without feature parity. This can be a confusing experience for users who have multiple devices.
- 기능 패리티없이 앱을 출시하십시오.이것은 여러 장치가있는 사용자에게 혼란스러운 경험이 될 수 있습니다.
- Delay release until the iOS team catches up. What do you do with the Android team during this time? They are likely to tidy up their code, fixing more minor bugs, and doing more extensive testing, leaving the Android code base in a much better state than the iOS code base, leading to further productivity differences going forward.
- iOS 팀이 잡을 때까지 릴리스 릴리스.이 시간 동안 안드로이드 팀과 함께 무엇을합니까?그들은 코드를 정리하고, 더 많은 사소한 버그를 고치고, 더 광범위한 테스트를하고, Android 코드 기반을 iOS 코드 기반보다 훨씬 더 나은 상태로 남겨 둘 가능성이 높고, 더 많은 생산성 차이를 높이기로 향상시킵니다.
- Disable features on the Android version. Not necessarily an easy option if, as is normally the case, the features are not completely disconnected, and also likely to introduce bugs going forward unless disabling the feature is given time to be coded fully.
- Android 버전의 기능을 사용하지 않도록 설정합니다.일반적으로 사례와 마찬가지로 기능을 완전히 분리하지 않으며 기능을 비활성화하지 않는 한 기능을 완전히 연결 해제하지 않으면 기능이 완전히 코딩되는 시간이 주어지지 않는 경우가 있습니다.

None of these options are optimal and are exacerbated if you are also developing for other platforms such as the web.
이러한 옵션 중 어느 것도 최적이며 웹과 같은 다른 플랫폼을 개발할 경우 악화됩니다.

Contrast this with a single code base where one, or many, development teams are working in the same language, development environment, and backlog of features. If there are multiple teams, then the developers are much more fungible; if one team is struggling with a feature, then a developer can more easily switch teams and assist with the development.
이것을 하나의 코드 기반으로 대비하여 하나 또는 많은 개발 팀이 동일한 언어, 개발 환경 및 기능의 백 로그에서 일하고 있습니다.여러 팀이있는 경우 개발자는 훨씬 더 훌륭합니다.한 팀이 기능으로 고심하고 있다면 개발자는 팀을보다 쉽게 전환하고 개발을 돕습니다.

### Defect reports
### 결함 보고서

Similar to the project management considerations, having native apps will lead to disparities in defect reports. One development team may have done less testing than the other, so on release, one app may be inundated with defect reports, while the other app may be relatively free of defects.
기본 앱을 사용하는 프로젝트 관리 고려 사항과 마찬가지로 결함 보고서가 불균형으로 이어질 것입니다.하나의 개발 팀은 다른 개발 팀이 다른 것보다 적은 테스트를 수행했을 수 있으므로 릴리스에서는 한 앱이 결함 보고서로 범람 될 수 있지만 다른 앱은 상대적으로 결함이 없을 수 있습니다.

Additionally, you now need to know which platform the user is using to know which app has the bug. In some circumstances, such as crash reporting, this isn't such an issue. However, the vaguer identification of defects, such as a comment on a forum or social media, will likely not reveal that information, leading to a more complex identification and resolution of the defect.
또한 이제 사용자가 버그가있는 응용 프로그램을 알기 위해 사용자가 사용하는 플랫폼을 알아야합니다.충돌보고와 같은 경우에도 이러한 문제가 아닙니다.그러나 포럼 또는 소셜 미디어에 대한 의견과 같은 결함의 모호한 식별은 그 정보가 더 복잡한 식별 및 결의안을 유도하는 것으로 밝혀지지 않을 것입니다.

### Performance
### 성능

Measuring performance is notoriously difficult. Do you look at benchmarks that only exercise certain parts of the framework or programming language, or higher-level performance, which can highly depend on the app structure, how the framework has been employed, and the kinds of tasks the app is doing? Therefore, in this chapter, generalities will be used simply as a guide.
측정 성능은 악명 높습니다.프레임 워크 또는 프로그래밍 언어의 특정 부분을 연습하는 벤치 마크를 살펴 보시려면 앱 구조에 크게 의존 할 수있는 상위 수준의 성능, 프레임 워크가 사용 된 방식 및 앱이 수행하는 작업의 종류의 종류를 살펴볼 수 있습니까?따라서이 장에서는 일반이 단순히 가이드로 사용됩니다.

However, it is generally accepted that native apps are the fastest and it is pretty clear why. The language and framework are optimized for the platform and vice versa.
그러나 원시 앱이 가장 빠르게 그렇게되는 것은 일반적으로 받아 들여지고 왜 분명합니다.언어와 프레임 워크는 플랫폼에 최적화되어 있으며 그 반대도 마찬가지입니다.

Also, and equally importantly, there are no cross-platform compromises that need to be made. To make a framework completely cross-platform means that the app code may interact with the platform in a suboptimal way so that a single piece of code can work with all platforms.
또한 똑같이 중요하게도, 이루어질 필요가있는 크로스 플랫폼 타협이 없습니다.프레임 워크를 완전히 교차 플랫폼으로 만들려면 앱 코드가 모든 코드가 모든 플랫폼에서 작동 할 수 있도록 서브 오디오 방식으로 플랫폼과 상호 작용할 수 있음을 의미합니다.

For example, to use a feature, there may only need to be a single method call, but to use the same feature on Android may require several method calls. Depending on how this interaction is revealed to the developer, it may lead to suboptimal performance.
예를 들어 기능을 사용하려면 단일 메소드 호출이 있어야하지만 Android에서 동일한 기능을 사용하려면 여러 메소드 호출이 필요할 수 있습니다.이 상호 작용이 개발자에게 밝혀지는 방법에 따라 지하철 성능이 발생할 수 있습니다.

However, it is worth noting that in some situations, Flutter has been seen to be comparable with native apps in terms of performance, and it definitely doesn't appear to be an issue that is mentioned within the Flutter community.
그러나 어떤 상황에서는 펄터가 성능면에서 기본 앱과 유사한 것으로 보이는 것을 주목할 가치가 있으며, 분명히 펄럭이 커뮤니터 내에서 언급 된 문제가되지 않는 것으로 보입니다.

### Platform features
### 플랫폼 기능

Native apps have access to all the features of the platform, otherwise, by definition, they can't be a feature of the platform because they would never be used.
기본 앱은 플랫폼의 모든 기능에 액세스 할 수 있으며, 그렇지 않으면 정의에 따라 플랫폼의 기능이 될 수 없습니다.

Cross-platform solutions such as Flutter generally expose platform features through plugins. We will explore Flutter plugins later in the book, but as a quick overview, many plugins will interact directly with platform features and expose them to the app developer in a platform-agnostic way. In Flutter, there is a vibrant community creating plugins and these can be viewed at the package repository at https://pub.dev.
플러 터스와 같은 크로스 플랫폼 솔루션은 일반적으로 플러그인을 통해 플랫폼 기능을 노출합니다.우리는 뒷부분의 플러스 플러그인을 탐험 할 것입니다. 그러나 빠른 개요는 많은 플러그인이 플랫폼 기능과 직접 상호 작용하고 플랫폼 - 불가지론 방식으로 앱 개발자에게 노출됩니다.Flutter에서는 플러그인을 만드는 활기찬 커뮤니티가 있으며 https://pub.dev에서 패키지 저장소에서 볼 수 있습니다.

### Plugin versus package
### 플러그인 대 패키지


In Flutter, you can add plugins and packages to your project from the package repository. Both plugins and packages are simply a way to share code, but for clarity, a plugin is a special type of package that includes wrappers of native code. You will often use a mix of plugins and packages in your Flutter projects, but the terms "plugin" and "package" are somewhat interchangeable, so don't worry about the difference.
플러터에서 플러그인 및 패키지를 패키지 저장소에서 프로젝트에 추가 할 수 있습니다.플러그인과 패키지는 모두 코드를 공유하는 방법이지만 명확성을 위해 플러그인은 기본 코드 래퍼가 포함 된 특별한 유형의 패키지입니다.플러스 프로젝트에 플러그인과 패키지를 혼합하여 종종 사용할 수 있지만 "플러그인"및 "패키지"라는 용어는 다소 상호 교환 가능하므로 차이점에 대해 걱정하지 마십시오.

However, there will not necessarily be plugins created for every platform feature, or the plugins available may not support the platform that you require. This was true in the early days of Flutter, but is generally not an issue anymore. In this instance, you may need to write your own plugin.
그러나 반드시 모든 플랫폼 기능에 대해 생성 된 플러그인이 없거나 사용 가능한 플러그인이 필요한 플랫폼을 지원하지 않을 수 있습니다.이것은 펄터의 초기에는 사실 이었지만 일반적으로 더 이상 문제가되지 않습니다.이 경우 사용자 자신의 플러그인을 작성해야 할 수 있습니다.

Another consideration is that some platforms offer features that are not available on other platforms. In this case, a plugin may have been created, but will obviously not be platform agnostic. In this instance, you will need to include platform-specific code in your app.
또 다른 고려 사항은 일부 플랫폼이 다른 플랫폼에서 사용할 수없는 기능을 제공한다는 것입니다.이 경우 플러그인이 생성되었지만 분명히 플랫폼 불가지론이 아닙니다.이 경우 앱에 플랫폼 별 코드가 포함되어야합니다.

### Hot reload
### 뜨거운 재 장전

One of the most awesome features of Flutter is hot reload; the ability to make changes to the code and see it instantly update on the device without your state being changed. This is hugely beneficial in software development; anything that reduces the time between code and feedback allows the developer to achieve flow more easily.
펄럭이있는 가장 멋진 특징 중 하나는 뜨거운 재 장전입니다.코드를 변경하고 상태가 변경되지 않은 상태없이 장치에서 즉시 업데이트하는 기능.이것은 소프트웨어 개발에 대단히 유익합니다.코드와 피드백 사이의 시간을 줄이는 것은 개발자가 흐름을보다 쉽게 달성 할 수있게합니다.

Android has a feature that appears similar, called Instant Run. However, under the covers, it works in a quite different way. Instead of using the JIT approach of Flutter, Android studio will compile the changes and then try to update as little as possible on the device. Often this leads to large changes and sometimes a full rebuild of the whole app.
Android에는 인스턴트 실행이라고하는 비슷한 기능이 있습니다.그러나 덮개 아래에서는 아주 다른 방식으로 작동합니다.Flutter의 JIT 방식을 사용하는 대신 Android Studio는 변경 사항을 컴파일 한 다음 장치에서 가능한 한 적게 업데이트하려고합니다.종종 이것은 큰 변화와 때로는 전체 앱의 완전한 재구성을 초래합니다.

iOS development with Swift does not currently have an equivalent to Flutter hot reload. There are ways to preview in XCode without running the full app, but this is obviously much more limited than the Flutter approach.
SWIFT로 IOS 개발에는 현재 Flutter Hot Reload와 동등한 것이 아닙니다.전체 앱을 실행하지 않고 Xcode에서 미리보기하는 방법이 있지만, 이것은 분명히 펄럭이있는 접근법보다 훨씬 제한됩니다.

### User experience
### 사용자 경험

There are certain expectations of design that differ between users of different platforms. For example, many apps have design differences between iOS, Android, and the web. Developing native apps allows you to design your code around these considerations, whereas in cross-platform development, you may need to have platform-specific code.
다양한 플랫폼 사용자간에 다른 디자인에 대한 기대치가 있습니다.예를 들어, 많은 앱은 iOS, Android 및 웹간에 디자인 차이가 있습니다.기본 응용 프로그램을 개발하면 이러한 고려 사항을 다르게 설계 할 수 있지만 플랫폼 간 개발에서는 플랫폼 별 코드가 있어야 할 수 있습니다.

Flutter caters for this to some degree by having platform considerations embedded in the built-in widgets. For example, the back button on the AppBar (the top bar on the app) changes styling depending on the platform.
내장 위젯에 플랫폼 고려 사항이 포함되어있어 어느 정도의 펄럭이 있습니다.예를 들어 AppBar (앱의 상단 표시 줄)의 뒤로 버튼은 플랫폼에 따라 스타일링을 변경합니다.

However, if you want the actual user experience to be different on different platforms (that is, the flow and interactions), then platform-specific code will need to be added. This is relatively pain-free on Flutter (we will see this in later chapters) but can lead to platform-specific bugs, so this must be a consideration.
그러나 실제 사용자 환경을 다른 플랫폼 (즉, 플로우 및 상호 작용)에서 다른 것으로 원한다면 플랫폼 별 코드를 추가해야합니다.이것은 비교적 통증이 없으며 나중 장에서는 이것을 볼 수 있지만 플랫폼 별 버그로 이어질 수 있으므로 고려해야합니다.

### App size
### 앱 크기

A very basic native app can often be less than 1 MB.
매우 기본적인 기본 앱은 종종 1MB 미만일 수 있습니다.

A minimal Flutter app has to hold the core engine (circa 3 MB), framework + app code (circa 1 MB), and other files (circa 1 MB), meaning a basic Flutter app starts at 5 MB.
최소한의 플러터 앱은 코어 엔진 (Circa 3 MB), 프레임 워크 + 응용 프로그램 코드 (Circa 1 MB) 및 기타 파일 (Circa 1 MB)을 유지해야합니다. 즉, 기본 플러터 앱이 5MB에서 시작합니다.

For larger apps, this is unlikely to be an issue because the relative size of the core engine and framework will be relatively smaller, but for very lightweight apps, it should be a consideration.
더 큰 앱의 경우 핵심 엔진과 프레임 워크의 상대적 크기가 상대적으로 작아 지지만 매우 가벼운 앱의 경우 고려해야합니다.

### New platforms
### 새로운 플랫폼

There have been and will probably continue to be attempts to enter the mobile devices market with new platforms. An example of this is Huawei (a prolific mobile device seller), who are attempting to move from the Android platform to their own Harmony platform. Additionally, they are planning to share this platform with other device makers.
새로운 플랫폼으로 모바일 장치 시장에 들어가기 위해 계속해서 지속적으로 시도 할 것입니다.이의 예는 Huawei (Android 플랫폼에서 자신의 하모니 플랫폼으로 이동하려고 시도하고있는 Huawei (Prolic Mobile Device Seller)입니다.또한이 플랫폼을 다른 장치 제조업체와 공유 할 계획입니다.

Creating a development team to develop apps for a new platform can be a hugely expensive risk because the platform may not get much traction and it may be a development dead-end. However, the benefits of getting onto a platform early can be huge because there is likely to be a lack of competition.
플랫폼이 많은 견인력을 얻지 못할 수도 있고 개발 한도 일 수 있으므로 새로운 플랫폼을 개발하는 개발 팀을 개발할 수 있습니다.그러나, 플랫폼에 점점 더 이익을 얻는 것은 경쟁이 부족할 가능성이 있기 때문에 거대 할 수 있습니다.

With a cross-platform framework, if the solution is updated to support the new platform, then it can be incredibly easy to release on the new platform with very little development needed. It hugely reduces the risk of moving to the new platform while keeping the potential upside.
플랫폼 간 프레임 워크를 사용하면 솔루션이 새 플랫폼을 지원하도록 업데이트되면 개발이 거의 거의없는 개발이 거의없는 새 플랫폼에서 쉽게 해제 할 수 있습니다.잠재적 인 상승을 유지하면서 새로운 플랫폼으로 이동할 위험이 거의 감소합니다.

Unfortunately though, if the framework is not updated to support the new platform, then you have no path to move your cross-platform app to the new platform. Note though that in this situation, you are not in a worse position than having native apps; in both scenarios, you would need to create a new app natively for the new platform.
불행히도 프레임 워크가 새 플랫폼을 지원하도록 프레임 워크가 업데이트되지 않으면 크로스 플랫폼 응용 프로그램을 새 플랫폼으로 이동할 경로가 없습니다.참고 이러한 상황에서는 원시 앱보다 더 나쁜 위치에 있지 않습니다.두 시나리오에서 새로운 플랫폼에 대해 기본적으로 새로운 앱을 만들어야합니다.

### Retired platforms
### 은퇴 한 플랫폼입니다

On the flip side, platforms can look promising and then fail. The most notable of these was the Windows Phone by Microsoft, which struggled to get market share due to a lack of apps on its store and was eventually retired when Microsoft changed its priorities.
플립 측면에서 플랫폼은 유망한 채로 보일 수 있으며 실패 할 수 있습니다.이 중에서 가장 주목할만한 것은 Microsoft의 Windows Phone이었습니다. 이는 매장의 앱이 부족하여 Microsoft가 우선 순위를 변경했을 때 결국 은퇴했습니다.

Being locked into a platform as it begins to fail not only impacts the success of the app on that platform, but also leads to complicated political discussions:
플랫폼에 잠긴 플랫폼으로 잠겨 있기 때문에 해당 플랫폼에서 앱의 성공에 영향을 미치지 만 복잡한 정치 토론으로 인도합니다.

- Should we continue to develop on that platform to keep feature parity?
- 기능 패리티를 유지하기 위해 해당 플랫폼에서 계속해서 개발해야합니까?
- Will the platform recover? Constant analysis of the platform sales and market share distracts from product creation.
- 플랫폼이 회복됩니까?플랫폼 판매 및 시장 점유율에 대한 지속적인 분석은 제품 창조에서 산만합니다.
- Should we retire the app from the platform? Will that lose us customers who will eventually move to a platform that we still support?
- 플랫폼에서 앱을 퇴직시켜야합니까?결국 우리가 아직도 지원하는 플랫폼으로 이동할 고객을 잃게 될 것입니까?

With a cross-platform solution, these discussion points become relatively redundant. You can continue to release new versions of your app on the failing platform for a much longer period of time because the features developed will be used for all platforms. There is a requirement to test on the platform, but again this is somewhat alleviated because a lot of the testing will be carried out on other platforms anyway.
크로스 플랫폼 솔루션을 사용하면 이러한 토론 점이 상대적으로 중복됩니다.개발 된 기능이 모든 플랫폼에 사용되므로 실패한 플랫폼에서 새로운 버전의 앱을 실패한 플랫폼에서 계속 해제 할 수 있습니다.플랫폼을 테스트 할 필요가 있지만, 다시 많은 테스트가 다른 플랫폼에서 수행 될 것이기 때문에 다시 가리칩니다.

## Learning from experience 2
## 경험 2에서 배우기 2.

When Windows Phone first arrived, I was keen to release a football (soccer) app into what I believed to be a fast-growing market. I used the native Microsoft framework XNA for the app development and produced SoccerTime. As mentioned previously, there was initially a lack of competitors, so the app grew quickly. Sadly, as we all know, the platform failed, and the lock-in meant I couldn't port to iOS and Android. SoccerTime was no more! Interestingly, it looks like the community converted XNA into a cross-platform solution called Monogame, an interesting twist on the native versus cross-platform debate.
Windows Phone이 처음 도착했을 때, 나는 축구 (축구) 앱을 제가 빠르게 성장하는 시장 인 것으로 믿는 것을 빌려 왔습니다.App Development 및 Soccertime 생산을 위해 Native Microsoft Framework XNA를 사용했습니다.앞에서 언급했듯이 처음에는 경쟁자가 없기 때문에 앱이 빨리 자랐습니다.슬프게도, 우리 모두가 알고 있듯이, 플랫폼이 실패하고 iOS와 Android로 포트 할 수 없었습니다.Soccertime은 더 이상 없었습니다!흥미롭게도, 커뮤니티는 XNA를 원어민 대 크로스 플랫폼 토론에 흥미로운 트위스트 인 Monogame이라는 교차 플랫폼 솔루션으로 변환 한 것처럼 보입니다.

### Overview
### 개요

Let's take a quick recap of the pros and cons of using native over cross-platform.
전문가의 찬반 양식을 신속하게 취급합시다.

Pros:
장점 :

- Performance
- 성능
- Full platform feature access
- 전체 플랫폼 기능 액세스
- Closer alignment with expected user experience
- 예상되는 사용자 경험이있는 더 긴밀한 정렬

Cons:
단점 :

- Multiple code bases
- 여러 코드 기지
- Multiple development teams
- 여러 개발 팀
- Lack of fungibility
- 재료의 부족
- Disparate defect reports
- 다른 결함 보고서
- Feature parity complexities and alignment on product vision
- 패리티 복잡성과 제품 비전에 대한 정렬
- Expense to move to a new platform
- 새로운 플랫폼으로 이동하는 비용
- Complexities of moving off a failing platform
- 실패한 플랫폼을 벗어나는 복잡성
- Different platforms having different features
- 다른 기능을 갖는 다른 플랫폼

Hopefully, you are sold on the idea of developing cross-platform but now understand the considerations. So what alternatives are there to Flutter?
바라건대, 당신은 크로스 플랫폼을 개발하는 아이디어에 대해 판매되었지만 이제는 고려 사항을 이해합니다.그래서 어떤 대안이 펄럭이는 것입니까?

# Cross-platform frameworks
# 크로스 플랫폼 프레임 워크

Let's look at a few alternative frameworks. There are quite a few options, but many are based around three core approaches: React Native, Cordova, and Xamarin.
몇 가지 대체 프레임 워크를 살펴 보겠습니다.꽤 몇 가지 옵션이 있지만 많은 사람들이 3 가지 핵심 접근 방식을 기반으로합니다 : 원주민, Cordova 및 Xamarin.

## React Native
## Native를 반응합니다
The most common cross-platform framework before Flutter was released was React Native. Like Flutter, React Native is open source, and like Flutter, it is backed by a big software development company in the form of Facebook:
펄럭이가 출시되기 전에 가장 일반적인 크로스 플랫폼 프레임 워크는 반응 원주민이었습니다.펄럭이고, 반응 네이티브는 오픈 소스이며, 펄럭이며, Facebook의 형태로 큰 소프트웨어 개발 회사가 뒷받침합니다.

![Figure 3.2 - React Native logo ](/flutter4beginners2_img/figure_3.2_-_react_native_logo.jpg)
! [그림 3.2 - 네이티브 로고 반응] (/ flutter4beginners2_img / figure_3.2 _-_ react_native_logo.jpg)

It is a popular framework mainly because it reuses the technologies and methodologies of the React web framework. There is a very healthy React Native community that takes the framework forward and produces plugins for the different platforms. Also, given the greater maturity of the framework, there is likely to be a greater wealth of plugin support and documentation available.
대응 웹 프레임 워크의 기술 및 방법론을 재사용하기 때문에 주로 인기있는 프레임 워크입니다.프레임 워크를 앞으로 전달하고 다른 플랫폼의 플러그인을 생성하는 매우 건강한 react 네이티브 커뮤니티가 있습니다.또한 프레임 워크의 더 큰 성숙도가 주어지면 더 큰 풍부한 플러그인 지원 및 문서화가 가능합니다.

Technology wise, React Native uses JavaScript for the general app look and feel, and then Java or Swift to write native modules for the more complex features such as image editing. The motto of the framework is "Learn once, write anywhere," unlike the Flutter vision of writing once and running everywhere. This is because the native modules are not reusable across the platforms, leading to different code bases.
Technology Wise, React Native는 일반적인 앱 모양과 느낌을 위해 JavaScript를 사용하고 Java 또는 Swift를 사용하여 이미지 편집과 같은보다 복잡한 기능을위한 기본 모듈을 작성합니다.프레임 워크의 모토는 "한 번 쓰기의 펄럭이고 어디에서나 도처를주는 것과는 달리 배우고, 어디서나 쓰기"입니다.이는 기본 모듈이 플랫폼에서 재사용 할 수 없으므로 다른 코드 기반이 발생하기 때문입니다.

Like Flutter, React Native has hot reloading, allowing fast development and iterations of app code.
Flutter와 마찬가지로 Appt Native는 핫 리디딩을 가지고 있으며 빠른 개발 및 앱 코드의 반복을 허용합니다.

Performance wise, the general view seems to be that React Native is slower than Flutter. There are many reasons for this, but the fact that Flutter is compiled to native libraries whereas React Native has a JavaScript layer seems to be a key contributor. However, with such a variety of app designs, it is hard to make anything other than generalizations.
성능 현명, 일반적인 견해는 반응 네이티브가 펄럭이는 것보다 느리게하는 것으로 보인다.이는 많은 이유가 있지만, 플러터가 네이티브 라이브러리로 컴파일되는 것은 반응 원주민이 JavaScript 레이어가 주요 기여자 인 것 같습니다.그러나 이러한 다양한 앱 디자인으로 일반화 된 것 외에는 다른 것을 만들기가 어렵습니다.

Interestingly, in the 2020 Stack Overflow survey, React Native was noted as the 10th most dreaded framework, yet Flutter was noted as the third most loved framework. Enjoyment of coding is a huge aspect of productivity, so this is an important aspect to take into account.
흥미롭게도 2020 개의 스택 오버 플로우 조사에서 반응 네이티브는 10 번째 가장 두려운 프레임 워크로 표시되었지만, 펄럭이는 세 번째로 사랑하는 프레임 워크로 표시되었습니다.코딩의 즐거움은 생산성의 거대한 측면이므로 이것이 중요한 측면입니다.

### Moving to Flutter from React Native
### React Nativent에서 펄럭이는 것으로 이동합니다

Flutter uses reactive-style views, with widgets being comparable to React components. This similarity makes it relatively easy for a React Native (or general web React) developer to understand the state, build, and setState aspects of Flutter.
Flutter는 반응 구성 요소와 비교할 수있는 반응식 스타일의 뷰를 사용합니다.이러한 유사성은 펄럭이의 상태, 빌드 및 설정된 측면을 알리기 위해 리스토브 (또는 일반 웹 반응) 개발자가 상대적으로 쉽게 쉽게 쉽게 할 수 있습니다.

Some key language differences between JavaScript and Dart, the programming language used by Flutter, are the following:
JavaScript와 DART 간의 주요 언어 차이점, 펄터가 사용하는 프로그래밍 언어는 다음과 같습니다.

Variables: Unlike JavaScript, Dart is a type-safe language, so variables must be declared with a type or the type system can infer the type.
변수 : JavaScript와 달리 DART는 유형 안전 언어이므로 변수를 유형으로 선언해야하거나 유형 시스템이 유형을 추론 할 수 있습니다.
Dart has no concept of undefined. Either a variable has a value or it is null.
다트는 정의되지 않은 개념이 없습니다.변수에는 값이 있거나 null입니다.
Dart has no concept of truthy. Only the Boolean value of true is treated as a true value.
다트는 진리의 개념이 없습니다.TRUE의 부울 값만이 진정한 값으로 처리됩니다.
The JavaScript Promise is represented by the Dart Future object. The async and await operators act on Futures like they do on Promises in JavaScript.
JavaScript 약속은 DART Future Object가 대표합니다.비동기와 기다리고있는 운영자는 JavaScript에서 약속에있는 것처럼 선물에 관한 것입니다.
Printing to the console uses the print() method instead of console.log().
콘솔에 인쇄하는 것은 console.log () 대신 print () 메소드를 사용합니다.
For more details, the Flutter documentation gives a great overview of transitioning from React Native to Flutter: https://flutter.dev/docs/get-started/flutter-for/react-native-devs.
자세한 내용은 플러터 문서에서는 React Native에서 Flutter까지의 전환에 대한 훌륭한 개요를 제공합니다. https://flutter.dev/docs/get-started/flutter-for/react-native-devs.

## Xamarin
## 접이식

Much like React and Flutter, Xamarin is open source and backed by a big technology company, in this case Microsoft:
반응과 펄럭이며, Xamarin은 오픈 소스이며 대형 기술 회사가 뒷받침합니다.이 경우 Microsoft :

![Figure 3.3 - Xamarin logo ](/flutter4beginners2_img/figure_3.3_-_xamarin_logo.jpg)
! [그림 3.3 - hardrin logo] (/ flotter4beginners2_imm / fige_3.3 _

Xamarin uses .NET technologies and the C# programming language. When using Xamarin Native, you get all the performance benefits of native apps, but the user interface code is platform specific, so roughly 75% of the code base is shared. This means knowledge of native languages is required in addition to Xamarin.
Xamarin은 .NET Technologies 및 C # 프로그래밍 언어를 사용합니다.Xamarin Native를 사용하는 경우 기본 앱의 모든 성능 이점을 얻을 수 있지만 사용자 인터페이스 코드는 플랫폼 특정이므로 코드 기반의 약 75 %가 공유됩니다.이는 Xamarin 외에도 네모 언어에 대한 지식이 필요합니다.

With Xamarin.Forms, a separate product that replaces the platform-specific user interface code, code sharing can be increased. However, note that Xamarin.Forms is being retired soon and replaced with the Multi-platform App UI (MAUI).
xamarin.forms에서는 플랫폼 별 사용자 인터페이스 코드를 대체하는 별도의 제품을 사용하여 코드 공유를 늘릴 수 있습니다.그러나 xamarin.forms는 곧 퇴직되고 다중 플랫폼 App UI (마우이)로 대체됩니다.

Like React Native and Flutter, Xamarin supports hot reloading to allow faster rebuild and testing.
Xamarin은 react 네이티브와 펄럭이며, Xamarin은 더 빠른 재구성 및 테스트를 허용하기 위해 핫 리 업을 지원합니다.

Considerations for the Xamarin approach are that the licenses can be expensive, especially for an enterprise. Additionally, the Xamarin community is much smaller than the React Native and Flutter communities, which can restrict available developers and also community support.
Xamarin 접근법에 대한 고려 사항은 라이센스가 특히 기업의 경우 비용이 많이 드는 것입니다.또한 Xamarin 공동체는 사용 가능한 개발자와 지역 사회 지원을 제한 할 수있는 반응 원주민 및 플러터 커뮤니티보다 훨씬 작습니다.

### Moving to Flutter from Xamarin.Forms
### Xamarin.Forms에서 펄럭이로 이동합니다

The Xamarin.Forms Page concept is similar to the Route concept in Flutter. So a Route will lead from one Page to another Page.
xamarin.forms 페이지 개념은 펄터의 경로 개념과 유사합니다.따라서 경로가 한 페이지에서 다른 페이지로 이어질 것입니다.

However, the key difference is that everything is a widget in Flutter. So, whereas a ContentPage will contain elements such as Entry or Button, in Flutter, the page is a widget that contains nested widgets. One of the nested widgets may draw an input field or a button.
그러나 핵심 차이점은 모든 것이 펄럭이의 위젯이기 때문입니다.따라서 ContentPage에는 항목 또는 버튼과 같은 요소가 포함될 수 있지만 Page는 중첩 된 위젯을 포함하는 위젯입니다.중첩 된 위젯 중 하나는 입력 필드 또는 버튼을 그릴 수 있습니다.

Again, the Flutter documentation does a great job of explaining how to migrate to Flutter: https://flutter.dev/docs/get-started/flutter-for/xamarin-forms-devs.
다시 말하지만, 플러터 문서는 펄럭이있는 방법을 설명하는 훌륭한 작업을 수행합니다. https://flutter.dev/docs/get-started/flutter-for/xamarin-forms-devs.

## Cordova
## Cordova.

Apache Cordova takes the web technologies of HTML, CSS, and JavaScript and allows them to run on mobile apps. Formerly PhoneGap, Cordova is itself more of a platform that allows frameworks to run within it, such as Ionic:
Apache Cordova는 HTML, CSS 및 JavaScript의 웹 기술을 사용하며 모바일 앱에서 실행할 수 있습니다.이전의 Phongap, Cordova는 Ionic과 같은 프레임 워크를 실행할 수있는 플랫폼의 더 많은 것입니다.

![Figure 3.4 - Apache Cordova logo ](/flutter4beginners2_img/figure_3.4_-_apache_cordova_logo.jpg)
! [그림 3.4 - Apache Cordova 로고] (/ flutter4beginners2_img / figure_3.4 _-_ apache_cordova_logo.jpg)

Effectively, the Cordova app runs within a WebView, which is like a built-in browser for each platform. This means that, unlike React Native and Xamarin, all the code is cross-platform. However, a major issue is that the WebView implementations for different platforms can be subtly different, leading to inconsistencies and bugs in the user interface.
효과적으로 Cordova 앱은 각 플랫폼에 대해 내장 브라우저와 같는 WebView 내에서 실행됩니다.즉, 대응 원주민 및 Xamarin과 달리 모든 코드는 크로스 플랫폼입니다.그러나 주요 문제는 다른 플랫폼의 WebView 구현이 미소적으로 다를 수 있으므로 사용자 인터페이스의 불일치 및 버그가 발생할 수 있다는 것입니다.

Additionally, depending on WebView performance, the app can run slowly, especially on graphic-intense apps. As an added complication, the WebView can be different on different versions of the platform, so performance and user interfaces can be different on different versions of the platform. This can be especially true on the Android platform.
또한 WebView 성능에 따라 앱은 특히 그래픽 인센스 앱에서 천천히 실행될 수 있습니다.추가 된 합병증으로, WebView는 다른 버전의 플랫폼에서 다를 수 있으므로 성능 및 사용자 인터페이스는 다양한 버전의 플랫폼에서 다를 수 있습니다.이것은 Android 플랫폼에서 특히 그렇습니다.

### Moving to Flutter from Cordova
### Cordova에서 펄럭이는 것으로 이동합니다

One key difference you will notice immediately is that Flutter styling is embedded within the widget, rather than declared in a separate style document like CSS.
하나의 핵심 차이점은 즉각적으로 Flutter Styling이 CSS와 같은 별도의 스타일 문서로 선언 된 대신 위젯 내에 임베드된다는 것입니다.

This has many benefits, a main one being the mental load that is put on the developer is hugely reduced as there is one less language to contend with.
이것은 많은 이점을 가지고 있으며, 주요 언어가 하나의 언어가있는 것으로서 개발자에 넣은 정신적 부하가되는 주요 부하가 크게 줄어들 것입니다.

The layout of widgets does not quite match the expectations of web developers. The number of times I've caused overflows because I've reverted to the web layout way of thinking is painful.
위젯의 레이아웃은 웹 개발자의 기대치와 일치하지 않습니다.내가 웹 레이아웃 방식으로 되돌아 갔기 때문에 오버플로 만든 횟수는 고통 스럽습니다.

Again, there is excellent documentation on the Flutter site to guide you through the differences: https://flutter.dev/docs/get-started/flutter-for/web-devs.
다시 말하지만, HTTPS://FLUNTER.DEV/DOCS/GET-STARTED/FLUNTER-FOR/WEB-DEVS의 차이를 안내하기 위해 펄럭이 사이트에 탁월한 문서가 있습니다.

## Popularity
## 인기

When choosing a framework, it is important to know the popularity so that you can assess whether the framework will have long-term support.
프레임 워크를 선택할 때 프레임 워크가 장기간 지원을 가질 것인지 여부를 평가할 수 있도록 인기를 아는 것이 중요합니다.

A common way to assess popularity is to look at the Stack Overflow trends report. This shows how many Stack Overflow questions were asked about a specific framework:
인기를 평가하는 일반적인 방법은 스택 오버 플로우 트렌드 보고서를 보는 것입니다.이것은 특정 프레임 워크에 대해 얼마나 많은 스택 오버 플로우 질문을 묻는 수를 보여줍니다.

![Figure 3.5 - Stack Overflow trend report ](/flutter4beginners2_img/figure_3.5_-_stack_overflow_trend_report.jpg)
! [그림 3.5 - 스택 오버 플로우 트렌드 보고서] (/ flutter4beginners2_img / figure_3.5 _-_ stack_overflow_trend_report.jpg)

A simple comparison of the frameworks mentioned previously shows the following:
앞에서 언급 한 프레임 워크를 간단히 비교하면 다음을 보여줍니다.

- Questions about the older frameworks of Cordova and Xamarin are reducing slowly.
- Cordova와 Xamarin의 이전 프레임 워크에 대한 질문은 천천히 감소하고 있습니다.
- React Native and Flutter are seeing fast growth in questions asked.
- 반응 네이티브와 펄튼은 질문의 빠른 성장을보고 있습니다.
- Flutter has become the most popular framework to ask about, especially since Flutter 1.0 was released in 2018.
- Flutter는 특히 2018 년에 Flutter 1.0이 발표 된 이후로 묻는 가장 인기있는 프레임 워크가되었습니다.

It can be argued that fewer questions need to be asked about the older frameworks because they have already been asked, so feel free to interpret the chart as you wish, but it clearly shows that there is currently a lot of interest in Flutter.
이전 프레임 워크에 대해 이미 묻는 질문을 받아야 할 필요가 없으므로 차트를 원하는대로 해석 할 수 있으므로 더 많은 질문이 필요합니다.

Stack Overflow is a great resource, but a framework not only needs a healthy set of Stack Overflow questions for it to grow and develop; it also needs a strong community.
스택 오버 플로우는 훌륭한 자원이지만 프레임 워크는 성장 및 개발을 위해 건강한 스택 오버플로 질문 집합을 필요로 할뿐만 아니라;또한 강한 공동체가 필요합니다.

# Flutter community
# flutter 커뮤니티

Flutter has a vibrant community, which is key to the long-term success of any software project that relies on community contributions. Google is very active in this, involving Flutter in conferences and organizing Flutter events.
Flutter는 커뮤니티 공헌에 의존하는 소프트웨어 프로젝트의 장기적인 성공의 열쇠 인 활기찬 커뮤니티를 가지고 있습니다.Google은 컨퍼런스에 펄럭이며 펄럭이있는 이벤트를 조직하는이 기능에서 매우 적극적입니다.

## Events
## 이벤트

Flutter Engage is an event dedicated to the Flutter framework. It shares best practices, new developments, feature overviews, and the chance to interact with Flutter experts.
Flutter Engage는 플러터 프레임 워크 전용 이벤트입니다.그것은 모범 사례, 새로운 개발, 기능 개요 및 플러터 전문가와 상호 작용할 수있는 기회를 공유합니다.

The first Flutter Engage took place on March 3, 2021 and introduced a whole raft of new Flutter features, including Flutter 2.0, dual-display widgets from Microsoft, first-class Google AdMob integration, and tooling to help with Flutter migration to newer versions, among many other features and bug fixes. Flutter 2.0 also introduced full support for the web platform, which was previously a beta release. In addition, stability on all desktop platforms was announced, which led to an announcement from Canonical, publisher of Linux distribution Ubuntu, that "Flutter is the default choice for future mobile and desktop apps created by Canonical."
첫 번째 플러터 교육은 3 월 3 일, 2021 년 3 월 3 일에 일어 났으며 Microsoft 2.0, Microsoft의 듀얼 디스플레이 위젯, Microsoft, 일류 Google Admob 통합 및 최신 버전으로의 마이그레이션을 돕는 툴링을 도입했습니다.다른 많은 기능과 버그 수정.Flutter 2.0은 이전에 베타 릴리스 인 웹 플랫폼에 대한 전체 지원을 도입했습니다.또한 모든 데스크탑 플랫폼의 안정성이 발표되었으므로 Linux 배포 Ubuntu의 Publisher의 공표가 이어졌습니다.

Google I/O, a general Google event for developers, often features Flutter talks. It is useful to attend these as not only can you learn about the new features being developed, you can also get a feel for the strategic direction of the project. It was at Google I/O that an early preview of project Hummingbird, the move of Flutter to the web, was shown.
개발자를위한 일반 Google 이벤트 인 Google I / O는 종종 펄터 대화를 특징으로합니다.개발중인 새로운 기능에 대해 배울뿐만 아니라 프로젝트의 전략적 방향에 대한 느낌을 얻을 수도 있습니다.Google I / O는 Project Hummingbird의 초기 미리 미리 미리보기, 웹에 대한 펄럭스의 움직임이 나타났습니다.

There are regular meetups around the world where groups will discuss the latest Flutter technology, share their learning, and help newcomers join the Flutter bandwagon. It is worth noting that Flutter communities are not just English speaking, with great communities such as Flutterando in Brazil (with over 8,000 members) allowing you to have Flutter meetups in your native tongue. Check out the https://meetup.com site to find a meetup near you.
그룹이 최신 플러터 기술을 논의하고 학습을 공유하며 신규 이민자가 펄럭 이는 대회에 가입하도록 돕는 전 세계의 정기적 인 모임이 있습니다.펄터 커뮤니티는 브라질의 Flutterando와 같은 위대한 공동체 (8,000 명이 넘는 회원가있는)와 같은 위대한 지역 사회가 모국어에 펄럭이있는 공동체가 아닙니다.Https://meetup.com 사이트를 체크 아웃하여 근처의 모임을 찾으십시오.

## News and discussion
## 뉴스 및 토론

The Flutter Google group is a great place to raise questions and discuss issues. It is a very active group, generally with answers given within hours of questions being asked: https://groups.google.com/g/flutter-dev.
Flutter Google 그룹은 질문을 제기하고 문제를 토론하는 훌륭한 장소입니다.매우 적극적인 그룹으로, 일반적으로 묻는 질문이 묻는 답변을 가지고 있습니다. https://groups.google.com/g/flutter-dev.

An alternative when having issues is to head to Stack Overflow for assistance. Many of the issues you encounter will have already been answered on there, and if not then it is very easy to ask your own question.
문제가있는 경우에는 도움을받을 수있는 것입니다.당신이 만난 당신이 만나는 많은 문제들이 이미 거기에 답변 해 왔고 그렇지 않다면 자신의 질문을하는 것은 매우 쉽습니다.

Two excellent email subscriptions will give you a weekly update on all things Flutter:
두 가지 우수한 이메일 구독은 모든 일에 매주 업데이트를 제공합니다.

- Flutter Weekly provides links to useful libraries, code examples, and highlights future events. Subscribe at https://flutterweekly.net/.
- Flutter는 유용한 라이브러리에 대한 링크, 코드 예제 및 미래의 이벤트를 강조 표시합니다.https://flutterweekly.net/에서 구독하십시오.
- Flutter Tap gives more general news and event updates, alongside tutorial videos and useful packages. Subscribe at https://fluttertap.com/.
- Flutter Tap은 자습서 비디오 및 유용한 패키지와 함께 일반적인 뉴스 및 이벤트 업데이트를 제공합니다.https://fluttertap.com/에서 구독하십시오.

## Resources
## 자원

All of the Flutter code is on GitHub. You can view code here, track defects, and follow new releases. The main repository is at https://github.com/flutter/flutter, but all plugins will have their own repositories and issue tracking as well.
모든 플러터 코드는 GitHub에 있습니다.여기서 코드를 볼 수 있고, 결함을 추적하고, 새 릴리스를 따르십시오.주요 저장소는 https://github.com/flutter/flutter입니다. 그러나 모든 플러그인은 자체 리포지토리 및 문제 추적을 가질 것입니다.

All of the plugins/packages created for Flutter and Dart are listed on the https://pub.dev/ site. The site includes a powerful search that will list all the plugins and packages that are relevant. Importantly, the vitality of plugins and packages is reported through a series of metrics, allowing you to find the best plugin or package for your project:
플러터 및 다트 용으로 생성 된 모든 플러그인 / 패키지는 https://pub.dev/ 사이트에 나열되어 있습니다.이 사이트에는 관련이있는 모든 플러그인과 패키지가 나열되는 강력한 검색이 포함되어 있습니다.중요한 것은 플러그인과 패키지의 활력이 일련의 메트릭을 통해보고되므로 프로젝트를위한 최고의 플러그인이나 패키지를 찾을 수 있습니다.

![Figure 3.6 - Example pub.dev search ](/flutter4beginners2_img/figure_3.6_-_example_pub.dev_search.jpg)
! [그림 3.6 - 예제 pub.dev 검색] (/ flutter4beginners2_img / figure_3.6 _-_ example_pub.dev_search.jpg)

As you can see in the example, a search for apple sign in returns at least three options. Deciding between them used to be complicated, but now the likes, pub points (how well the project adheres to the standards such as documentation, code style, and platform support), and popularity help you get a feel for which plugin might have the best longevity and support.
이 예에서 볼 수 있듯이 Apple 로그인 검색은 적어도 세 가지 옵션을 반환합니다.그들 사이를 결정하는 것은 복잡했지만 이제는 좋아하는 것들 (프로젝트가 문서화, 코드 스타일 및 플랫폼 지원과 같은 표준을 어떻게 준수), 플러그인을 가장 잘 가질 수있는 느낌을 얻는 데 도움이됩니다.장수와 지원.

The main Flutter website holds huge amounts of documentation, including the latest links to the community and news of events. I strongly suggest you take a look around the site to see what is available: https://flutter.dev/.
메인 플러터 웹 사이트는 지역 사회와 이벤트 뉴스에 대한 최신 링크를 포함하여 엄청난 양의 문서를 보유하고 있습니다.나는 당신이 사이트를 둘러 볼 수 있도록 사이트를 둘러 보면서, https://flutter.dev/을 알 수 있습니다.

So, Flutter has a vibrant community that is helping drive the framework forward and make it even better. Let's bring together the key parts of this chapter from the point of view of Flutter itself.
그래서, 펄터는 프레임 워크를 앞으로 운전하고 더 잘 만들어 낼 수있는 활기찬 커뮤니티를 가지고 있습니다.이 장의 핵심 부분을 펄럭임 자체의 관점에서 모으는 것입니다.

# Flutter strengths and weaknesses
# 펄럭이며 강점과 약점

So, we've had a look at the other options available to you for your mobile project, and looked at the vitality of the Flutter community. This book is not designed to brainwash you into thinking Flutter is the best option (though it probably is), but given the context of the technology landscape, let's recap the strengths and weaknesses of Flutter so that you can make an informed decision.
그래서 우리는 귀하의 모바일 프로젝트를 위해 귀하가 이용할 수있는 다른 옵션을 살펴보고 펄럭이 커뮤니터의 활력을 보았습니다.이 책은 당신을 사고로 생각하기 위해 당신을 세뇌하기 위해 디자인되지 않았습니다.

## Strengths
## 강점

The following are some of the strengths of Flutter:
다음은 펄터의 강점의 일부입니다.

- Hot reload: Flutter has the best hot reload functionality (equal to React Native and Xamarin), and this is a huge productivity benefit.
- Hot Reload : Flutter는 최상의 핫 리디로드 기능 (원주민 및 Xamarin을 반응하는 것과 동일)이며, 이것은 많은 생산성 혜택입니다.
- Single code base: Of all the options available, only a couple (Flutter and Cordova) truly have a single code base that will work across platforms. As discussed, this helps hugely with project management, defect resolution, and new platforms becoming relevant or old platforms being retired.
- 단일 코드베이스 : 사용 가능한 모든 옵션 중 하나만 (Flutter and Cordova)만이 진정으로 플랫폼간에 작동하는 단일 코드베이스가 있습니다.논의 된 바와 같이, 이것은 프로젝트 관리, 결함 해결 및 새로운 플랫폼이 퇴직되거나 폐지되는 신규 플랫폼으로 대단히 도움이됩니다.
- Project vitality: Flutter has a very active community with a huge range of community plugins, easy ways to ask questions, and the most activity on Stack Overflow. If this was a concern, it should have been mitigated somewhat by our exploration of the community.
- 프로젝트 활력 : Flutter는 엄청난 범위의 커뮤니티 플러그인, 질문을하는 쉬운 방법 및 스택 오버플로에서 가장 활동하는 쉬운 방법으로 매우 적극적인 커뮤니티를 보유하고 있습니다.이것이 우려 였다면, 그것은 지역 사회 탐구에 의해 다소 완화되어야했습니다.

- Performance: Dart compiling to native and the lack of a software bridge ensure that Flutter, if not as performant as native, is more than sufficient for apps.
- 성능 : DART to Native 및 소프트웨어 브리지 부족 부족은 출력자가 원시적으로 수행되지 않는 경우 앱에 충분하지 않도록합니다.
- Documentation: The documentation on Flutter is excellent. Compared to some other cross-platform frameworks, the Google team, and the plugin writers, have worked hard to ensure that Flutter is very well documented.
- 문서 : 펄럭에 대한 문서가 우수합니다.다른 교차 플랫폼 프레임 워크, Google 팀 및 플러그인 작성자와 비교하여 펄럭이 매우 잘 설명되어 있는지 확인하기 위해 열심히 노력해 왔습니다.

## Weaknesses
## 약점

The following are some of the weaknesses of Flutter:
다음은 Flutter의 약점 중 일부입니다.

- New framework: Flutter is relatively new and although that means it can learn from what has come before, it also means that there are lots of changes that can impact backward compatibility. This means developers often need to migrate their code to cope with the changes, sometimes holding up new releases.Flutter migration examplesA big Flutter change was the introduction of null safety to the language. Null safety had to be introduced to Dart and Flutter carefully as it required migration of code, and it made sense to work on dependencies, such as plugins, before developers migrated their app code. Another example is that Flutter widgets regularly get deprecated and replaced to improve consistency in the framework; for example, FlatButton became TextButton and RaisedButton became ElevatedButton.
- 새로운 프레임 워크 : 펄럭스는 비교적 새로운 것이며 이전에 오는 것에서 배울 수 있음을 의미하지만, 또한 역 호환성에 영향을 줄 수있는 많은 변경 사항이 있음을 의미합니다.즉, 개발자는 종종 변경 사항에 대처하기 위해 코드를 마이그레이션 할 필요가 있으며 때로는 새로운 릴리스를 잡고 때로는 새로운 릴리스를 들고 있습니다. Flutter Migration radkica 큰 펄럭이 변경된 것은 언어에 대한 널 안전의 도입이었습니다.NULL Safety는 다트에 도입되어 코드를 이주해야하므로 신중하게 펄럭이며 개발자가 자신의 응용 프로그램 코드를 이주하기 전에 플러그인과 같은 종속성에 대해 작업하는 것이 좋습니다.또 다른 예는 파재 위젯이 정기적으로 더 이상 사용되지 않고 프레임 워크의 일관성을 높이기 위해 교체된다는 것입니다.예를 들어, Flatbutton은 TextButton이되었고 RaudedButton이 elevatedbutton이되었습니다.
- App size: As mentioned in the native discussion, a minimal Flutter app is already 5 MB. This is comparable with other cross-platform frameworks, but significantly bigger than native apps.
- 앱 크기 : 기본 토론에서 언급했듯이 최소한의 플러터 앱은 이미 5MB입니다.이것은 다른 교차 플랫폼 프레임 워크와 유사하지만 기본 앱보다 훨씬 큽니다.

# Summary
# 요약

In this chapter, we looked at how Flutter compares to other mobile app development options. Initially, we explored native development options and using them versus general cross-platform solutions. We saw many of the advantages and disadvantages of the native approach.
이 장에서는 우리는 다른 모바일 앱 개발 옵션과 비교되는 방법을 살펴 보았습니다.처음에는 기본 개발 옵션을 연구하고 일반적인 크로스 플랫폼 솔루션을 사용했습니다.우리는 네이티브 접근법의 장점과 단점을 많이 보았습니다.

We then looked at some common cross-platform frameworks and how they compare to Flutter. We saw that although they are trying to solve the same problem, they are doing so in different ways, leading to different trade-offs against the other options.
우리는 몇 가지 일반적인 크로스 플랫폼 프레임 워크를보고 펄럭이와 비교하는 방법을 보았습니다.우리는 동일한 문제를 해결하려고 노력하고 있지만 다른 옵션에 대해 다른 절충을 유도하는 다른 방법으로 이렇게 다른 방법으로 이루어지고 있습니다.

Next we explored the Flutter community and highlighted some useful resources. This helped us to understand that the Flutter community is very active, which is a huge positive for the future of Flutter.
다음으로 우리는 펄터 커뮤니터를 탐험하고 유용한 자원을 강조했습니다.이것은 우리가 펄럭이 커뮤니티가 매우 적극적이라는 것을 이해하는 데 도움이되었습니다. 이것은 펄럭임의 미래에 대해 엄청난 양의 긍정적입니다.

One of the key aspects of the community is the plugins that are created. We will explore these further in later chapters.
커뮤니티의 핵심 측면 중 하나는 생성 된 플러그인입니다.우리는 나중 장에서 이것을 더 탐색 할 것입니다.

You should now start to see why Flutter is so awesome, and why it is fast becoming one of the main development options for new app projects.
이제는 펄치가 너무 멋지 며 왜 새로운 앱 프로젝트의 주요 개발 옵션 중 하나가되는 이유가 무엇인지 확인해야합니다.

In the next chapter, you will have a proper play with Flutter, building on the Hello World! app you started in Chapter 2, An Introduction to Dart. We will particularly focus on widgets and how to use them to create your user interface.
다음 장에서는 안녕하세요 세계에서 펄럭이며 펄럭이가있는 적절한 놀이를 할 것입니다!DART 소개 인 2 장에서 시작한 앱.우리는 특히 위젯에 중점을두고 사용자 인터페이스를 만드는 방법에 중점을 둡니다.

