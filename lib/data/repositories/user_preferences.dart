import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meditate_app/data/services/shared_prefs_service.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';

class UserPreferences extends ChangeNotifier {
  final SharedPrefsService _prefsService = SharedPrefsService();
  final Logger _logger = Logger();
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
    _logger.i('Setting name to $value, and saving to SharedPreferences');
    _name = value;
    _prefsService.setString(SharedPrefsService.NAME_KEY, value);
    notifyListeners();
  }

  set avatar(Avatar value) {
    _logger.i('Setting avatar to $value, and saving to SharedPreferences');
    _avatar = value;
    _prefsService.setInt(SharedPrefsService.AVATAR_KEY, value.id);
    notifyListeners();
  }

  set duration(MeditationDuration value) {
    _logger.i('Setting duration to $value, and saving to SharedPreferences');
    _duration = value;
    _prefsService.setInt(SharedPrefsService.DURATION_KEY, value.id);
    notifyListeners();
  }

  set sound(MeditationSound value) {
    _logger.i('Setting sound to $value, and saving to SharedPreferences');
    _sound = value;
    _prefsService.setInt(SharedPrefsService.SOUND_KEY, value.id);
    notifyListeners();
  }

  set prefsLoaded(bool value) {
    _logger.i('Finished loading preferences');
    _prefsLoaded = value;
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    _logger.i('Loading preferences from SharedPreferences');
    await Future.wait([
          getNameFromPrefs(),
          getAvatarFromPrefs(),
          getDurationFromPrefs(),
          getSoundFromPrefs(),
        ])
        .catchError((e) {
          _logger.e('Error loading preferences from SharedPreferences: $e');
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
    _logger.i('Name from SharedPreferences: $_name');
  }

  Future<void> getAvatarFromPrefs() async {
    int avatarId = await _prefsService.getInt(SharedPrefsService.AVATAR_KEY);
    _logger.i('Avatar ID from SharedPreferences: $avatarId');
    _avatar = Avatar.values.firstWhere((avatar) => avatar.id == avatarId);
  }

  Future<void> getDurationFromPrefs() async {
    int durationId = await _prefsService.getInt(
      SharedPrefsService.DURATION_KEY,
    );
    _logger.i('Duration ID from SharedPreferences: $durationId');
    _duration = MeditationDuration.values.firstWhere(
      (duration) => duration.id == durationId,
    );
  }

  Future<void> getSoundFromPrefs() async {
    int soundId = await _prefsService.getInt(SharedPrefsService.SOUND_KEY);
    _logger.i('Sound ID from SharedPreferences: $soundId');
    _sound = MeditationSound.values.firstWhere((sound) => sound.id == soundId);
  }

  void _loadDefaultPreferences() {
    _logger.i('Loading default preferences');
    _name = '';
    _avatar = Avatar.values[0];
    _duration = MeditationDuration.values[0];
    _sound = MeditationSound.values[0];
  }
}
