# Flutter Boilerplate

개인 Flutter 앱을 빠르게 시작하기 위한 보일러플레이트입니다. Clean Architecture의 레이어 분리, dev/prod flavor, 환경값, 라우팅, 공통 테마와 위젯, Riverpod 및 코드 생성을 기본 구성으로 제공합니다.

이 저장소는 재사용 가능한 **앱 프로젝트 템플릿**이며, pub.dev에 배포하는 Dart/Flutter package 템플릿은 아닙니다. `publish_to: none`으로 실수에 의한 배포를 방지합니다.

## 주요 구성

- `dev`, `prod` flavor와 별도 entrypoint
- `.env.dev`, `.env.prod` 환경값 분리
- `core`, `data`, `domain`, `presentation` 기반 Clean Architecture
- `go_router` 기반 선언형 라우팅
- Material 3 공통 색상, 텍스트 스타일 및 테마
- Flutter Hooks와 Riverpod을 이용한 상태 관리
- Freezed, JSON serialization, Riverpod 코드 생성 도구
- 폴더별 barrel export

## 시작하기

### 요구 환경

- Flutter stable
- Dart `^3.12.2`
- Android Studio 또는 Xcode 등 대상 플랫폼 개발 환경

### 프로젝트 준비

```sh
flutter pub get
cp .env.example .env.dev
cp .env.example .env.prod
```

각 환경 파일의 값을 앱에 맞게 수정합니다.

```dotenv
APP_NAME=Flutter Boilerplate
API_BASE_URL=https://api.example.com
```

`.env.dev`와 `.env.prod`는 Git에서 제외되며 `.env.example`만 공유합니다. Flutter asset에 포함된 환경 파일은 앱 바이너리에서 추출될 수 있으므로 API 비밀키, 개인키, 인증서 비밀번호 같은 실제 secret을 저장하면 안 됩니다.

## 실행과 빌드

개발 환경 실행:

```sh
flutter run --flavor dev -t lib/main_dev.dart
```

운영 환경 실행:

```sh
flutter run --flavor prod -t lib/main_prod.dart
```

Android 개발 flavor 빌드:

```sh
flutter build apk --debug --flavor dev -t lib/main_dev.dart
```

기본 검증:

```sh
flutter analyze
flutter test
```

코드 생성이 필요한 모델이나 provider를 추가한 후 실행합니다.

```sh
dart run build_runner build --delete-conflicting-outputs
```

개발 중 변경사항을 계속 감시하려면 다음 명령을 사용합니다.

```sh
dart run build_runner watch --delete-conflicting-outputs
```

## 프로젝트 구조

```text
lib/
├── bootstrap.dart
├── main_dev.dart
├── main_prod.dart
└── src/
    ├── core/
    │   ├── core.dart
    │   ├── router/
    │   │   ├── app_route.dart
    │   │   ├── app_router.dart
    │   │   └── router.dart
    │   ├── theme/
    │   │   ├── app_colors.dart
    │   │   ├── app_text_styles.dart
    │   │   ├── app_theme.dart
    │   │   └── theme.dart
    │   └── widget/
    │       ├── hooks/
    │       ├── app_navigation_destination.dart
    │       ├── app_shell.dart
    │       └── widget.dart
    ├── data/
    │   ├── data.dart
    │   ├── model/
    │   ├── repository/
    │   └── source/
    │       └── app_environment.dart
    ├── domain/
    │   ├── domain.dart
    │   ├── entity/
    │   ├── repository/
    │   └── usecase/
    └── presentation/
        ├── app.dart
        ├── presentation.dart
        └── page/
            ├── detail/
            ├── home/
            │   ├── components/
            │   │   └── hooks/
            │   └── home_page.dart
            └── settings/
```

### 레이어 책임

| 영역 | 책임 |
| --- | --- |
| `bootstrap.dart` | Flutter 초기화, 환경값 로드, 최상위 `ProviderScope` 구성 |
| `main_dev.dart`, `main_prod.dart` | flavor별 앱 entrypoint |
| `core/router` | 앱 전역 route 이름·경로와 `GoRouter` 구성 |
| `core/theme` | 공통 색상, 텍스트 스타일과 `ThemeData` |
| `core/widget` | 여러 페이지에서 재사용하는 공통 위젯과 전용 Hook |
| `data/model` | API, 로컬 저장소 등 데이터 표현 모델 |
| `data/repository` | domain repository contract 구현 |
| `data/source` | 네트워크, 로컬 저장소, 환경값 등 데이터 원천 |
| `domain/entity` | 프레임워크에 독립적인 핵심 entity |
| `domain/repository` | 데이터 접근 contract |
| `domain/usecase` | 앱의 비즈니스 흐름과 규칙 |
| `presentation/page` | 페이지, 페이지 전용 컴포넌트, UI 상태와 Hook |

### 핵심 파일 설명

| 파일 | 설명 |
| --- | --- |
| `lib/main_dev.dart` | `dev` 환경을 선택해 공통 bootstrap을 호출하는 개발용 시작점 |
| `lib/main_prod.dart` | `prod` 환경을 선택해 공통 bootstrap을 호출하는 운영용 시작점 |
| `lib/bootstrap.dart` | binding 초기화, 환경 파일 로드, Riverpod `ProviderScope`, `runApp` 담당 |
| `lib/src/src.dart` | `core`, `data`, `domain`, `presentation`을 모으는 최상위 barrel |
| `lib/src/core/core.dart` | 앱 전역 기반 코드의 barrel |
| `lib/src/core/router/app_route.dart` | route name과 path를 한곳에서 관리하는 enum |
| `lib/src/core/router/app_router.dart` | `GoRouter`, `ShellRoute`, 각 페이지 연결을 정의하는 route tree |
| `lib/src/core/theme/app_colors.dart` | 앱 공통 색상 token |
| `lib/src/core/theme/app_text_styles.dart` | 앱 공통 typography token |
| `lib/src/core/theme/app_theme.dart` | 색상과 typography를 조합해 `ThemeData` 제공 |
| `lib/src/core/widget/app_shell.dart` | 여러 route가 공유하는 Scaffold와 하단 navigation shell |
| `lib/src/core/widget/app_navigation_destination.dart` | 앱 navigation destination의 공통 표현 |
| `lib/src/core/widget/hooks/use_app_shell.dart` | shell의 현재 탭 계산과 이동 action을 담당하는 전용 Hook |
| `lib/src/data/source/app_environment.dart` | 선택된 flavor에 맞는 env 파일 로드 및 환경값 제공 |
| `lib/src/presentation/app.dart` | `MaterialApp.router`, router와 앱 theme를 연결하는 최상위 앱 위젯 |
| `lib/src/presentation/page/page.dart` | 앱의 page export를 모으는 barrel |

### 페이지 폴더 구성

페이지는 다음 형태를 기본으로 사용합니다.

```text
presentation/page/<page>/
├── <page>.dart
├── <page>_page.dart
└── components/
    ├── components.dart
    ├── <component>.dart
    └── hooks/
        ├── hooks.dart
        └── use_<component>.dart
```

- `<page>_page.dart`: route와 직접 연결되는 페이지의 최상위 위젯
- `components/`: 해당 페이지에서만 사용하는 작은 UI 컴포넌트
- `components/hooks/`: 해당 component 전용 상태와 action
- `<page>.dart`, `components.dart`, `hooks.dart`: 각 폴더의 공개 API를 정리하는 barrel

한 페이지에서만 쓰는 코드는 해당 페이지 폴더에 유지합니다. 두 개 이상의 페이지에서 실제로 재사용되는 UI만 `core/widget`으로 옮기며, 공유될 가능성만으로 미리 이동하지 않습니다.

의존성은 바깥쪽 구현에서 안쪽 규칙을 향하도록 유지합니다. Domain은 Flutter UI, 네트워크 및 저장소 구현에 의존하지 않습니다.

각 폴더는 폴더명과 같은 barrel 파일을 가집니다. 예를 들어 `core/core.dart`, `theme/theme.dart`, `presentation/presentation.dart`를 통해 가까운 경계에서 export를 관리합니다. Generator가 요구하지 않는 한 generated file은 직접 export하지 않습니다.

## 상태 관리 기준

- 한 화면이나 컴포넌트에만 필요한 단순 UI 상태는 Flutter Hooks를 우선합니다.
- Component 전용 Hook은 해당 `components/hooks` 아래에 `use_*.dart`로 둡니다.
- Hook 반환값은 불필요한 class 대신 named record와 `Model` suffix typedef를 우선합니다.
- 여러 화면에서 공유하는 상태는 Riverpod provider를 우선합니다.
- 별도 presentation 패턴이 필요할 정도로 UI 로직이 복잡하거나 테스트가 중요할 때만 MVVM을 적용합니다.
- 페이지 전용 ViewModel은 해당 page 아래에 두고, 공유 ViewModel은 Riverpod provider로 제공합니다.

## 라우팅과 테마

Route name과 path는 `core/router/app_route.dart`의 `AppRoute`에서 관리합니다. 페이지 클래스에 문자열 경로를 흩어두지 않습니다. 실제 route tree와 shell navigation은 `app_router.dart`에 구성합니다.

공통 디자인 값은 `core/theme`에서 관리합니다.

- `AppColors`: 의미 있는 공통 색상
- `AppTextStyles`: 공통 텍스트 스타일
- `AppTheme`: Material 3 `ThemeData` 조립

현재 primary seed 색상은 `Colors.deepPurple`입니다.

## 라이브러리 용도

### 앱 의존성

| 라이브러리 | 사용 목적 |
| --- | --- |
| `flutter` | Flutter SDK와 Material UI 기반 |
| `cupertino_icons` | iOS 스타일 Cupertino 아이콘 |
| `flutter_hooks` | `HookWidget`, `useState`, `useEffect` 등 위젯 상태와 생명주기 로직 재사용 |
| `hooks_riverpod` | Riverpod 상태 관리와 Hook 통합, `ProviderScope` 제공 |
| `riverpod_annotation` | annotation 기반 Riverpod provider 선언 |
| `go_router` | URL 기반 선언형 라우팅, named route, shell navigation 및 deep link 처리 |
| `json_annotation` | JSON 직렬화 코드 생성에 필요한 annotation |
| `freezed_annotation` | Freezed immutable class와 union/sealed model annotation |
| `cached_network_image` | 네트워크 이미지 캐시, 로딩 및 오류 UI 처리 |
| `intl` | 날짜, 숫자, 통화와 다국어 형식화 |
| `flutter_secure_storage` | token 등 민감한 값을 Keychain/Encrypted SharedPreferences 계열 보안 저장소에 저장 |
| `flutter_svg` | SVG asset 렌더링 |
| `gap` | Row, Column 등에서 간단한 고정 간격 표현 |
| `shimmer` | skeleton loading용 shimmer 효과 |
| `carousel_slider` | 배너, 카드 등 carousel/slider UI |
| `url_launcher` | 웹 URL, 전화, 이메일과 외부 앱 scheme 실행 |
| `lottie` | Lottie JSON 애니메이션 재생 |
| `animations` | Material motion transition과 container transform |
| `shared_preferences` | 설정값 등 보안이 필요 없는 작은 key-value 데이터 저장 |
| `flutter_dotenv` | `.env.dev`, `.env.prod` 파일 로드와 환경값 접근 |
| `logger` | 개발 로그를 구조적이고 읽기 쉬운 형태로 출력 |
| `flutter_animate` | 위젯에 fade, slide 등 체이닝 애니메이션 적용 |

모든 라이브러리를 각 화면에서 반드시 사용할 필요는 없습니다. 새 앱에서 사용하지 않는 라이브러리는 `pubspec.yaml`에서 제거해 의존성과 앱 크기를 관리합니다.

### 개발 의존성

| 라이브러리 | 사용 목적 |
| --- | --- |
| `flutter_test` | widget/unit test를 위한 Flutter 공식 테스트 도구 |
| `flutter_lints` | Flutter 권장 정적 분석 규칙 |
| `build_runner` | Freezed, JSON, Riverpod generator 실행기 |
| `riverpod_generator` | annotation으로 선언한 Riverpod provider 코드 생성 |
| `json_serializable` | `fromJson`, `toJson` 구현 생성 |
| `freezed` | immutable data class, copyWith, equality 및 union 코드 생성 |

## 저장 방식 선택

- 로그인 token과 같이 보호가 필요한 값: `flutter_secure_storage`
- 테마 선택, 온보딩 완료 여부 같은 일반 설정: `shared_preferences`
- 빌드 환경별 공개 설정: `flutter_dotenv`
- 실제 비밀값: 앱에 포함하지 말고 서버 또는 안전한 secret 관리 체계 사용

## 새 기능을 추가할 때

1. 비즈니스 entity와 repository contract가 필요하면 `domain`에 추가합니다.
2. 외부/로컬 데이터 모델, source와 repository 구현은 `data`에 추가합니다.
3. 페이지와 페이지 전용 UI는 `presentation/page/<page>`에 추가합니다.
4. 여러 페이지가 공유하는 위젯은 `core/widget`으로 올립니다.
5. 공통 route와 theme 변경은 각각 `core/router`, `core/theme`에서 처리합니다.
6. Dart 코드를 변경한 뒤 `flutter analyze`를 실행합니다.
7. flavor 또는 native 설정을 변경했다면 dev Android 빌드도 확인합니다.

미래 확장만을 예상한 폴더, 추상화와 옵션은 만들지 않고 현재 요구사항에 필요한 코드만 추가합니다.

## 프로젝트 지침

- Codex 및 작업 에이전트 지침: `AGENTS.md`
- Claude 호환 지침: `CLAUDE.md`
- 분석 규칙: `analysis_options.yaml`

프로젝트 구조나 개발 규칙을 변경하면 코드뿐 아니라 `AGENTS.md`와 이 README도 함께 갱신합니다.
