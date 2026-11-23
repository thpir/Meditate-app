// ignore_for_file: constant_identifier_names

import 'package:meditate_app/data/services/logging_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const NAME_KEY = 'name';
  static const AVATAR_KEY = 'avatar';
  static const DURATION_KEY = 'duration';
  static const SOUND_KEY = 'sound';
  static const WATER_GOAL_KEY = 'water_goal_ml';
  static const WATER_VOLUME_KEY = 'water_volume_ml';
  static const WATER_INTAKE_KEY = 'water_intake_ml';
  static const WATER_INTAKE_DATE_KEY = 'water_intake_date';
  final _loggingService = LoggingService();
  late SharedPreferences _prefs;

  Future<void> setString(String key, String value) async {
    try {
      _loggingService.i('Saving string to SharedPreferences: $key = $value');
      _prefs = await SharedPreferences.getInstance();
      await _prefs.setString(key, value);
    } catch (e) {
      _loggingService.e('Error saving string to SharedPreferences: $e');
      throw Exception('Error saving string to SharedPreferences: $e');
    }
  }

  Future<String> getString(String key) async {
    try {
      _loggingService.i('Retrieving string from SharedPreferences: $key');
      _prefs = await SharedPreferences.getInstance();
      return _prefs.getString(key) ?? '';
    } catch (e) {
      _loggingService.e('Error retrieving string from SharedPreferences: $e');
      throw Exception('Error retrieving string from SharedPreferences: $e');
    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      _loggingService.i('Saving int to SharedPreferences: $key = $value');
      _prefs = await SharedPreferences.getInstance();
      await _prefs.setInt(key, value);
    } catch (e) {
      _loggingService.e('Error saving int to SharedPreferences: $e');
      throw Exception('Error saving int to SharedPreferences: $e');
    }
  }

  Future<int> getInt(String key) async {
    try {
      _loggingService.i('Retrieving int from SharedPreferences: $key');
      _prefs = await SharedPreferences.getInstance();
      return _prefs.getInt(key) ?? 0;
    } catch (e) {
      _loggingService.e('Error retrieving int from SharedPreferences: $e');
      throw Exception('Error retrieving int from SharedPreferences: $e');
    }
  }
}