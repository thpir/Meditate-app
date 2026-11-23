import 'package:flutter/widgets.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/data/repositories/water_intake_repository.dart';
import 'package:meditate_app/domain/models/water_volume.dart';

class WaterIntakeViewModel extends ChangeNotifier {
  final UserPreferences _userPreferences;
  final WaterIntakeRepository _repository;
  late final AppLifecycleListener _lifecycleListener;

  WaterIntakeViewModel(this._userPreferences, this._repository) {
    _userPreferences.addListener(notifyListeners);
    _repository.addListener(notifyListeners);
    // A new day may have started since the intake was last loaded or changed.
    _repository.refreshDay();
    _lifecycleListener = AppLifecycleListener(
      onResume: _repository.refreshDay,
    );
  }

  bool get loaded => _repository.loaded;
  int get intakeMl => _repository.intakeMl;
  int get goalMl => _userPreferences.waterGoal.ml;

  /// Intake divided by the daily goal (1.0 = goal reached, can exceed 1).
  double get progress => goalMl <= 0 ? 0 : intakeMl / goalMl;

  /// E.g. `1.20 L / 2.00 L`.
  String get amountLabel => '${_liters(intakeMl)} L / ${_liters(goalMl)} L';

  List<WaterVolume> get volumes => WaterVolume.values;
  WaterVolume get selectedVolume => _repository.selectedVolume;

  void selectVolume(WaterVolume volume) => _repository.selectVolume(volume);
  void addButtonPressed() => _repository.add();
  void subtractButtonPressed() => _repository.subtract();

  static String _liters(int ml) => (ml / 1000).toStringAsFixed(2);

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _userPreferences.removeListener(notifyListeners);
    _repository.removeListener(notifyListeners);
    super.dispose();
  }
}
