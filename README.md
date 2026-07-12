# Flutter Boilerplate

A Flutter boilerplate project.

## Flavors

```sh
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor prod -t lib/main_prod.dart
```

Environment values are loaded from `.env.dev` and `.env.prod`.
These files are ignored by Git. Use `.env.example` as the template.

## Structure

```text
lib/
  bootstrap.dart
  main_dev.dart
  main_prod.dart
  src/
    data/
      model/
      repository/
      source/
    domain/
      entity/
      repository/
      usecase/
    presentation/
      controller/
      page/
      app.dart
```

Each folder exposes a barrel file named after the folder, for example
`lib/src/data/data.dart` and `lib/src/presentation/presentation.dart`.

Project-specific Codex instructions are in `AGENTS.md`.
Claude-compatible instructions are in `CLAUDE.md`, which points back to `AGENTS.md`.
Codex command approval rules, if needed, belong in `.codex/rules/*.rules`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
