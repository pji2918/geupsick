# Flutter에서 Expo (React Native)로의 전환 이관 계획서 (MIGRATION_PLAN.md)

이 문서는 기존 Flutter 기반 급식 알림 앱(`geupsick`)을 Expo (React Native) 기반의 모바일 앱으로 안정적이고 체계적으로 전환하기 위한 마이그레이션 아키텍처 및 상세 로드맵입니다.

---

## 1. Executive Summary & Complexity Rating

### 복잡도 평가 (Overall Complexity Score)

- **복잡도 등급:** **Low (낮음)**
- **평가 사유:**
    - 전체 소스 코드가 약 1,500줄 이하로 규모가 작고 구조가 명확합니다.
    - Native Code(MethodChannel, Kotlin/Swift 커스텀 코드)가 전혀 포함되어 있지 않습니다 ([MainActivity.kt](file:///Users/pji2918/RemoteProjects/geupsick/android/app/src/main/kotlin/com/pji2918/geupsick/MainActivity.kt#L1-L6) 참조).
    - 로컬 데이터베이스(SQLite, Hive 등) 대신 간단한 Key-Value 저장소([shared_preferences](https://pub.dev/packages/shared_preferences))만을 사용 중입니다.

### 주요 기술적 고려사항 및 전환 요소 (Blockers & Bottlenecks)

1. **AI / LLM 통합 ([functions.dart:L100-190](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/functions.dart#L100-L190))**:
    - 현재 Dart 기반 `langchain`, `langchain_openai`, `langchain_google`, `langchain_anthropic` 라이브러리를 통해 급식 메뉴의 맛 평가 점수(G-Score)를 산출합니다.
    - **Vercel AI SDK (`ai`)** 패키지를 도입하여 다양한 AI Provider(OpenAI, Gemini, Anthropic, xAI)를 단일화된 인터페이스로 가볍고 안정적으로 통합합니다.
2. **다단 반응형 레이아웃 ([main.dart:L217-358](file:///Users/pji2918/RemoteProjects/geupsick/lib/main.dart#L217-L358))**:
    - 화면 너비(Small $\le$ 640, Medium > 640, Large > 960)에 따라 BottomNavigationBar, NavigationRail, Drawer로 유동 전환되는 UI 레이아웃을 React Native의 `useWindowDimensions()` 및 NativeWind 유틸리티 클래스로 재구현합니다.
3. **Android Material You (Dynamic Color) & UI 레이어 ([main.dart:L82-96](file:///Users/pji2918/RemoteProjects/geupsick/lib/main.dart#L82-L96))**:
    - **Expo UI (`@expo/ui`)**의 네이티브 위젯 컴포넌트와 **NativeWind (Tailwind CSS)** 스타일링을 병행 사용하여 고성능 반응형 UI와 프리미엄 디자인을 달성합니다.

---

## 2. Tech Stack Mapping Table & Candidate Approvals

기존 Flutter 의존성과 이에 대응하는 Expo / React Native 패키지 비교표입니다. 모든 주요 패키지가 사용자 승인 완료(✅ Approved)되었습니다.

| Flutter Package                                 | Proposed Expo Replacement                               | Status      | Notes / Trade-offs & GitHub Links                                                                                                                                                                                                                                                            |
| :---------------------------------------------- | :------------------------------------------------------ | :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `http` (`^1.6.0`)                               | **Axios**                                               | ✅ Approved | Axios는 Dio/http와 유사하게 Interceptor 및 글로벌 설정 지원.<br/>• [Axios GitHub](https://github.com/axios/axios)<br/>• [ky GitHub](https://github.com/sindresorhus/ky)                                                                                                                      |
| `shared_preferences` (`^2.5.5`)                 | **react-native-mmkv**                                   | ✅ Approved | MMKV는 C++ 동기화 엔진 기반으로 읽기/쓰기가 10배 이상 빠름. API Key 암호화 필요시 Secure Store 병용 가능.<br/>• [react-native-mmkv GitHub](https://github.com/mrousavy/react-native-mmkv)<br/>• [expo-secure-store GitHub](https://github.com/expo/expo)                                     |
| `langchain_*` (`^0.8.1` / `^0.3.1` / `0.7.1+1`) | **Vercel AI SDK (`ai`)**                                | ✅ Approved | Vercel AI SDK는 여러 LLM Provider(OpenAI, Anthropic, Google 등)를 표준화된 인터페이스로 간결하게 제어.<br/>• [Vercel AI SDK GitHub](https://github.com/vercel/ai)                                                                                                                            |
| `flutter_localizations` / `intl` (`^0.20.2`)    | **i18next** + **react-i18next** + **expo-localization** | ✅ Approved | 현재 `app_en.arb`, `app_ko.arb` 기반 다국어 지원중 ([app_ko.arb](file:///Users/pji2918/RemoteProjects/geupsick/lib/l10n/app_ko.arb)). i18next 표준 JSON 변환 용이.<br/>• [i18next GitHub](https://github.com/i18next/i18next)<br/>• [expo-localization GitHub](https://github.com/expo/expo) |
| `dynamic_color` (`^1.8.1`)                      | **Expo UI (`@expo/ui`) + NativeWind**                   | ✅ Approved | `@expo/ui` 네이티브 레이아웃과 Tailwind CSS(NativeWind) 유틸리티를 병행하여 뛰어난 퍼포먼스 및 디자인 달성.<br/>• [Expo UI GitHub](https://github.com/expo/expo)<br/>• [NativeWind GitHub](https://github.com/nativewind/nativewind)                                                         |
| _(상태 관리)_                                   | **Zustand** + **TanStack Query (v5)**                   | ✅ Approved | 현재 Flutter 코드는 `setState`와 `SharedPreferencesAsync`를 혼용 중. Zustand로 앱 설정 영속화, TanStack Query로 NEIS API Caching/Refetching 담당.<br/>• [Zustand GitHub](https://github.com/pmndrs/zustand)<br/>• [TanStack Query GitHub](https://github.com/TanStack/query)                 |
| `google_fonts` (`^8.1.0`)                       | **@expo-google-fonts/ibm-plex-sans-kr**                 | ✅ Approved | 기존 `IBM Plex Sans KR` 폰트 일치([main.dart:L112](file:///Users/pji2918/RemoteProjects/geupsick/lib/main.dart#L112)).<br/>• [Expo Google Fonts GitHub](https://github.com/expo/google-fonts)                                                                                                |
| `package_info_plus` (`^10.2.0`)                 | **expo-application** / **expo-constants**               | ✅ Approved | 앱 버전 및 이름 읽기 지원([settings.dart:L197](file:///Users/pji2918/RemoteProjects/geupsick/lib/settings.dart#L197)).                                                                                                                                                                       |
| `url_launcher` (`^6.3.2`)                       | **expo-web-browser** / **expo-linking**                 | ✅ Approved | API Key 발급 링크 등 외부 인앱 브라우저 연동 ([settings.dart:L365-403](file:///Users/pji2918/RemoteProjects/geupsick/lib/settings.dart#L365-L403)).                                                                                                                                          |
| `flutter_dotenv` (`^6.0.1`)                     | **Expo Environment Variables (`EXPO_PUBLIC_`)**         | ✅ Approved | NEIS API Key 관리 (`.env` 파일의 `KEY` 항목).                                                                                                                                                                                                                                                |

---

## 3. Recommended Expo Project Architecture

[expo-router](https://github.com/expo/expo) 기반 파일 기반 라우팅 및 기능별(Feature-first) 디렉토리 구조 추천안입니다.

```text
geupsick-expo/
├── assets/                  # 폰트, 아이콘, 이미지 자원 (assets/icon/)
├── src/
│   ├── app/                 # Expo Router (File-based Routing)
│   │   ├── _layout.tsx      # Root Layout (QueryClientProvider, PaperProvider, i18n 초기화)
│   │   ├── index.tsx        # 메인 급식 화면 (기존 lib/main.dart)
│   │   ├── settings.tsx     # 설정 화면 (기존 lib/settings.dart)
│   │   └── school-select.tsx# 학교 검색/변경 모달 (기존 lib/utilities/getschoolinfo.dart)
│   ├── components/          # 공통 UI 컴포넌트
│   │   ├── ResponsiveLayout.tsx # Small/Medium/Large Screen 분기 레이아웃
│   │   ├── MealCard.tsx     # 급식 메뉴 출력 카드 (printMeal 대응)
│   │   └── GScoreCard.tsx   # G-Score 점수 표시 및 로딩 컴포넌트
│   ├── services/            # API 연동 및 외부 통신
│   │   ├── neisApi.ts       # NEIS 급식/학교 정보 API 호출 클라이언트 (http.get)
│   │   └── aiService.ts     # OpenAI, Gemini, Anthropic, xAI LLM 점수 산출 함수
│   ├── store/               # Zustand 글로벌 상태 정의
│   │   ├── useAppStore.ts   # 학교 코드, 교육청 코드, 날짜 인덱스 관리 (MMKV 영속화)
│   │   └── useAiStore.ts    # AI 설정 (API Key, Model Selection, URL 등)
│   ├── types/               # TypeScript 인터페이스 (기존 lib/utilities/types/)
│   │   ├── meal.ts          # GeupsickInfo, MealServiceDietInfo
│   │   └── school.ts        # SchoolData, SchoolInfo
│   ├── i18n/                # 다국어 번역 데이터 (locales/ko.json, locales/en.json)
│   └── constants/           # 교육청 인덱스 리스트 (ministryList), 상수
├── app.json                 # Expo Managed Workflow 설정
├── babel.config.js
├── package.json
└── tsconfig.json
```

---

## 4. Phased Migration Roadmap

### Phase 0: 프로젝트 초기화 및 개발 환경 구축

- [ ] `npx create-expo-app@latest geupsick-expo --template blank-typescript`를 통한 Expo Managed 프로젝트 스캐폴딩.
- [ ] Expo Router (`expo-router`), TypeScript, ESLint/Prettier 설정.
- [ ] 기본 패키지 설치: `@tanstack/react-query`, `zustand`, `react-native-mmkv`, `axios`, `ai`, `@expo/ui`, `nativewind`, `expo-localization`, `i18next`, `react-i18next`.
- [ ] `.env` 환경변수 설정 (`EXPO_PUBLIC_NEIS_KEY`).

### Phase 1: Core Modules & Data Layer 이관

- [ ] **타입 정의 ([geupsickinfoclass.dart](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/types/geupsickinfoclass.dart), [schoolinfoclass.dart](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/types/schoolinfoclass.dart))**:
    - Dart 클래스를 TypeScript 인터페이스 `MealServiceDietInfo`, `SchoolInfo`로 1:1 이관.
- [ ] **로컬 스토리지 & 상태 관리**:
    - `SharedPreferencesAsync` 사용 로직 ([settings.dart:L25-61](file:///Users/pji2918/RemoteProjects/geupsick/lib/settings.dart#L25-L61))을 Zustand와 `react-native-mmkv` 상태 스토어로 구현.
- [ ] **NEIS API Service ([functions.dart:L16-28](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/functions.dart#L16-L28), [getschoolinfo.dart:L37-46](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/getschoolinfo.dart#L37-L46))**:
    - Axios 기반으로 NEIS 급식 정보 및 학교 검색 API 통합 모듈 작성.
- [ ] **다국어(i18n) 설정**:
    - `app_ko.arb`, `app_en.arb`의 메시지키를 JSON 파일로 변환 후 `i18next` 연동.

### Phase 2: Main Features & Screen Migration

- [ ] **급식 메인 화면 (`src/app/index.tsx`)**:
    - `TanStack Query`의 `useQuery`를 통한 `getMeal` 데이터 패칭 및 로딩/에러 처리 ([main.dart:L442-484](file:///Users/pji2918/RemoteProjects/geupsick/lib/main.dart#L442-L484)).
    - 급식 문자열 `<br/>` 파싱 로직 이관 ([functions.dart:L68-84](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/functions.dart#L68-L84)).
- [ ] **학교 검색 모달 (`src/app/school-select.tsx`)**:
    - 교육청 드롭다운 ([getschoolinfo.dart:L79-148](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/getschoolinfo.dart#L79-L148)) 및 검색어 필터링 구현.
- [ ] **설정 화면 (`src/app/settings.tsx`)**:
    - AI API Key 입력 Dialog, Model 선택 (OpenAI, Google, Anthropic, xAI, Custom OpenAI Compatible) ([settings.dart:L301-435](file:///Users/pji2918/RemoteProjects/geupsick/lib/settings.dart#L301-L435)).
- [ ] **AI (G-Score) 점수 평가 연동 ([functions.dart:L100-190](file:///Users/pji2918/RemoteProjects/geupsick/lib/utilities/functions.dart#L100-L190))**:
    - Vercel AI SDK (`ai`) 기반 OpenAI, Gemini, Anthropic, xAI Provider 호출 및 점수 반환 로직 검증.

### Phase 3: Responsive UI & Animation Polish

- [ ] **반응형 레이아웃 구성 ([main.dart:L217-358](file:///Users/pji2918/RemoteProjects/geupsick/lib/main.dart#L217-L358))**:
    - `useWindowDimensions()` Custom Hook 작성 (`isSmall`, `isMedium`, `isLarge`).
    - Small 화면: `react-native-pager-view` (날짜 스와이프) + Bottom Navigation Bar.
    - Medium/Large 화면: NavigationRail / Drawer 형태 측면 메인 뷰 구성.
- [ ] **UI Styling & Native Integration**:
    - `@expo/ui` 네이티브 호스트 컴포넌트 적용 및 NativeWind (Tailwind CSS) 반응형 스타일링 적용.

### Phase 4: QA, Testing & EAS Deployment

- [ ] `test/print_meal_and_layout_test.dart` 대응하는 Jest/React Native Testing Library 유닛 테스트 구현.
- [ ] iOS 및 Android 기기/에뮬레이터 검증.
- [ ] EAS (Expo Application Services) Build 설정 (`eas.json`) 및 프로덕션 빌드 준비.

---

## 5. High-Risk Items & Mitigation Strategy

| 위험 요인                           | 위협 수준  | 세부 원인 및 영향                                                                                          | 대응 및 완화 전략 (Mitigation Strategy)                                                                                                                                                    |
| :---------------------------------- | :--------- | :--------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **다종 AI Provider 연동 (LLM)**     | **Medium** | OpenAI, Google Gemini, Anthropic, xAI API의 응답 구조 차이 및 통신 이슈.                                   | • **Vercel AI SDK (`ai`)** 패키지를 채택하여 단일화된 `generateText` / LLM Provider 인터페이스로 가볍고 직관적인 연동 구현.                                                                |
| **반응형 UI (Drawer vs BottomBar)** | **Medium** | Flutter의 `NavigationRail` / `Drawer` / `NavigationBar` 자동 전환 대응 로직 이관 시 화면 이질감 발생 가능. | • React Native 내에서 화면 너비를 구독하는 `useWindowDimensions()` 기반 래퍼 컴포넌트 (`ResponsiveLayout`) 작성.<br/>• `react-native-pager-view`와 결합하여 자연스러운 스와이프 체험 제공. |
| **Material 3 Dynamic Color & UI**   | **Low**    | Android OS의 Material You 시스템 획득 시 Flutter와 RN의 색상 셋 차이.                                      | • **Expo UI (`@expo/ui`)**와 **NativeWind**를 병행하여 네이티브 룩앤필과 고성능 유틸리티 스타일링을 동시에 만족시킴.                                                                       |
