import 'package:flutter/material.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/data/services/audio_service.dart';
import 'package:meditate_app/data/services/logging_service.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';
import 'package:vibration/vibration.dart';

class MeditationSessionViewModel extends ChangeNotifier {
  final LoggingService _loggingService = LoggingService();
  final UserPreferences _userPreferences;
  final MeditationDuration duration;
  final MeditationSound sound;
  late AudioService _audioService;
  bool _isPlaying = false;
  int _timePassed = 0;

  MeditationSessionViewModel(
    this._userPreferences, {
    required this.duration,
    required this.sound,
  }) {
    _loggingService.d("constructing MeditationSessionViewModel");
    _audioService = AudioService();
    KeepScreenOn.turnOn();
    _initSession();
  }

  @override
  Future<void> dispose() async {
    _loggingService.d("disposing MeditationSessionViewModel");
    KeepScreenOn.turnOff();
    _isPlaying = false;
    if (sound.audioPath != null) {
      await _audioService.dispose();
    }
    super.dispose();
  }

  Avatar get selectedAvatar => _userPreferences.avatar;
  double get progress => _timePassed / duration.duration.inSeconds;
  String get timePassed {
    final minutes = (_timePassed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timePassed % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get durationText {
    final minutes = (duration.duration.inSeconds ~/ 60).toString().padLeft(
      2,
      '0',
    );
    final seconds = (duration.duration.inSeconds % 60).toString().padLeft(
      2,
      '0',
    );
    return '$minutes:$seconds';
  }

  bool get isPlaying => _isPlaying;

  void playButtonPressed() {
    if (_isPlaying) {
      _pauseSession();
    } else {
      _startSession();
    }
  }

  Future<void> _initSession() async {
    await _initAudio();
    _startSession();
  }

  Future<void> _initAudio() async {
    if (sound.audioPath != null) {
      await _audioService.initiateAudio(sound.audioPath!);
    }
  }

  void _startSession() async {
    _isPlaying = true;
    if (sound.audioPath != null) {
      _audioService.playAudio();
    }
    _timerTick();
    notifyListeners();
  }

  void _timerTick() async {
    while (_isPlaying) {
      await Future.delayed(const Duration(seconds: 1));
      if (_isPlaying) {
        _timePassed++;
        notifyListeners();
      }
      if (_sessionIsOver()) {
        _pauseSession();
        _stopSession();
        await _notifyUserWithVibration();
        break;
      }
    }
  }

  bool _sessionIsOver() => _timePassed >= duration.duration.inSeconds;

  void _pauseSession() {
    _isPlaying = false;
    if (sound.audioPath != null) {
      _audioService.pauseAudio();
    }
    notifyListeners();
  }

  void _stopSession() {
    _timePassed = 0;
    if (sound.audioPath != null) {
      _audioService.stopAudio();
    }
    notifyListeners();
  }

  Future<void> _notifyUserWithVibration() async {
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate();
    }
  }
}
