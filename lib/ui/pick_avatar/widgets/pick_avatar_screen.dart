import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';
import 'package:meditate_app/ui/core/ui/selected_badge.dart';
import 'package:meditate_app/ui/pick_avatar/view_model/pick_avatar_view_model.dart';
import 'package:provider/provider.dart';

class PickAvatarScreen extends StatelessWidget {
  static const routeName = '/pick-avatar';
  const PickAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);

    return ChangeNotifierProvider(
      create: (_) => PickAvatarViewModel(userPrefs),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text(
            'Pick an avatar',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.onPrimary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const AvatarListView(),
      ),
    );
  }
}

class AvatarListView extends StatelessWidget {
  const AvatarListView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

  List<Widget> populateWrapWithAvatars() {
      final List<Widget> avatarWidgets = [];
      final List<Avatar> avatars = Avatar.values.toList();
      for (final avatar in avatars) {
        final double avatarSize = screenWidth > 400 ? 160 : screenWidth * 0.4;
        avatarWidgets.add(
          SizedBox.square(
            dimension: avatarSize,
            child: Stack(
              fit: StackFit.loose,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<PickAvatarViewModel>().selectedAvatar = avatar;
                  },
                  child: AvatarView(
                    size: avatarSize,
                    imagePath: avatar.imagePath,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: avatar.id == context.watch<PickAvatarViewModel>().selectedAvatar.id,
                    child: SelectedBadge(size: avatarSize / 4),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return avatarWidgets;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 16 + MediaQuery.of(context).padding.top,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 20,
            runSpacing: 20,
            children: [...populateWrapWithAvatars()],
          ),
        ),
      ),
    );
  }
}
