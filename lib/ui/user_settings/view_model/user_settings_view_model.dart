import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';

class UserSettingsViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;
  final TextEditingController nameController = TextEditingController();

  UserSettingsViewModel(this._userPreferences) {
    nameController.text = _userPreferences.name;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  String get name => _userPreferences.name;

  set name(String value) {
    _userPreferences.name = value;
  }

  void nameTextFieldOnChanged(String value) {
    name = value;
  }
}