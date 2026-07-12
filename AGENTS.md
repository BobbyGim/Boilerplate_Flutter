# AGENTS.md

## 아키텍처

- 앱 코드는 `lib/src` 아래에 둔다.
- 레이어 폴더를 주요 경계로 사용한다.
  - `core`: 앱 전역에서 공유하는 routing, theme, 공통 widget, 환경 설정, 에러 처리 등 기반 코드.
  - `data`: 모델, repository 구현체, 외부/로컬 source.
  - `domain`: entity, repository contract, usecase.
  - `presentation`: app widget, page, controller, UI state.
- 앱 전역에서 공유하는 기반 코드는 `core/`에 두며, feature-first `features/` 구조는 프로젝트 방향이 바뀌지 않는 한 만들지 않는다.
- flavor entrypoint는 `lib/main_dev.dart`, `lib/main_prod.dart`를 사용한다.
- `lib/bootstrap.dart`는 앱 시작과 공통 초기화에만 사용한다.
- route name/path는 page class에 흩어두지 않고 `core/router`의 enum에서 관리한다.
- 공통 color, text style, `ThemeData`는 `core/theme`에서 관리한다.

## Barrel Export

- 각 폴더는 폴더명과 같은 barrel 파일을 가진다.
- 코드가 더 읽기 쉬워진다면 깊은 경로 import 대신 가장 가까운 barrel에서 import한다.
- generator가 요구하는 경우가 아니라면 generated file을 직접 export하지 않는다.

## Flavor And Env

- dev 실행은 `flutter run --flavor dev -t lib/main_dev.dart`를 사용한다.
- prod 실행은 `flutter run --flavor prod -t lib/main_prod.dart`를 사용한다.
- 환경값은 `.env.dev`, `.env.prod`에 둔다.
- `.env.dev`, `.env.prod`는 Git에 올리지 않고 `.env.example`만 공유한다.
- dev/prod는 서로 다른 bundle id/application id를 유지해서 같은 기기에 동시에 설치될 수 있어야 한다.

## 코드 스타일

- 기존 Flutter lint를 따른다.
- YAGNI 원칙을 따른다. 지금 요구사항에 필요한 코드만 추가하고, 예상되는 미래 확장만을 위한 추상화, 폴더, 레이어, 옵션은 만들지 않는다.
- 공유 상태와 controller는 Riverpod provider 사용을 우선한다.
- 단순한 화면 전용 UI 상태는 hook만 사용하며, 별도 아키텍처 패턴을 불필요하게 추가하지 않는다.
- UI 로직의 복잡도, 테스트 필요성, 상태 공유 등으로 presentation 패턴이 필요한 경우에는 MVC보다 MVVM을 사용한다.
- MVVM의 ViewModel은 여러 page에서 공유되는 상태라면 Riverpod provider로 제공하고, 한 page에서만 사용한다면 해당 page 아래에 둔다.
- 특정 page 또는 view 안에서만 쓰는 UI 상태/controller는 전역 `presentation/controller`로 빼지 않는다.
- `views` 안의 component가 hook으로 제어되는 경우, 해당 hook은 같은 `views/hooks` 아래에 `use_*.dart` 이름으로 둔다.
  예: `lib/src/presentation/page/home/views/home_title.dart`에서만 쓰는 hook은
  `lib/src/presentation/page/home/views/hooks/use_home_title.dart`에 둔다.
- `core/widget`의 공통 widget이 hook으로 제어되는 경우, 해당 hook은 `core/widget/hooks` 아래에 `use_*.dart` 이름으로 둔다.
- 여러 page에서 재사용되는 상태나 비즈니스 흐름으로 커진 경우에만 `presentation/controller` 또는 domain/usecase 경계로 올린다.
- hook이나 controller에서 callback/action을 반환할 때는 `return` 안에서 inline 함수로 만들지 않는다.
  먼저 이름 있는 함수로 선언하고, 반환 객체에는 함수 이름만 넘긴다.
  예: `incrementCount: incrementCount`
- hook에서 view 전용 상태를 반환할 때는 불필요한 state class를 만들지 말고 named record 반환을 우선한다.
  hook에서 사용하는 named record 타입은 같은 파일의 hook 함수 위에 `typedef`로 분리하고 `Model` suffix를 붙여 관리한다.
  예: `typedef HomeTitleModel = ({String title, int count, VoidCallback incrementCount});`
  사용하는 쪽에서는 named field 구조분해 할당으로 꺼낸다.
  예: `final (:title, :count, :incrementCount) = useHomeTitle();`
  hook의 반환 타입, 반환값, 사용하는 쪽의 구조분해 field 이름을 반드시 일치시킨다.
- 단일 expression으로 표현 가능한 함수/람다는 arrow function(`=>`)을 우선 사용한다.
  여러 문장이 필요하거나 명명된 action 함수의 의도가 block body에서 더 명확한 경우에는 block body를 사용한다.
- request/response/domain data를 추가할 때는 Freezed 기반 immutable model을 우선한다.
- page 전용 UI widget은 `presentation/page` 아래에 두고, 여러 page에서 공유하는 UI widget은 `core/widget` 아래에 둔다.
- widget/component class 이름은 PascalCase를 사용한다.

## 검증

- Dart 코드를 변경한 뒤에는 `flutter analyze`를 실행한다.
- flavor 또는 native 설정을 변경했다면 최소한 Android flavor 빌드 하나는 확인한다.
  `flutter build apk --debug --flavor dev -t lib/main_dev.dart`.
