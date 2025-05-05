import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;
  MeditationDuration _selectedDuration = MeditationDuration.min5;
  MeditationSound _selectedSound = MeditationSound.none;
  Avatar _selectedAvatar = Avatar.sofie;
  String _name = '';

  HomeScreenViewModel(this._userPreferences) {
    _loadUserPreferences();
  }

  MeditationDuration get selectedDuration => _selectedDuration;
  MeditationSound get selectedSound => _selectedSound;
  Avatar get selectedAvatar => _selectedAvatar;
  String get name => _name;

  set selectedDuration(MeditationDuration value) {
    _selectedDuration = value;
    _userPreferences.duration = value;
    notifyListeners();
  }

  set selectedSound(MeditationSound value) {
    _selectedSound = value;
    _userPreferences.sound = value;
    notifyListeners();
  }

  set selectedAvatar(Avatar value) {
    _selectedAvatar = value;
    _userPreferences.avatar = value;
    notifyListeners();
  }

  void _loadUserPreferences() {
    _selectedDuration = _userPreferences.duration;
    _selectedSound = _userPreferences.sound;
    _selectedAvatar = _userPreferences.avatar;
    _name = _userPreferences.name;
    notifyListeners();
  }
}