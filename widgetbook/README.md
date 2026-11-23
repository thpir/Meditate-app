# Meditate Widgetbook

[Widgetbook](https://widgetbook.io) catalogue of the Meditate app's design system: colors, typography and every reusable widget from `lib/ui/core/ui`, each with live knobs.

It is a separate Flutter project that depends on the app through `path: ../`, so Widgetbook and its plugins never become part of the app itself.

## Run

```bash
cd widgetbook
flutter run -d chrome
```

## Add a component

Add a `WidgetbookComponent` with one or more use cases to `lib/components.dart`.
