import 'package:flutter/material.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';

class PickAvatarScreen extends StatelessWidget {
  static const String routeName = '/pick-avatar';
  const PickAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final int selectedAvatarId = 1; // TODO: Replace with the actual selected avatar ID

    List<Widget> populateWrapWithAvatars() {
      List<Widget> avatarWidgets = [];
      List<Avatar> avatars = Avatar.values.toList();
      for (Avatar avatar in avatars) {
        final double avatarSize = screenWidth > 400 ? 160 : screenWidth * 0.4;
        avatarWidgets.add(
          SizedBox.square(
            dimension: avatarSize,
            child: Stack(
              fit: StackFit.loose,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: AvatarView(
                    size: avatarSize,
                    imagePath: avatar.imagePath,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: avatar.id == selectedAvatarId,
                    child: Container(
                      width: avatarSize / 4,
                      height: avatarSize / 4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.onPrimary,
                          width: 1,
                        ),
                        color: AppColors.tertiary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check,
                        color: AppColors.onPrimary,
                        size: avatarSize / 6,
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        );
      }
      return avatarWidgets;
    }

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 20,
              children: [...populateWrapWithAvatars()],
            ),
          ),
        ),
      ),
    );
  }
}
