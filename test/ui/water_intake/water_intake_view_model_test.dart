import 'package:flutter_test/flutter_test.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/data/repositories/water_intake_repository.dart';
import 'package:meditate_app/data/services/shared_prefs_service.dart';
import 'package:meditate_app/domain/models/water_goal.dart';
import 'package:meditate_app/domain/models/water_volume.dart';
import 'package:meditate_app/ui/water_intake/view_model/water_intake_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserPreferences userPreferences;
  late WaterIntakeRepository repository;
  late WaterIntakeViewModel viewModel;

  Future<void> waitForPreferences() async {
    while (!userPreferences.prefsLoaded) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      // Required by UserPreferences' existing loaders.
      SharedPrefsService.AVATAR_KEY: 0,
      SharedPrefsService.DURATION_KEY: 0,
      SharedPrefsService.SOUND_KEY: 0,
      SharedPrefsService.WATER_GOAL_KEY: 2500,
    });
    userPreferences = UserPreferences();
    repository = WaterIntakeRepository(now: () => DateTime(2026, 11, 23));
    await waitForPreferences();
    await repository.ready;
    viewModel = WaterIntakeViewModel(userPreferences, repository);
  });

  tearDown(() => viewModel.dispose());

  test('takes the goal from the user preferences', () {
    expect(viewModel.goalMl, 2500);
    expect(viewModel.amountLabel, '0.00 L / 2.50 L');
  });

  test('progress is intake divided by goal and can exceed 1', () async {
    userPreferences.waterGoal = WaterGoal.ml1000;
    await repository.selectVolume(WaterVolume.ml300);
    await repository.add();
    expect(viewModel.progress, closeTo(0.3, 1e-9));

    for (var i = 0; i < 3; i++) {
      await repository.add();
    }
    expect(viewModel.progress, closeTo(1.2, 1e-9));
    expect(viewModel.amountLabel, '1.20 L / 1.00 L');
  });

  test('notifies when the intake or the goal changes', () async {
    var notifications = 0;
    viewModel.addListener(() => notifications++);

    await repository.add();
    userPreferences.waterGoal = WaterGoal.ml3000;

    expect(notifications, greaterThanOrEqualTo(2));
    expect(viewModel.amountLabel, '0.20 L / 3.00 L');
  });
}
