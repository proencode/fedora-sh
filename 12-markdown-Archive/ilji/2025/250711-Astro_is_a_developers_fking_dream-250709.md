
# Astro is a developers f***ing dream
July 9, 2025 5 min read

After migrating several projects from WordPress to Astro, I've become a massive fan of this framework.

## What is Astro?

Astro is a web framework that came out in 2021 and immediately felt different. While most JavaScript frameworks started with building complex applications and then tried to adapt to simpler sites, Astro went the opposite direction. It was built from day one for content-focused websites.

The philosophy is refreshingly simple. Astro believes in being content-driven and server-first, shipping zero JavaScript by default (yes, really), while still being easy to use with excellent tooling. It's like someone finally asked, "What if we built a framework specifically for the types of websites most of us actually make?"

## Island architecture

Astro introduced something called "Island Architecture," and once you understand it, you'll wonder why we've been doing things any other way.

Traditional frameworks hydrate entire pages with JavaScript. Even if you've got a simple blog post with one interactive widget, the whole page gets the JavaScript treatment. Astro flips this on its head. Your pages are static HTML by default, and only the bits that need interactivity become JavaScript "islands."

Picture a blog post with thousands of words of content. In Astro, all that text stays as pure HTML. Only your comment section or image carousel loads JavaScript. Everything else remains lightning fast. It's brilliantly simple.

## Real performance, real impact

Astro sites are fast, we're talking 40% faster load times compared to traditional React frameworks. But here's the thing, this isn't just about impressing other developers. These performance gains translate directly to better search rankings, happier users, and yes, more conversions. On slower devices or dodgy mobile connections, the difference is even more dramatic.

## Developer experience that actually delivers

The developer experience in Astro feels like someone actually thought about how we work. Setting up a new project is straightforward, and you're guided through the process by Houston, their friendly setup assistant.

### Components without the complexity

What I love most about Astro components is how they just make sense:
```
---
// This runs at build time
const { title } = Astro.props;
const posts = await fetchPosts();
---

<main>
  <h1>{title}</h1>
  {posts.map(post => (
    <article>
      <h2>{post.title}</h2>
      <p>{post.excerpt}</p>
    </article>
  ))}
</main>

<style>
  main {
    max-width: 800px;
    margin: 0 auto;
  }
</style>
```

See that frontmatter at the top? That’s where all your server-side logic lives - it runs at build time, not in the browser. Your data fetching, your logic, even your API calls all happen before the user ever loads the page.

Other frameworks like Next.js or SvelteKit offer similar patterns, but what makes Astro stand out is how clear and deliberate the separation is. There’s no need to think about hooks, state management, or lifecycle methods unless you want client-side interactivity.

### Use any framework (or none)

With Astro you're not locked into a single way of doing things. Need React for a complex form? Chuck it in. Prefer Vue for data visualisation? Go for it. Want to keep most things as simple Astro components? Perfect.

Astro allows you to use React for the admin dashboard components, Vue for some interactive charts, and keep everything else as vanilla Astro. It all just works together seamlessly.

## Features that just work

Markdown support in Astro isn't bolted on as an afterthought. You can import Markdown files directly and use them like components:
```
---
import { Content, frontmatter } from "../content/post.md";
---
<article>
  <h1>{frontmatter.title}</h1>
  <Content />
</article>
```

The build pipeline is modern and complete. TypeScript works out of the box, Sass compilation is built in, images get optimised automatically with Astro's <Image /> tag, and you get hot module replacement during development. No setting up Webpack configs or fighting with build tools.

You also get flexibility in how pages are rendered. Build everything statically for maximum speed, render on the server for dynamic content, or mix both approaches in the same project. Astro adapts to what you need.

## Where Astro really shines

I've found Astro perfect for marketing sites, blogs, e-commerce catalogues, and portfolio sites. Basically, anywhere content is the hero and you don't need complex client-side state management, Astro excels.

## The trade-offs

Astro isn't the answer to everything. If you're building a complex single-page application (SPA) with lots of client-side routing, need ISR, or you need heavy state management across components, you'll probably want something else like Next.js.

The ecosystem is growing but still very small in comparison to something like Next.js. File-based routing can feel constraining on larger projects (though some people love it).

## Quick start

Getting started is genuinely simple:
```
# Create project
npm create astro@latest my-site
cd my-site

# Add a framework if you want
npx astro add react

# Start developing
npm run dev
```

Put your pages in src/pages/, components in src/components/, and you're ready to build something great.

## Why Astro matters

After years of JavaScript frameworks getting more complex, Astro feels like a breath of fresh air. It's a return to the fundamentals of the web - fast, accessible, content-first experiences - but with all the modern developer conveniences we've come to expect.

What struck me most after migrating several projects is how Astro makes the right thing the easy thing. Want a fast site? That's the default. Want to add interactivity? Easy, but only where you need it. Want to use your favourite framework? Go ahead, Astro won't judge.

If you're building anything content-focused, from a simple blog to a full e-commerce site, give Astro a serious look. Your users will get a faster experience, you'll enjoy the development process, and your Core Web Vitals will be spectacular.

Note - The website you're reading this blog from is built with Astro.

© 2011 - 2025 Websmith Studio.
Perth, Western Australia 11:13 am

# 아스트로는 꿈을 꾸는 개발자입니다
2025년 7월 9일 5분 읽기

여러 프로젝트를 WordPress에서 Astro로 이전한 후, 저는 이 프레임워크의 열렬한 팬이 되었습니다.

## 아스트로란 무엇인가요?

아스트로는 2021년에 출시되어 즉시 다른 느낌을 받은 웹 프레임워크입니다. 대부분의 자바스크립트 프레임워크는 복잡한 애플리케이션을 구축하는 것으로 시작하여 더 간단한 사이트에 적응하려고 했지만, 아스트로는 그 반대 방향으로 나아갔습니다. 콘텐츠 중심 웹사이트를 위해 첫날부터 구축되었습니다.

철학은 신선하게 간단합니다. Astro는 콘텐츠 중심적이고 서버 중심적이며 기본적으로 JavaScript를 전혀 제공하지 않으면서도 뛰어난 툴링으로 사용하기 쉽다고 믿습니다. 마치 누군가가 마침내 "대부분의 사람들이 실제로 만드는 웹사이트 유형에 맞게 특별히 프레임워크를 만들면 어떨까요?"라고 묻는 것과 같습니다

## 섬 건축

아스트로는 "섬 건축"이라는 것을 소개했는데, 이를 이해하게 되면 왜 우리가 다른 방식으로 일을 해왔는지 궁금해하게 될 것입니다.

전통적인 프레임워크는 JavaScript로 전체 페이지에 수분을 공급합니다. 간단한 블로그 게시물에 인터랙티브 위젯이 하나만 있어도 전체 페이지에 JavaScript 처리가 적용됩니다. Astro는 이를 머리 위로 넘깁니다. 기본적으로 페이지는 정적 HTML이며, 상호 작용이 필요한 비트만 JavaScript "섬"이 됩니다

수천 단어의 콘텐츠가 담긴 블로그 게시물을 상상해 보세요. 아스트로에서는 모든 텍스트가 순수 HTML로 유지됩니다. 댓글 섹션이나 이미지 캐러셀만 JavaScript를 로드합니다. 다른 모든 것은 여전히 빠르게 유지됩니다. 놀랍도록 간단합니다.

## 실제 성능, 실제 영향

아스트로 사이트는 빠르고 기존 React 프레임워크에 비해 로드 시간이 40% 더 빠릅니다. 하지만 다른 개발자에게 깊은 인상을 주는 것만이 중요한 것은 아닙니다. 이러한 성능 향상은 검색 순위 향상, 사용자 만족도 향상, 더 많은 전환으로 직결됩니다. 느린 기기나 흐릿한 모바일 연결에서는 그 차이가 더욱 극적입니다.

## 실제로 제공하는 개발자 경험

아스트로에서의 개발자 경험은 마치 누군가가 우리가 어떻게 일하는지에 대해 실제로 생각해 본 것처럼 느껴집니다. 새로운 프로젝트를 설정하는 것은 간단하며, 친절한 설정 도우미인 휴스턴의 안내를 받습니다.

### 복잡성이 없는 구성 요소

제가 Astro 구성 요소에 대해 가장 좋아하는 점은 이 구성 요소들이 정말 합리적이라는 점입니다:
```
---
// This runs at build time
const { title } = Astro.props;
const posts = await fetchPosts();
---

<main>
  <h1>{title}</h1>
  {posts.map(post => (
    <article>
      <h2>{post.title}</h2>
      <p>{post.excerpt}</p>
    </article>
  ))}
</main>

<style>
  main {
    max-width: 800px;
    margin: 0 auto;
  }
</style>
```

맨 위에 있는 앞면이 보이시나요? 여기서 모든 서버 측 로직이 작동합니다. 브라우저가 아닌 빌드 시 실행됩니다. 사용자가 페이지를 로드하기 전에 데이터 가져오기, 로직, 심지어 API 호출까지 모두 이루어집니다.

Next.js나 SvelteKit과 같은 다른 프레임워크도 비슷한 패턴을 제공하지만, 아스트로가 눈에 띄는 점은 분리가 얼마나 명확하고 신중한지입니다. 클라이언트 측 상호 작용을 원하지 않는 한 후크, 상태 관리 또는 라이프사이클 방법에 대해 생각할 필요가 없습니다.

### 어떤 프레임워크(또는 없음)를 사용합니다

Astro를 사용하면 한 가지 방식으로 일을 처리할 수 없습니다. 복잡한 형태를 위해 React가 필요하신가요? 입력하세요. 데이터 시각화를 위해 Vue를 선호하시나요? 해보세요. 대부분의 것을 단순한 Astro 구성 요소로 유지하고 싶으신가요? 완벽합니다.

Astro를 사용하면 관리 대시보드 구성 요소에는 React를, 일부 대화형 차트에는 Vue를 사용할 수 있으며, 나머지 모든 것은 기본 Astro로 유지할 수 있습니다. 이 모든 것이 원활하게 작동합니다.

## 작동하는 기능

Astro에서 마크다운 지원은 사후 고려 사항으로 사용되지 않습니다. 마크다운 파일을 직접 가져와서 구성 요소처럼 사용할 수 있습니다:
```
---
import { Content, frontmatter } from "../content/post.md";
---
<article>
  <h1>{frontmatter.title}</h1>
  <Content />
</article>
```

빌드 파이프라인은 현대적이고 완전합니다. TypeScript는 기본적으로 작동하고, Sass 컴파일이 내장되어 있으며, Astro의 <Image /> 태그로 이미지가 자동으로 최적화되며, 개발 중에 핫 모듈 교체가 가능합니다. 웹팩 구성 설정이나 빌드 도구와의 싸움이 필요 없습니다.

페이지 렌더링 방식에도 유연성을 얻을 수 있습니다. 최대 속도를 위해 모든 것을 정적으로 빌드하거나, 동적 콘텐츠를 위해 서버에 렌더링하거나, 동일한 프로젝트에서 두 가지 접근 방식을 모두 혼합하세요. 아스트로는 필요한 것에 맞게 조정합니다.

## 아스트로가 정말 빛나는 곳

저는 Astro가 마케팅 사이트, 블로그, 이커머스 카탈로그, 포트폴리오 사이트에 완벽하다는 것을 알게 되었습니다. 기본적으로 모든 콘텐츠가 영웅이며 복잡한 클라이언트 측 상태 관리가 필요하지 않습니다.

## 트레이드오프

아스트로가 모든 것에 대한 해답은 아닙니다. 클라이언트 측 라우팅이 많은 복잡한 단일 페이지 애플리케이션(SPA)을 구축하고 있거나 ISR이 필요하거나 구성 요소 간에 과도한 상태 관리가 필요하다면 Next.js와 같은 다른 애플리케이션을 원할 가능성이 높습니다.

생태계는 성장하고 있지만 Next.js와 같은 것에 비하면 여전히 매우 작습니다. 파일 기반 라우팅은 더 큰 프로젝트에서는 제약을 받을 수 있습니다(일부 사람들은 좋아하지만).

## 빠른 시작

시작하는 것은 정말 간단합니다:
```
# Create project
npm create astro@latest my-site
cd my-site

# Add a framework if you want
npx astro add react

# Start developing
npm run dev
```

페이지를 src/pages/에, 구성 요소를 src/components/에 입력하면 훌륭한 것을 만들 준비가 됩니다.

## 아스트로가 중요한 이유

수년간의 JavaScript 프레임워크가 점점 더 복잡해지면서 Astro는 신선한 공기의 숨결처럼 느껴집니다. 빠르고 접근 가능하며 콘텐츠 우선의 경험이라는 웹의 기본으로 돌아가는 것이지만, 현대의 모든 개발자 편의성 덕분에 기대하게 되었습니다.


