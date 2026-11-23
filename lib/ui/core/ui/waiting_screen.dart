import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.onPrimary),
      ),
    );
  }
}
