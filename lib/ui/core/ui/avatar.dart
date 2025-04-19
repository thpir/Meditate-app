import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String imagePath;
  const Avatar({required this.size, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.04),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.tertiary
      ),
      child: Container(
        width: size - (size * 0.08),
        height: size - (size * 0.08),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      )
    );
  }
}