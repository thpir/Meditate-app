import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar.dart';
import 'package:meditate_app/ui/core/ui/custom_dropdown_menu.dart';
import 'package:meditate_app/ui/core/ui/rounded_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: PopupMenuButton(
          icon: const Icon(Icons.menu, color: AppColors.onPrimary),
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 1, child: Text('User settings')),
                const PopupMenuItem(value: 2, child: Text('Pick an avatar')),
              ],
        ),
      ),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        top: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                children: [
                  Expanded(child: Center(child: Header())),
                  Expanded(child: Actions()),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(child: Header()),
                  Expanded(child: Actions()),
                ],
              );
            }
          },
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
        SizedBox(height: AppBar().preferredSize.height),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final size = width > height ? height : width;
              return Avatar(
                size: size,
                imagePath: 'assets/images/avatar_1.webp',
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(28),
          child: Text(
            'Welcome, Thijs',
            style: TextStyle(
              fontSize: 28,
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w600,
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        spacing: 20,
        children: [
          CustomDropdownMenu(
            items: [
              DropdownMenuEntry(label: '5 min', value: '5 min'),
              DropdownMenuEntry(label: '10 min', value: '10 min'),
            ],
            initialSelection: '5 min',
            leadingIcon: Icons.timer_outlined,
          ),
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
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;
                return RoundedButton(
                  size: height,
                  buttonAction: () {},
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.onPrimary,
                    size: height * 0.3,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}