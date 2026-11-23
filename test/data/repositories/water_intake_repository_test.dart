import 'package:flutter_test/flutter_test.dart';
import 'package:meditate_app/data/repositories/water_intake_repository.dart';
import 'package:meditate_app/data/services/shared_prefs_service.dart';
import 'package:meditate_app/domain/models/water_volume.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DateTime now;

  Future<WaterIntakeRepository> createRepository() async {
    final repository = WaterIntakeRepository(now: () => now);
    await repository.ready;
    return repository;
  }

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    now = DateTime(2026, 11, 23, 9, 30);
  });

  test('starts empty with the default volume of 200 ml', () async {
    final repository = await createRepository();

    expect(repository.loaded, isTrue);
    expect(repository.intakeMl, 0);
    expect(repository.selectedVolume, WaterVolume.ml200);
  });

  test('add accumulates the selected volume', () async {
    final repository = await createRepository();

    await repository.add();
    await repository.selectVolume(WaterVolume.ml500);
    await repository.add();

    expect(repository.intakeMl, 700);
  });

  test('subtract never goes below 0', () async {
    final repository = await createRepository();
    await repository.selectVolume(WaterVolume.ml300);
    await repository.add(); // 300

    await repository.selectVolume(WaterVolume.ml500);
    await repository.subtract();
    expect(repository.intakeMl, 0);

    await repository.subtract();
    expect(repository.intakeMl, 0);
  });

  test('intake and selected volume persist across instances', () async {
    final first = await createRepository();
    await first.selectVolume(WaterVolume.ml100);
    await first.add();
    await first.add();

    final second = await createRepository();

    expect(second.intakeMl, 200);
    expect(second.selectedVolume, WaterVolume.ml100);
  });

  test('stores the intake together with today\'s date', () async {
    final repository = await createRepository();
    await repository.add();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt(SharedPrefsService.WATER_INTAKE_KEY), 200);
    expect(prefs.getString(SharedPrefsService.WATER_INTAKE_DATE_KEY), '2026-11-23');
  });

  test('resets the intake when loaded on a later day', () async {
    SharedPreferences.setMockInitialValues({
      SharedPrefsService.WATER_INTAKE_KEY: 1500,
      SharedPrefsService.WATER_INTAKE_DATE_KEY: '2026-11-22',
      SharedPrefsService.WATER_VOLUME_KEY: 300,
    });

    final repository = await createRepository();

    expect(repository.intakeMl, 0);
    expect(repository.selectedVolume, WaterVolume.ml300); // volume is kept
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt(SharedPrefsService.WATER_INTAKE_KEY), 0);
    expect(prefs.getString(SharedPrefsService.WATER_INTAKE_DATE_KEY), '2026-11-23');
  });

  test('resets when the day changes while the app is running', () async {
    final repository = await createRepository();
    await repository.add();
    await repository.add(); // 400 on the 23rd

    now = DateTime(2026, 11, 24, 0, 5);
    await repository.add(); // first glass of the 24th

    expect(repository.intakeMl, 200);
  });

  test('refreshDay keeps the intake on the same day', () async {
    final repository = await createRepository();
    await repository.add();

    now = DateTime(2026, 11, 23, 23, 59);
    await repository.refreshDay();

    expect(repository.intakeMl, 200);
  });

  test('dateKey formats as yyyy-MM-dd', () {
    expect(WaterIntakeRepository.dateKey(DateTime(2026, 3, 7)), '2026-03-07');
  });
}
