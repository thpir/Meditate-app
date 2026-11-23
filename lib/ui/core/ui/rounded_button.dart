import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final double size;
  final VoidCallback buttonAction;
  final Widget child;
  const RoundedButton({
    required this.size,
    required this.child,
    required this.buttonAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonPadding = size * 0.04 > 8 ? 8 : size * 0.04;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 120, maxHeight: 120),
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(buttonPadding),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.tertiary,
        ),
        child: Container(
          width: size - (size * 0.08),
          height: size - (size * 0.08),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1),
            gradient: const LinearGradient(
              colors: [
                AppColors.quaternary,
                AppColors.tertiary,
                AppColors.primary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(child: InkWell(onTap: buttonAction, child: child)),
        ),
      ),
    );
  }
}
