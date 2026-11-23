import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class AvatarView extends StatelessWidget {
  final double size;
  final String imagePath;
  const AvatarView({required this.size, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    final double avatarPadding = size * 0.04 > 16 ? 16 : size * 0.04;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(avatarPadding),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.tertiary,
      ),
      child: Container(
        width: size - (avatarPadding * 2),
        height: size - (avatarPadding * 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 1),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
