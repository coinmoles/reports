#import "@preview/modernpro-cv:1.0.2": *
#import "@preview/fontawesome:0.5.0": *

#show: cv-single.with(
  font-type: "PT Serif",
  continue-header: "false",
  name: [Jiho Park],
  address: [서울특별시 관악구 관악로 285 (봉천동, 성현동아아파트) 106동 1005호],
  lastupdated: "true",
  pagecount: "true",
  date: [2024-12-07],
  contacts: (
    (
      text: [
        #box(image("location-dot-solid.svg", height: 0.8em))
        #h(0.1em) 
        Korea
      ]
    ),
    (
      text: [
        #box(image("mobile-solid.svg", height: 0.8em))
        #h(0.1em) 
        010-6207-7115
      ], 
      link: "tel:010-6207-7115"
    ),
    (
      text: [
        #box(image("link-solid.svg", height: 0.7em))
        #h(0.1em)
        github.com/coinmoles
      ], 
      link: "https://github.com/coinmoles"
    ),
  ),
)

#section("Education")
#education(
  institution: [서울과학고등학교],
  date: "2020~2022",
  description: [
    - 2022년 졸업 (32기)
  ],
)
#subsectionsep
#education(
  institution: [서울대학교 컴퓨터공학부],
  major: [컴퓨터공학부],
  date: "2023~",
  description: [
    - 재학 중 (23학번)
  ]
)

#section("Skills")
#oneline-title-item(
  title: "Programming Languages",
  content: [JavaScript(TypeScript), Rust, Python, HTML, CSS, SQL, LaTeX],
)
#sectionsep
//Experience
#section("Experience")
#job(
  position: "서울과학고등학교 정보부 부원 활동",
  date: "2021~2022",
  description: [
    - 학생 대상 문자 발송 애플리케이션 프런트엔드 및 API 개발
    - 간식 메뉴 알림 디스코드 봇 개발
    - 학생 포럼 사이트 프런트엔드 및 백엔드 개발
    - 축제 공연 예매 사이트 프런트엔드 및 백엔드 개발
  ],
)
#job(
  position: "서울대학교 컴퓨터공학부 게임 개발 동아리 UPnL 활동",
  date: "2023~",
  description: [
    - 동아리 회원 관리 디스코드 봇 개발
    - #link("https://coinmoles.itch.io/winterchild", [Winterchild]) 기획 및 개발, UNICON 2023에 출품
    - Skateboard platformer 개발 중
  ],
)

#job(
  position: "기타 프로젝트",
  description: [
    - 파이널 판타지 14 공략 사이트 (#link("https://llr.app/", [LLR])) 프런트엔드 개발
    - #link("https://github.com/PokeRogue-Projects/pokerogue-daily-runs", [포케로그 공략 사이트]) 프런트엔드 개발
  ],
)
