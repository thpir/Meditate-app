import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';
import 'package:meditate_app/ui/core/ui/custom_dropdown_menu.dart';
import 'package:meditate_app/ui/core/ui/rounded_button.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  imagePath: 'assets/images/avatar_1.webp',
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Welcome, Thijs',
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

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 350),
      child: Column(
        children: [
          CustomDropdownMenu(
            items: [
              DropdownMenuEntry(label: '5 min', value: '5 min'),
              DropdownMenuEntry(label: '10 min', value: '10 min'),
            ],
            initialSelection: '5 min',
            leadingIcon: Icons.timer_outlined,
          ),
          const SizedBox(height: 20),
          CustomDropdownMenu(
            items: [
              DropdownMenuEntry(label: 'None', value: 'None'),
              DropdownMenuEntry(
                label: 'Birds chirping',
                value: 'Birds chirping',
              ),
            ],
            initialSelection: 'Birds chirping',
            leadingIcon: Icons.music_note_rounded,
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
                    buttonAction: () {
                      Navigator.pushNamed(context, '/meditation-session');
                    },
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
