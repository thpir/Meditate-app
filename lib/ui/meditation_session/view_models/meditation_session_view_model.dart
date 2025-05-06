import 'package:flutter/material.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';

class MeditationSessionViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;
  final MeditationDuration duration;
  bool _isPlaying = false;
  int _timePassed = 0;

  MeditationSessionViewModel(this._userPreferences, {required this.duration}) {
    _startTimer();
  }

  @override
  void dispose() {
    _isPlaying = false;
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
    final minutes = (duration.duration.inSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (duration.duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  bool get isPlaying => _isPlaying;

  void playButtonPressed() {
    if (_isPlaying) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _isPlaying = true;
    _timerTick();
    notifyListeners();
  }

  void _stopTimer() {
    _isPlaying = false;
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
        _stopTimer();
        _resetTimer();
        break;
      }
    }
  }

  bool  _sessionIsOver() => _timePassed >= duration.duration.inSeconds;

  void _resetTimer() {
    _timePassed = 0;
    notifyListeners();
  }
}
