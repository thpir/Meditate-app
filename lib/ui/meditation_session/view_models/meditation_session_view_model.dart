import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';

class MeditationSessionViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;

  MeditationSessionViewModel(this._userPreferences);

  Avatar get selectedAvatar => _userPreferences.avatar;
}