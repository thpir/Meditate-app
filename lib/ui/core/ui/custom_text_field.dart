import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final IconData leadingIcon;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    required this.leadingIcon,
    this.hintText,
    this.controller,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
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
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(
              color: AppColors.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: AppColors.tertiary,
            decoration: InputDecoration(
              prefixIcon: Icon(leadingIcon, color: AppColors.onPrimary),
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.onPrimary.withValues(alpha: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.primary, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
