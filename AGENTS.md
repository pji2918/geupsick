# AGENTS.md

## 프로젝트 개요
NEIS(나이스) OpenAPI로 학교 급식 메뉴를 조회하는 Flutter 앱이다. 설정에서 활성화하면 LLM으로 0~100점의 "G-Score"를 산정한다. UI는 한국어가 기준이다.

## 명령어
- 의존성: `flutter pub get`
- 실행: `flutter run`
- 정적 분석: `flutter analyze` (`flutter_lints`, android/ios/web/windows/macos/linux/build 폴더는 분석 제외)
- 다국어 재생성: `flutter gen-l10n` (`lib/l10n/*.arb` 수정 후 실행. 생성 파일 `lib/l10n/app_localizations*.dart`는 저장소에 커밋됨)
- 전체 테스트: `flutter test`
- 단일 테스트 파일: `flutter test test/print_meal_and_layout_test.dart`
- 이름으로 단일 테스트: `flutter test --plain-name "테스트 이름"`
- 앱 아이콘 생성: `dart run flutter_launcher_icons`

## 아키텍처
소규모(약 2,900줄) 앱이며 상태관리/라우팅/DB 패키지 없이 `StatefulWidget` + `setState`로 구성된다. 라우팅은 `Navigator.push`만 사용한다.

- `lib/main.dart`: `MainApp`(StatefulWidget). 학교·날짜·식사 선택, 메뉴 표시, dynamic_color 테마, `SharedPreferencesAsync`로 학교 설정 저장/로드.
- `lib/settings.dart`: 설정 화면. SharedPreferences 키는 `useGScore`, `aiApiKey`, `aiApiUrl`, `aiModelName`, `modelSelection`(`ModelSelection` enum의 index).
- `lib/utilities/functions.dart`: 핵심 로직.
  - `getMeal()`: `.env`를 `dotenv.load`로 읽고 NEIS `mealServiceDietInfo`를 `http.get`으로 호출. 식사 구분은 `MMEAL_SC_CODE = idx + 1`.
  - `printMeal()`: 메뉴 위젯 생성. `isLargeScreen`/`isMediumScreen`/`getPadding`은 반응형 헬퍼.
  - `getGScore()`: `ModelSelection`에 따라 langchain으로 OpenAI / Google / Anthropic / 사용자 지정 OpenAI 호환 엔드포인트를 선택해 호출. 프롬프트는 한국어, 결과는 int 점수. 기본 모델명이 코드에 하드코딩돼 있다.
- `lib/utilities/getschoolinfo.dart`: `SchoolChanger` 위젯. NEIS `schoolInfo` API로 학교 검색(`pSize=500`).
- `lib/utilities/types/`: NEIS JSON 응답용 모델 클래스(수동 `fromJson`).

데이터 흐름: UI(`setState`) → `utilities` 함수가 NEIS HTTP 또는 LLM 호출 → JSON을 모델 클래스로 변환 → 위젯 출력.

## 주의사항
- UI 패키지는 `material_ui`다. `package:material_ui/material_ui.dart`를 import하고 `flutter/material.dart`는 쓰지 않는다.
- l10n 템플릿은 `app_ko.arb`다. 문구를 추가할 때 `app_ko.arb`와 `app_en.arb`를 함께 수정하고 `flutter gen-l10n`을 실행한다. (영어 arb는 한국어보다 키가 적어 누락이 있을 수 있음)
- NEIS API 키는 `.env`(`KEY=...`)에서 읽으며 `pubspec.yaml`의 assets로 번들된다. `.env`가 없으면 빌드가 실패할 수 있다. 키를 코드에 직접 넣지 않는다.
- 사용자의 LLM API 키는 SharedPreferences에 평문 저장된다.
- `build_runner`, `mockito`는 dev 의존성에만 있고 실제 코드생성/모킹은 쓰지 않는다 (freezed, json_serializable, `.g.dart` 없음).
- 테스트는 `printMeal`의 widget test(`test/print_meal_and_layout_test.dart`)뿐이며 `test/widget_test.dart`는 비어 있다. `integration_test/`, CI 워크플로, Makefile, flavor는 없다.
- android/ios/web/windows/macos/linux 6개 플랫폼 스캐폴딩이 모두 있다.
- dependabot이 pub 의존성을 매일 갱신해 `chore: upgrade dependencies`, `build(deps)` 커밋이 많다.
