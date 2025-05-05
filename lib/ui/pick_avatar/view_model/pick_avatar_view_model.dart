import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';

class PickAvatarViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;

  PickAvatarViewModel(this._userPreferences);

  Avatar get selectedAvatar => _userPreferences.avatar;

  set selectedAvatar(Avatar value) {
    _userPreferences.avatar = value;
  }
}
