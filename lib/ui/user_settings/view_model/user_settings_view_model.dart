import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/water_goal.dart';

class UserSettingsViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;
  final nameController = TextEditingController();

  UserSettingsViewModel(this._userPreferences) {
    nameController.text = _userPreferences.name;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  String get name => _userPreferences.name;
  WaterGoal get waterGoal => _userPreferences.waterGoal;

  set name(String value) {
    _userPreferences.name = value;
  }

  set waterGoal(WaterGoal value) {
    _userPreferences.waterGoal = value;
  }

  void nameTextFieldOnChanged(String value) {
    name = value;
  }

  void waterGoalSelected(dynamic value) {
    if (value is WaterGoal) {
      waterGoal = value;
    }
  }
}
