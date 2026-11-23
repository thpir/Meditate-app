// Widgetbook catalogue of the Meditate design system.
//
// Run it in Chrome from this folder with:
//   flutter run -d chrome
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/theme/app_theme.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.dart';
import 'foundations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadAppFonts();
  runApp(const MeditateWidgetbook());
}

/// Assets and fonts of a dependency are bundled under `packages/meditate_app/`.
const String _appPackagePrefix = 'packages/meditate_app/';

/// The app's widgets use the font family `Nunito`. In this package the app's
/// fonts are registered as `packages/meditate_app/Nunito`, so register them
/// again under the plain name.
Future<void> _loadAppFonts() async {
  final loader = FontLoader('Nunito');
  for (final file in ['nunito_regular', 'nunito_bold', 'nunito_italic']) {
    loader.addFont(rootBundle.load('${_appPackagePrefix}assets/fonts/$file.ttf'));
  }
  await loader.load();
}

/// The app's widgets load their images as `assets/...`; this bundle maps those
/// keys to where the images live in this package.
class _AppAssetBundle extends CachingAssetBundle {
  String _resolve(String key) =>
      key.startsWith('assets/') ? '$_appPackagePrefix$key' : key;

  @override
  Future<ByteData> load(String key) => rootBundle.load(_resolve(key));

  @override
  Future<ImmutableBuffer> loadBuffer(String key) =>
      rootBundle.loadBuffer(_resolve(key));
}

final _AppAssetBundle _appAssetBundle = _AppAssetBundle();

// Widgetbook's `Widgetbook.material`, `materialAppBuilder` and
// `MaterialThemeAddon` are built on the framework's
// `package:flutter/material.dart`. The app's widgets come from `material_ui`,
// which has its own `ThemeData`, `Theme` and `MaterialApp` classes, so the
// use cases are wrapped in the `material_ui` versions below instead.

/// Wraps every use case in `material_ui`'s [MaterialApp], so the app's widgets
/// find the theme and localizations they look up.
Widget _materialUiAppBuilder(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(child: child),
  );
}

/// Applies the selected theme in the same way as Widgetbook's
/// `MaterialThemeAddon`, but with `material_ui`'s [Theme].
Widget _materialUiThemeBuilder(
  BuildContext context,
  ThemeData theme,
  Widget child,
) {
  return Theme(
    data: theme,
    child: ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium ?? const TextStyle(),
        child: child,
      ),
    ),
  );
}

class MeditateWidgetbook extends StatelessWidget {
  const MeditateWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) => DefaultAssetBundle(
        bundle: _appAssetBundle,
        child: _materialUiAppBuilder(context, child),
      ),
      addons: [
        ThemeAddon<ThemeData>(
          themeBuilder: _materialUiThemeBuilder,
          themes: [
            WidgetbookTheme(
              name: 'Meditate',
              // Screens paint AppColors.primary themselves; use it as the
              // canvas so components are shown on the app background.
              data: AppTheme.light.copyWith(
                scaffoldBackgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
        ViewportAddon([
          Viewports.none,
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
          IosViewports.iPad,
        ]),
        AlignmentAddon(),
        TextScaleAddon(),
      ],
      directories: [
        WidgetbookCategory(name: 'Foundations', children: foundations),
        WidgetbookCategory(name: 'Components', children: components),
      ],
    );
  }
}
