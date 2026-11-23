import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/domain/models/water_goal.dart';
import 'package:meditate_app/ui/core/ui/custom_dropdown_menu.dart';
import 'package:meditate_app/ui/core/ui/custom_text_field.dart';
import 'package:meditate_app/ui/user_settings/view_model/user_settings_view_model.dart';
import 'package:provider/provider.dart';

class UserSettingsScreen extends StatelessWidget {
  static const routeName = '/user-settings';
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
        body: const UserSettingsList(),
      ),
    );
  }
}

class UserSettingsList extends StatelessWidget {
  const UserSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              leadingIcon: Icons.self_improvement_rounded,
              hintText: 'Enter your name',
              controller: context.read<UserSettingsViewModel>().nameController,
              onChanged: context.read<UserSettingsViewModel>().nameTextFieldOnChanged,
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              // Same max width as CustomTextField, so both line up.
              constraints: const BoxConstraints(maxWidth: 400),
              child: CustomDropdownMenu(
                items: WaterGoal.values
                    .map(
                      (goal) => DropdownMenuEntry(
                        label: '${goal.name} per day',
                        value: goal,
                      ),
                    )
                    .toList(),
                initialSelection: context.read<UserSettingsViewModel>().waterGoal,
                leadingIcon: Icons.water_drop_outlined,
                newValueSelected: context.read<UserSettingsViewModel>().waterGoalSelected,
                expand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
