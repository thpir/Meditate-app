import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/waiting_screen.dart';
import 'package:meditate_app/ui/home/widgets/home_screen.dart';
import 'package:meditate_app/ui/meditation_session/widgets/meditation_session_screen.dart';
import 'package:meditate_app/ui/pick_avatar/widgets/pick_avatar_screen.dart';
import 'package:meditate_app/ui/user_settings/widgets/user_settings_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserPreferences(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                brightness: Brightness.light,
              ),
          useMaterial3: true,
          fontFamily: 'Nunito'),
        home: Consumer<UserPreferences>(
          builder: (context, userPreferences, _) {
            if (!userPreferences.prefsLoaded) {
              return const WaitingScreen();
            }
            return const HomeScreen();
          },
        ),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          MeditationSessionScreen.routeName: (context) => const MeditationSessionScreen(),
          UserSettingsScreen.routeName: (context) => const UserSettingsScreen(),
          PickAvatarScreen.routeName: (context) => const PickAvatarScreen(),
        },
      ),
    );
  }
}
