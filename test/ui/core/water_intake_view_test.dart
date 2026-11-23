import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meditate_app/ui/core/ui/water_intake_view.dart';
import 'package:meditate_app/ui/core/ui/water_painter.dart';

void main() {
  Widget host(double progress) => Directionality(
    textDirection: TextDirection.ltr,
    child: Center(child: WaterIntakeView(size: 300, progress: progress)),
  );

  for (final progress in [0.0, 0.4, 1.0, 1.2]) {
    testWidgets('renders and animates at progress $progress', (tester) async {
      await tester.pumpWidget(host(progress));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(seconds: 3)); // rise done, bubbles running
      expect(tester.takeException(), isNull);
      expect(find.byType(WaterIntakeView), findsOneWidget);
    });
  }

  testWidgets('semantics label shows the floored percentage', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(host(0.357));
    expect(find.bySemanticsLabel('Water intake 35% of daily goal'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('moves to a new progress and settles there', (tester) async {
    await tester.pumpWidget(host(0.3));
    await tester.pump(const Duration(seconds: 3));

    await tester.pumpWidget(host(0.5));
    await tester.pump(const Duration(milliseconds: 100));
    final painter = tester
        .widget<CustomPaint>(
          find.descendant(
            of: find.byType(WaterIntakeView),
            matching: find.byType(CustomPaint),
          ),
        )
        .painter! as WaterPainter;
    final midway = painter.level.value;
    expect(midway, greaterThan(0.3));
    expect(midway, lessThan(0.5));

    await tester.pump(const Duration(seconds: 1));
    expect(painter.level.value, closeTo(0.5, 1e-9));
  });

  test('percentageFor floors and ignores floating point noise', () {
    expect(WaterPainter.percentageFor(0.35), 35);
    expect(WaterPainter.percentageFor(700 / 2000), 35);
    expect(WaterPainter.percentageFor(0.999), 99);
    expect(WaterPainter.percentageFor(1.0), 100);
    expect(WaterPainter.percentageFor(1.2), 120);
    expect(WaterPainter.percentageFor(-0.1), 0);
  });
}
