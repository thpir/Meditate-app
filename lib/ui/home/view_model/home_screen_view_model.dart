import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';
import 'package:meditate_app/ui/meditation_session/widgets/meditation_session_screen.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;
  final BuildContext _context;

  HomeScreenViewModel(this._userPreferences, this._context);

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

  void startMeditationSessionButtonPressed() {
    Navigator.of(_context).pushNamed(MeditationSessionScreen.routeName, arguments: {
      'duration': selectedDuration,
      'sound': selectedSound,
    });
  }
}
