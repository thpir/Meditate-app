import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<DropdownMenuEntry> items;
  final IconData leadingIcon;
  final dynamic initialSelection;
  final Function(dynamic)? newValueSelected;

  /// When true, the menu fills the available width (e.g. to line up with a
  /// [CustomTextField]) instead of using its default width of at most 300.
  final bool expand;

  const CustomDropdownMenu({
    required this.items,
    required this.leadingIcon,
    required this.initialSelection,
    this.newValueSelected,
    this.expand = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: DropdownMenu(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.menuBackground),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.primary, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          menuHeight: 200,
          width: expand
              ? null
              : max(100, min(300, MediaQuery.sizeOf(context).width * 0.8)),
          expandedInsets: expand ? EdgeInsets.zero : null,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
          ),
          leadingIcon: Icon(leadingIcon, color: AppColors.onPrimary),
          trailingIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.onPrimary,
          ),
          initialSelection: initialSelection,
          textStyle: const TextStyle(
            color: AppColors.onPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          onSelected: newValueSelected,
          dropdownMenuEntries: items,
        ),
      ),
    );
  }
}
