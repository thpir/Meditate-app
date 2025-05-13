import 'package:flutter/material.dart';
import 'package:meditate_app/data/services/logging_service.dart';
import 'package:meditate_app/data/services/shared_prefs_service.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';

class UserPreferences extends ChangeNotifier {
  final SharedPrefsService _prefsService = SharedPrefsService();
  final LoggingService _loggingService = LoggingService();
  late String _name;
  late Avatar _avatar;
  late MeditationDuration _duration;
  late MeditationSound _sound;
  bool _prefsLoaded = false;

  UserPreferences() {
    _loadPreferences();
  }

  String get name => _name;
  Avatar get avatar => _avatar;
  MeditationDuration get duration => _duration;
  MeditationSound get sound => _sound;
  bool get prefsLoaded => _prefsLoaded;

  set name(String value) {
    _loggingService.i('Setting name to $value, and saving to SharedPreferences');
    _name = value;
    _prefsService.setString(SharedPrefsService.NAME_KEY, value);
    notifyListeners();
  }

  set avatar(Avatar value) {
    _loggingService.i('Setting avatar to $value, and saving to SharedPreferences');
    _avatar = value;
    _prefsService.setInt(SharedPrefsService.AVATAR_KEY, value.id);
    notifyListeners();
  }

  set duration(MeditationDuration value) {
    _loggingService.i('Setting duration to $value, and saving to SharedPreferences');
    _duration = value;
    _prefsService.setInt(SharedPrefsService.DURATION_KEY, value.id);
    notifyListeners();
  }

  set sound(MeditationSound value) {
    _loggingService.i('Setting sound to $value, and saving to SharedPreferences');
    _sound = value;
    _prefsService.setInt(SharedPrefsService.SOUND_KEY, value.id);
    notifyListeners();
  }

  set prefsLoaded(bool value) {
    _loggingService.d('Finished loading preferences');
    _prefsLoaded = value;
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    _loggingService.d('Loading preferences from SharedPreferences');
    await Future.wait([
          getNameFromPrefs(),
          getAvatarFromPrefs(),
          getDurationFromPrefs(),
          getSoundFromPrefs(),
        ])
        .catchError((e) {
          _loggingService.e('Error loading preferences from SharedPreferences: $e');
          _loadDefaultPreferences();
          return <void>[];
        })
        .whenComplete(() {
          prefsLoaded = true;
          notifyListeners();
        });
  }

  Future<void> getNameFromPrefs() async {
    _name = await _prefsService.getString(SharedPrefsService.NAME_KEY);
    _loggingService.i('Name from SharedPreferences: $_name');
  }

  Future<void> getAvatarFromPrefs() async {
    int avatarId = await _prefsService.getInt(SharedPrefsService.AVATAR_KEY);
    _loggingService.i('Avatar ID from SharedPreferences: $avatarId');
    _avatar = Avatar.values.firstWhere((avatar) => avatar.id == avatarId);
  }

  Future<void> getDurationFromPrefs() async {
    int durationId = await _prefsService.getInt(
      SharedPrefsService.DURATION_KEY,
    );
    _loggingService.i('Duration ID from SharedPreferences: $durationId');
    _duration = MeditationDuration.values.firstWhere(
      (duration) => duration.id == durationId,
    );
  }

  Future<void> getSoundFromPrefs() async {
    int soundId = await _prefsService.getInt(SharedPrefsService.SOUND_KEY);
    _loggingService.i('Sound ID from SharedPreferences: $soundId');
    _sound = MeditationSound.values.firstWhere((sound) => sound.id == soundId);
  }

  void _loadDefaultPreferences() {
    _loggingService.i('Loading default preferences');
    _name = '';
    _avatar = Avatar.values[0];
    _duration = MeditationDuration.values[0];
    _sound = MeditationSound.values[0];
  }
}
