import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<DropdownMenuEntry> items;
  final IconData leadingIcon;
  final dynamic initialSelection;
  const CustomDropdownMenu({required this.items, required this.leadingIcon, required this.initialSelection, super.key});

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
          gradient: LinearGradient(
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
                side: BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          width: MediaQuery.sizeOf(context).width * 0.8 > 300 ? 300 : MediaQuery.sizeOf(context).width * 0.8,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
          ),
          leadingIcon: Icon(leadingIcon, color: AppColors.onPrimary),
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.onPrimary,
          ),
          initialSelection: initialSelection,
          textStyle: TextStyle(
            color: AppColors.onPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          dropdownMenuEntries: items,
        ),
      ),
    );
  }
}
