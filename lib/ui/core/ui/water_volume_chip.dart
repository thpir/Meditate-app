import 'package:flutter/widgets.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

/// A selectable pill in the style of [CustomDropdownMenu] / [CustomTextField]:
/// a light green outer pill around a gradient pill with a thin border.
/// When [selected], the inner pill turns dark with light text.
class WaterVolumeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const WaterVolumeChip({
    required this.label,
    this.selected = false,
    this.onTap,
    super.key,
  });

  static const _animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.tertiary,
            borderRadius: BorderRadius.circular(40),
          ),
          child: AnimatedContainer(
            duration: _animationDuration,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: selected ? AppColors.onPrimary : AppColors.primary,
                width: 1,
              ),
              color: selected ? AppColors.onPrimary : null,
              gradient: selected
                  ? null
                  : const LinearGradient(
                      colors: [
                        AppColors.quaternary,
                        AppColors.quaternary,
                        AppColors.tertiary,
                        AppColors.tertiary,
                        AppColors.primary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: selected ? AppColors.quaternary : AppColors.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
