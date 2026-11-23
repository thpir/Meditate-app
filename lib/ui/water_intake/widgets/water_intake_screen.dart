import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/data/repositories/water_intake_repository.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/rounded_button.dart';
import 'package:meditate_app/ui/core/ui/water_intake_view.dart';
import 'package:meditate_app/ui/core/ui/water_volume_chip.dart';
import 'package:meditate_app/ui/water_intake/view_model/water_intake_view_model.dart';
import 'package:provider/provider.dart';

class WaterIntakeScreen extends StatelessWidget {
  static const routeName = '/water-intake';
  const WaterIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    final waterIntake = Provider.of<WaterIntakeRepository>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => WaterIntakeViewModel(userPrefs, waterIntake),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text(
            'Water intake',
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
        body: const WaterIntakeBody(),
      ),
    );
  }
}

class WaterIntakeBody extends StatelessWidget {
  const WaterIntakeBody({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.select<WaterIntakeViewModel, bool>((vm) => vm.loaded)) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.onPrimary),
      );
    }
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              // Circle, amount and controls stay together, centred vertically;
              // the circle takes whatever height is left.
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: WaterIntakeHeader()),
                  SizedBox(height: 32),
                  WaterIntakeControls(),
                ],
              );
            }
            return const Row(
              children: [
                Expanded(child: Center(child: WaterIntakeHeader())),
                SizedBox(width: 32),
                Expanded(child: Center(child: WaterIntakeControls())),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// The water circle with today's amount underneath.
class WaterIntakeHeader extends StatelessWidget {
  const WaterIntakeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WaterIntakeViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          // Largest square that fits the remaining width and height.
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraints) => WaterIntakeView(
                size: min(constraints.maxWidth, constraints.maxHeight),
                progress: viewModel.progress,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          viewModel.amountLabel,
          style: const TextStyle(
            fontSize: 28,
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// The volume chips and the − / + buttons.
class WaterIntakeControls extends StatelessWidget {
  static const double _buttonSize = 80;
  const WaterIntakeControls({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WaterIntakeViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final volume in viewModel.volumes)
              WaterVolumeChip(
                label: volume.label,
                selected: volume == viewModel.selectedVolume,
                onTap: () => viewModel.selectVolume(volume),
              ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              button: true,
              label: 'Remove ${viewModel.selectedVolume.label}',
              child: RoundedButton(
                size: _buttonSize,
                buttonAction: viewModel.subtractButtonPressed,
                child: const Icon(
                  Icons.remove_rounded,
                  color: AppColors.onPrimary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 48),
            Semantics(
              button: true,
              label: 'Add ${viewModel.selectedVolume.label}',
              child: RoundedButton(
                size: _buttonSize,
                buttonAction: viewModel.addButtonPressed,
                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.onPrimary,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
