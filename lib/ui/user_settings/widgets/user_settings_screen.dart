import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class UserSettingsScreen extends StatefulWidget {
  static const String routeName = '/user-settings';
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
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
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [
          ListTile(
            title: const Text('Username'),
            subtitle: TextField(
              controller: nameController,
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
              onChanged: (value) {
                setState(() {});
              },
            ),
            trailing: nameController.text.isNotEmpty ? IconButton(
              icon: const Icon(Icons.close_rounded),
              color: AppColors.onPrimary,
              onPressed: () {
                nameController.clear();
                setState(() {
                  
                });
              },    
            ) : null,
          )
        ],
      )
    );
  }
}