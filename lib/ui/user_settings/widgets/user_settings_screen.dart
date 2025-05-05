import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/user_settings/view_model/user_settings_view_model.dart';
import 'package:provider/provider.dart';

class UserSettingsScreen extends StatelessWidget {
  static const String routeName = '/user-settings';
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    final userPrefs = Provider.of<UserPreferences>(context);
    return ChangeNotifierProvider(
      create: (_) => UserSettingsViewModel(userPrefs),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text(
            'User settings',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.onPrimary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: UserSettingsList()
      ),
    );
  }
}

class UserSettingsList extends StatelessWidget {
  const UserSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            ListTile(
              title: const Text('Username'),
              subtitle: TextField(
                controller: context.read<UserSettingsViewModel>().nameController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                cursorColor: AppColors.tertiary,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.tertiary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: context.read<UserSettingsViewModel>().nameTextFieldOnChanged,
              ),
              trailing: context.watch<UserSettingsViewModel>().nameController.text.isNotEmpty ? IconButton(
                icon: const Icon(Icons.close_rounded),
                color: AppColors.onPrimary,
                onPressed: () {
                  context.read<UserSettingsViewModel>().nameController.clear();
                  context.read<UserSettingsViewModel>().nameTextFieldOnChanged('');
                },    
              ) : null,
            )
          ],
        );
  }
}