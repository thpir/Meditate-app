import 'package:flutter_test/flutter_test.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/data/services/shared_prefs_service.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/ui/pick_avatar/view_model/pick_avatar_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserPreferences userPreferences;
  late PickAvatarViewModel viewModel;
  late int notifications;

  Future<void> waitForPreferences() async {
    while (!userPreferences.prefsLoaded) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      // Required by UserPreferences' existing loaders.
      SharedPrefsService.AVATAR_KEY: Avatar.sofie.id,
      SharedPrefsService.DURATION_KEY: 0,
      SharedPrefsService.SOUND_KEY: 0,
    });
    userPreferences = UserPreferences();
    await waitForPreferences();
    viewModel = PickAvatarViewModel(userPreferences);
    notifications = 0;
    viewModel.addListener(() => notifications++);
  });

  tearDown(() => viewModel.dispose());

  test('takes the selected avatar from the user preferences', () {
    expect(viewModel.selectedAvatar, Avatar.sofie);
  });

  test('selecting an avatar saves it to the user preferences', () {
    viewModel.selectedAvatar = Avatar.leo;
    expect(viewModel.selectedAvatar, Avatar.leo);
    expect(userPreferences.avatar, Avatar.leo);
  });

  test('selecting a different avatar notifies listeners once', () {
    viewModel.selectedAvatar = Avatar.nova;
    expect(notifications, 1);
  });

  test('selecting the already selected avatar does not notify', () {
    viewModel.selectedAvatar = Avatar.sofie;
    expect(notifications, 0);
  });
}
