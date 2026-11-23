import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

/// The app's theme, shared by the app and the Widgetbook catalogue.
class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: 'Nunito',
  );
}
