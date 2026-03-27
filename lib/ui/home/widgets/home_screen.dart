import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';
import 'package:meditate_app/ui/core/ui/custom_dropdown_menu.dart';
import 'package:meditate_app/ui/core/ui/rounded_button.dart';
import 'package:meditate_app/ui/home/view_model/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(userPrefs, context),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.primary,
        ),
        child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          left: true,
          right: true,
          bottom: true,
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return Column(
                        children: [
                          Expanded(child: Header()),
                          const SizedBox(height: 32),
                          Expanded(child: Actions()),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(child: Header()),
                          const SizedBox(height: 32),
                          Expanded(child: Actions()),
                        ],
                      );
                    }
                  },
                ),
              ),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Adjust the radius as needed
                ),
                color: AppColors.menuBackground,
                icon: const Icon(Icons.menu, color: AppColors.onPrimary),
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.pushNamed(context, '/user-settings');
                  } else if (value == 2) {
                    Navigator.pushNamed(context, '/pick-avatar');
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(value: 1, child: Text('User settings')),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Pick an avatar'),
                      ),
                    ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final size = width > height ? height : width;
              return Hero(
                tag: 'avatar',
                child: AvatarView(
                  size: size,
                  imagePath: context
                      .watch<HomeScreenViewModel>()
                      .selectedAvatar
                      .imagePath,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Welcome ${
            context
                .watch<UserPreferences>()
                .name
          }',
          style: TextStyle(
            fontSize: 28,
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  List<DropdownMenuEntry> getDurationDropdownMenuEntries() {
    return MeditationDuration.values
        .map(
          (duration) => DropdownMenuEntry(
            label: duration.name,
            value: duration,
          ),
        )
        .toList();
  }

  List<DropdownMenuEntry> getSoundDropdownMenuEntries() {
    return MeditationSound.values
        .map(
          (sound) => DropdownMenuEntry(
            label: sound.name,
            value: sound,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 350,
      ),
      child: Column(
        children: [
          CustomDropdownMenu(
            items: getDurationDropdownMenuEntries(),
            initialSelection: context.watch<HomeScreenViewModel>().selectedDuration,
            leadingIcon: Icons.timer_outlined,
            newValueSelected: (newValue) {
              context.read<HomeScreenViewModel>().selectedDuration = newValue;
            },
          ),
          const SizedBox(height: 20),
          CustomDropdownMenu(
            items: getSoundDropdownMenuEntries(),
            initialSelection: context.watch<HomeScreenViewModel>().selectedSound,
            leadingIcon: Icons.music_note_rounded,
            newValueSelected: (newValue) {
              context.read<HomeScreenViewModel>().selectedSound = newValue;
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;
                  return RoundedButton(
                    size: height,
                    buttonAction: context.read<HomeScreenViewModel>().startMeditationSessionButtonPressed,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.onPrimary,
                      size: height > 120 ? 40 : height * 0.3,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
