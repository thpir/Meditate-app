import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;

  HomeScreenViewModel(this._userPreferences);

  MeditationDuration get selectedDuration => _userPreferences.duration;
  MeditationSound get selectedSound => _userPreferences.sound;
  Avatar get selectedAvatar => _userPreferences.avatar;
  String get name => _userPreferences.name;

  set selectedDuration(MeditationDuration value) {
    _userPreferences.duration = value;
  }

  set selectedSound(MeditationSound value) {
    _userPreferences.sound = value;
  }
}
