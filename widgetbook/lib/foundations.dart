import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:widgetbook/widgetbook.dart';

/// Colors and typography of the Meditate design system.
final List<WidgetbookNode> foundations = [
  WidgetbookComponent(
    name: 'Colors',
    useCases: [
      WidgetbookUseCase(name: 'Palette', builder: (context) => const _Palette()),
    ],
  ),
  WidgetbookComponent(
    name: 'Typography',
    useCases: [
      WidgetbookUseCase(
        name: 'Nunito',
        builder: (context) => const _Typography(),
      ),
    ],
  ),
];

class _Palette extends StatelessWidget {
  const _Palette();

  static const _colors = <(String, Color)>[
    ('primary', AppColors.primary),
    ('secondary', AppColors.secondary),
    ('tertiary', AppColors.tertiary),
    ('quaternary', AppColors.quaternary),
    ('onPrimary', AppColors.onPrimary),
    ('menuBackground', AppColors.menuBackground),
  ];

  static String _hex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          for (final (name, color) in _colors)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140,
                  height: 90,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.onPrimary, width: 1),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'AppColors.$name',
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _hex(color),
                  style: const TextStyle(color: AppColors.onPrimary),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Typography extends StatelessWidget {
  const _Typography();

  // The text styles used across the app's screens.
  static const _styles = <(String, String, TextStyle)>[
    (
      'Greeting (home)',
      'Welcome Gimli',
      TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    ),
    (
      'Timer / water amount',
      '00:12 · 1.20 L / 2.00 L',
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    ),
    (
      'Screen title',
      'User settings',
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    ),
    (
      'Field / dropdown / duration',
      '5 minutes',
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    (
      'Chip',
      '200 ml',
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    ('Body regular', 'Train your mindfulness', TextStyle(fontSize: 16)),
    (
      'Body italic',
      'Train your mindfulness',
      TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      shrinkWrap: true,
      children: [
        for (final (name, sample, style) in _styles) ...[
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              color: AppColors.onPrimary.withValues(alpha: 0.7),
            ),
          ),
          Text(
            sample,
            style: style.copyWith(
              fontFamily: 'Nunito',
              color: AppColors.onPrimary,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
