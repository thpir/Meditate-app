import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:meditate_app/data/services/logging_service.dart';
import 'package:meditate_app/data/services/shared_prefs_service.dart';
import 'package:meditate_app/domain/models/water_volume.dart';

/// Keeps track of today's water intake.
///
/// Only today's total is kept (no history): the intake is stored together with
/// the date it belongs to, and it is reset to 0 as soon as that date is no
/// longer today.
class WaterIntakeRepository extends ChangeNotifier {
  final SharedPrefsService _prefsService;
  final _loggingService = LoggingService();
  final DateTime Function() _now;

  var _intakeMl = 0;
  var _intakeDate = '';
  WaterVolume _selectedVolume = WaterVolume.defaultVolume;
  var _loaded = false;
  late final Future<void> _ready;

  /// [prefsService] and [now] can be injected for testing.
  WaterIntakeRepository({
    SharedPrefsService? prefsService,
    DateTime Function()? now,
  }) : _prefsService = prefsService ?? SharedPrefsService(),
       _now = now ?? DateTime.now {
    _ready = _load();
  }

  int get intakeMl => _intakeMl;
  WaterVolume get selectedVolume => _selectedVolume;
  bool get loaded => _loaded;

  /// Completes once the stored values have been loaded.
  Future<void> get ready => _ready;

  /// Formats [date] as `yyyy-MM-dd`, the format the intake date is stored in.
  static String dateKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  Future<void> _load() async {
    _loggingService.d('Loading water intake from SharedPreferences');
    try {
      _intakeDate = await _prefsService.getString(
        SharedPrefsService.WATER_INTAKE_DATE_KEY,
      );
      _intakeMl = await _prefsService.getInt(SharedPrefsService.WATER_INTAKE_KEY);
      _selectedVolume = WaterVolume.fromMl(
        await _prefsService.getInt(SharedPrefsService.WATER_VOLUME_KEY),
      );
    } catch (e) {
      _loggingService.e('Error loading water intake, using defaults: $e');
      _intakeDate = '';
      _intakeMl = 0;
      _selectedVolume = WaterVolume.defaultVolume;
    }
    _loaded = true;
    await refreshDay();
    notifyListeners();
  }

  /// Resets the intake to 0 when the stored intake belongs to another day.
  Future<void> refreshDay() async {
    if (!_loaded) {
      return;
    }
    final today = dateKey(_now());
    if (_intakeDate == today) {
      return;
    }
    _loggingService.i('Water intake date $_intakeDate is not today ($today), resetting intake');
    _intakeDate = today;
    _intakeMl = 0;
    notifyListeners();
    await _persistIntake();
  }

  /// Adds the [selectedVolume] to today's intake.
  Future<void> add() async {
    if (!_loaded) {
      return;
    }
    await refreshDay();
    _intakeMl += _selectedVolume.ml;
    notifyListeners();
    await _persistIntake();
  }

  /// Removes the [selectedVolume] from today's intake, never going below 0.
  Future<void> subtract() async {
    if (!_loaded) {
      return;
    }
    await refreshDay();
    _intakeMl = max(0, _intakeMl - _selectedVolume.ml);
    notifyListeners();
    await _persistIntake();
  }

  Future<void> selectVolume(WaterVolume volume) async {
    _selectedVolume = volume;
    notifyListeners();
    try {
      await _prefsService.setInt(SharedPrefsService.WATER_VOLUME_KEY, volume.ml);
    } catch (e) {
      _loggingService.e('Error saving selected water volume: $e');
    }
  }

  Future<void> _persistIntake() async {
    try {
      await _prefsService.setString(
        SharedPrefsService.WATER_INTAKE_DATE_KEY,
        _intakeDate,
      );
      await _prefsService.setInt(SharedPrefsService.WATER_INTAKE_KEY, _intakeMl);
    } catch (e) {
      _loggingService.e('Error saving water intake: $e');
    }
  }
}
