import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/home/widgets/home_screen.dart';
import 'package:meditate_app/ui/meditation_session/widgets/meditation_session_screen.dart';
import 'package:meditate_app/ui/pick_avatar/widgets/pick_avatar_screen.dart';
import 'package:meditate_app/ui/user_settings/widgets/user_settings_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primary,
        useMaterial3: true,
        fontFamily: 'Nunito'),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        MeditationSessionScreen.routeName: (context) => const MeditationSessionScreen(),
        UserSettingsScreen.routeName: (context) => const UserSettingsScreen(),
        PickAvatarScreen.routeName: (context) => const PickAvatarScreen(),
      },
    );
  }
}
