import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

/// Round check mark badge that marks the selected item (e.g. the chosen
/// avatar). [size] is the badge's diameter.
class SelectedBadge extends StatelessWidget {
  final double size;

  const SelectedBadge({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.onPrimary, width: 1),
        color: AppColors.tertiary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.check,
        color: AppColors.onPrimary,
        size: size * 2 / 3,
      ),
    );
  }
}
