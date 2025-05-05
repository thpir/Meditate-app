// ignore_for_file: constant_identifier_names

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String NAME_KEY = 'name';
  static const String AVATAR_KEY = 'avatar';
  static const String DURATION_KEY = 'duration';
  static const String SOUND_KEY = 'sound';
  final Logger _logger = Logger();
  late SharedPreferences _prefs;

  Future<void> setString(String key, String value) async {
    try {
      _logger.i('Saving string to SharedPreferences: $key = $value');
      _prefs = await SharedPreferences.getInstance();
      await _prefs.setString(key, value);
    } catch (e) {
      _logger.e('Error saving string to SharedPreferences: $e');
      throw Exception('Error saving string to SharedPreferences: $e');
    }
  }

  Future<String> getString(String key) async {
    try {
      _logger.i('Retrieving string from SharedPreferences: $key');
      _prefs = await SharedPreferences.getInstance();
      return _prefs.getString(key) ?? '';
    } catch (e) {
      _logger.e('Error retrieving string from SharedPreferences: $e');
      throw Exception('Error retrieving string from SharedPreferences: $e');
    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      _logger.i('Saving int to SharedPreferences: $key = $value');
      _prefs = await SharedPreferences.getInstance();
      await _prefs.setInt(key, value);
    } catch (e) {
      _logger.e('Error saving int to SharedPreferences: $e');
      throw Exception('Error saving int to SharedPreferences: $e');
    }
  }

  Future<int> getInt(String key) async {
    try {
      _logger.i('Retrieving int from SharedPreferences: $key');
      _prefs = await SharedPreferences.getInstance();
      return _prefs.getInt(key) ?? 0;
    } catch (e) {
      _logger.e('Error retrieving int from SharedPreferences: $e');
      throw Exception('Error retrieving int from SharedPreferences: $e');
    }
  }
}