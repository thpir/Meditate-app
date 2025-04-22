import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class UserSettingsScreen extends StatelessWidget {
  static const String routeName = '/user-settings';
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.onPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),     
      ),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        top: false,
        child: Center()
      )
    );
  }
}