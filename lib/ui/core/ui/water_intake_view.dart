import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/water_painter.dart';

/// Shows today's water intake as animated water inside the app's ringed
/// circle (same frame as [AvatarView] / [RoundedButton]).
///
/// [progress] is the intake divided by the daily goal: 0.4 = 40%. Values above
/// 1 keep the circle full while the label shows the real percentage. The water
/// rises from empty when the widget first appears, and moves from the current
/// level to the new one whenever [progress] changes.
class WaterIntakeView extends StatefulWidget {
  final double size;
  final double progress;

  const WaterIntakeView({required this.size, required this.progress, super.key});

  @override
  State<WaterIntakeView> createState() => _WaterIntakeViewState();
}

class _WaterIntakeViewState extends State<WaterIntakeView>
    with TickerProviderStateMixin {
  static const Curve _riseCurve = Cubic(0.22, 0.8, 0.3, 1);
  static const _introDuration = Duration(milliseconds: 2500);
  static const _changeDuration = Duration(milliseconds: 900);

  final _time = ValueNotifier<double>(0);
  final _level = ValueNotifier<double>(0);
  late final Ticker _ticker;
  late final AnimationController _levelController;
  Curve _curve = const Interval(0.12, 1, curve: _riseCurve); // 0.3 s delay
  double _from = 0;
  double _to = 0;
  var _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _to = _target;
    _ticker = createTicker((elapsed) {
      _time.value = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    });
    _levelController = AnimationController(vsync: this, duration: _introDuration)
      ..addListener(_updateLevel);
  }

  double get _target => max(0, widget.progress);

  void _updateLevel() {
    _level.value = _from + (_to - _from) * _curve.transform(_levelController.value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (_reduceMotion) {
      _ticker.stop();
      _levelController.stop();
      _level.value = _to;
    } else if (!_ticker.isActive) {
      _ticker.start();
      if (_level.value != _to) {
        _levelController.forward(from: 0);
      }
    }
  }

  @override
  void didUpdateWidget(WaterIntakeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_target == _to) {
      return;
    }
    _from = _level.value;
    _to = _target;
    if (_reduceMotion) {
      _level.value = _to;
      return;
    }
    _curve = _riseCurve;
    _levelController
      ..duration = _changeDuration
      ..forward(from: 0);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _levelController.dispose();
    _time.dispose();
    _level.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double ringPadding = size * 0.04 > 16 ? 16 : size * 0.04;
    return Semantics(
      label: 'Water intake ${WaterPainter.percentageFor(_target)}% of daily goal',
      image: true,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(ringPadding),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.tertiary,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1),
            gradient: const LinearGradient(
              colors: [
                AppColors.quaternary,
                AppColors.tertiary,
                AppColors.primary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: RepaintBoundary(
            child: SizedBox.expand(
              child: CustomPaint(
                painter: WaterPainter(
                  time: _time,
                  level: _level,
                  pulse: _to == 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
