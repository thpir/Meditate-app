import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/domain/models/avatar.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';
import 'package:meditate_app/domain/models/water_goal.dart';
import 'package:meditate_app/domain/models/water_volume.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';
import 'package:meditate_app/ui/core/ui/custom_dropdown_menu.dart';
import 'package:meditate_app/ui/core/ui/custom_text_field.dart';
import 'package:meditate_app/ui/core/ui/rounded_button.dart';
import 'package:meditate_app/ui/core/ui/selected_badge.dart';
import 'package:meditate_app/ui/core/ui/waiting_screen.dart';
import 'package:meditate_app/ui/core/ui/water_intake_view.dart';
import 'package:meditate_app/ui/core/ui/water_volume_chip.dart';
import 'package:widgetbook/widgetbook.dart';

/// The reusable widgets in `lib/ui/core/ui`.
final List<WidgetbookNode> components = [
  WidgetbookComponent(
    name: 'AvatarView',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => AvatarView(
          size: context.knobs.double.slider(
            label: 'Size',
            initialValue: 300,
            min: 80,
            max: 500,
          ),
          imagePath: context.knobs.object
              .dropdown<Avatar>(
                label: 'Avatar',
                options: Avatar.values,
                initialOption: Avatar.values[4],
                labelBuilder: (avatar) => avatar.name,
              )
              .imagePath,
        ),
      ),
      WidgetbookUseCase(
        name: 'Selected (pick avatar)',
        builder: (context) {
          final size = context.knobs.double.slider(
            label: 'Size',
            initialValue: 160,
            min: 80,
            max: 300,
          );
          return SizedBox.square(
            dimension: size,
            child: Stack(
              children: [
                AvatarView(size: size, imagePath: Avatar.values[4].imagePath),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SelectedBadge(size: size / 4),
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'CustomDropdownMenu',
    useCases: [
      WidgetbookUseCase(
        name: 'Duration',
        builder: (context) => CustomDropdownMenu(
          items: [
            for (final duration in MeditationDuration.values)
              DropdownMenuEntry(label: duration.name, value: duration),
          ],
          initialSelection: MeditationDuration.values.first,
          leadingIcon: Icons.timer_outlined,
        ),
      ),
      WidgetbookUseCase(
        name: 'Sound',
        builder: (context) => CustomDropdownMenu(
          items: [
            for (final sound in MeditationSound.values)
              DropdownMenuEntry(label: sound.name, value: sound),
          ],
          initialSelection: MeditationSound.values.first,
          leadingIcon: Icons.music_note_rounded,
        ),
      ),
      WidgetbookUseCase(
        name: 'Water goal',
        builder: (context) => CustomDropdownMenu(
          items: [
            for (final goal in WaterGoal.values)
              DropdownMenuEntry(label: '${goal.name} per day', value: goal),
          ],
          initialSelection: WaterGoal.defaultGoal,
          leadingIcon: Icons.water_drop_outlined,
        ),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'CustomTextField',
    useCases: [
      WidgetbookUseCase(
        name: 'Name',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16),
          child: CustomTextField(
            leadingIcon: Icons.self_improvement_rounded,
            hintText: context.knobs.string(
              label: 'Hint',
              initialValue: 'Enter your name',
            ),
          ),
        ),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'RoundedButton',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final size = context.knobs.double.slider(
            label: 'Size',
            initialValue: 100,
            min: 40,
            max: 120,
          );
          final icon = context.knobs.object.dropdown<IconData>(
            label: 'Icon',
            options: const [
              Icons.play_arrow_rounded,
              Icons.pause,
              Icons.add_rounded,
              Icons.remove_rounded,
            ],
            labelBuilder: (icon) => switch (icon) {
              Icons.play_arrow_rounded => 'Play',
              Icons.pause => 'Pause',
              Icons.add_rounded => 'Add',
              _ => 'Remove',
            },
          );
          return RoundedButton(
            size: size,
            buttonAction: () {},
            child: Icon(
              icon,
              color: AppColors.onPrimary,
              size: size > 120 ? 40 : size * 0.3,
            ),
          );
        },
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'SelectedBadge',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => SelectedBadge(
          size: context.knobs.double.slider(
            label: 'Size',
            initialValue: 40,
            min: 16,
            max: 120,
          ),
        ),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'WaitingScreen',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => const WaitingScreen(),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'WaterIntakeView',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => WaterIntakeView(
          size: context.knobs.double.slider(
            label: 'Size',
            initialValue: 300,
            min: 120,
            max: 500,
          ),
          progress: context.knobs.double.slider(
            label: 'Progress (1.0 = daily goal)',
            initialValue: 0.4,
            min: 0,
            max: 1.2,
            divisions: 120,
            precision: 2,
          ),
        ),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'WaterVolumeChip',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => WaterVolumeChip(
          label: context.knobs.string(label: 'Label', initialValue: '200 ml'),
          selected: context.knobs.boolean(label: 'Selected', initialValue: true),
          onTap: () {},
        ),
      ),
      WidgetbookUseCase(
        name: 'Volume picker',
        builder: (context) => const _VolumePicker(),
      ),
    ],
  ),
];

/// All volumes as on the water intake screen; tap a chip to select it.
class _VolumePicker extends StatefulWidget {
  const _VolumePicker();

  @override
  State<_VolumePicker> createState() => _VolumePickerState();
}

class _VolumePickerState extends State<_VolumePicker> {
  WaterVolume _selected = WaterVolume.defaultVolume;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final volume in WaterVolume.values)
            WaterVolumeChip(
              label: volume.label,
              selected: volume == _selected,
              onTap: () => setState(() => _selected = volume),
            ),
        ],
      ),
    );
  }
}
