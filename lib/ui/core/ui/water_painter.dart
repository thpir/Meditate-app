import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';

/// Paints the animated water illustration from the water intake SVG design
/// (`source_images/water_intake_source_files`, `assets/images/water_intake`).
///
/// All geometry is expressed in the SVG's own coordinate space (viewBox
/// `10 10 220 220`: a circle with centre (120, 120) and radius 110) and the
/// canvas is scaled to the available size, so the numbers below map 1:1 to the
/// SVG design.
class WaterPainter extends CustomPainter {
  /// Seconds since the animation started; drives waves, bubbles and the pulse.
  final ValueListenable<double> time;

  /// Animated progress towards the daily goal. 1.0 = goal reached; values
  /// above 1 keep the circle full while the label keeps counting (e.g. 120%).
  final ValueListenable<double> level;

  /// Whether the drop icon pulses (used for the empty, 0% state).
  final bool pulse;

  WaterPainter({required this.time, required this.level, required this.pulse})
    : super(repaint: Listenable.merge([time, level]));

  // --- Design values (taken from the SVG generator) -------------------------
  static const double _viewBoxOrigin = 10;
  static const double _viewBoxSize = 220;
  static const _center = Offset(120, 120);
  static const double _radius = 110;
  static const double _bottom = 230;
  static const double _margin = 9; // keeps waves hidden at 0% / covering at 100%

  static const _waterTop = Color(0xFF858CC4);
  static const _waterBottom = Color(0xFF535A91);
  static const _waterBack = Color(0xFF8E95C8);
  static const _lightLabel = Color(0xFFFFFFFF);

  static const double _frontPeriod = 120, _frontAmplitude = 6, _frontLoop = 4;
  static const double _backPeriod = 160, _backAmplitude = 5, _backLoop = 6.5;

  static const List<double> _bubbleX = [92, 150, 118, 170, 72, 136];
  static const List<double> _bubbleRadius = [3, 2.2, 3.6, 2, 2.6, 1.8];
  static const _bubbleDuration = <double>[3.6, 4.4, 5.2, 3.9, 4.8, 4.1];
  static const _bubbleBegin = 1.62; // rise start + 60% of the rise
  static const _bubbleStagger = 0.7;

  static const double _fontSize = 46;
  // Label block: drop (-13..15) + 12 gap + "x%" whose ink height is set by the
  // '%' glyph in Nunito Bold, so the block is centred identically for every
  // value. Same numbers as the outlined text in the SVGs.
  static const _dropCenterY = 95.92;
  static const _labelBaseline = 156.21;

  String? _cachedLabel;
  TextPainter? _darkText;
  TextPainter? _lightText;

  /// The percentage shown in the label: floored, so 100% only shows once the
  /// goal is actually reached (a tiny epsilon absorbs floating point noise).
  static int percentageFor(double progress) =>
      max(0, (progress * 100 + 1e-6).floor());

  /// Water surface height (in SVG units) for a fill fraction [p] in 0..1.
  static double surfaceY(double p) =>
      (_bottom + _margin) - p * ((_bottom - (_center.dy - _radius)) + 2 * _margin);

  @override
  void paint(Canvas canvas, Size size) {
    final t = time.value;
    final progress = max(0.0, level.value);
    final p = progress.clamp(0.0, 1.0);
    final surface = surfaceY(p);

    canvas.save();
    canvas.scale(size.width / _viewBoxSize, size.height / _viewBoxSize);
    canvas.translate(-_viewBoxOrigin, -_viewBoxOrigin);

    final frontShift = _frontPeriod * ((t % _frontLoop) / _frontLoop);
    final backShift = -_backPeriod * ((t % _backLoop) / _backLoop);
    final frontFill = _wave(-240, 480, _frontPeriod, _frontAmplitude, frontShift, surface, closed: true);

    // Water, clipped to the circle.
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: _center, radius: _radius)));
    canvas.drawPath(
      _wave(-320, 560, _backPeriod, _backAmplitude, backShift, surface - 4, closed: true),
      Paint()..color = _waterBack.withValues(alpha: 0.6),
    );
    canvas.drawPath(
      frontFill,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, surface),
          Offset(0, surface + 230),
          const [_waterTop, _waterBottom],
        ),
    );
    canvas.drawPath(
      _wave(-240, 480, _frontPeriod, _frontAmplitude, frontShift, surface, closed: false),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.secondary.withValues(alpha: 0.85),
    );
    _paintBubbles(canvas, t, p, surface);
    canvas.restore();

    // Label: dark everywhere, white where the water covers it.
    final label = '${percentageFor(progress)}%';
    _updateText(label);
    final dropScale = pulse ? _pulseScale(t) : 1.0;
    _paintLabel(canvas, _darkText!, AppColors.onPrimary, dropScale);
    canvas.save();
    canvas.clipPath(frontFill);
    _paintLabel(canvas, _lightText!, _lightLabel, dropScale);
    canvas.restore();

    canvas.restore();
  }

  /// Builds a wave like the SVG: quadratic segments of half a period whose
  /// control points alternate between -2·amplitude and +2·amplitude.
  Path _wave(
    double x0,
    double x1,
    double period,
    double amplitude,
    double shiftX,
    double surface, {
    required bool closed,
  }) {
    final half = period / 2;
    final path = Path()..moveTo(x0 + shiftX, surface);
    var x = x0;
    var up = true;
    do {
      path.quadraticBezierTo(
        x + half / 2 + shiftX,
        surface + (up ? -2 : 2) * amplitude,
        x + half + shiftX,
        surface,
      );
      x += half;
      up = !up;
    } while (x < x1);
    if (closed) {
      path
        ..lineTo(x + shiftX, surface + 320)
        ..lineTo(x0 + shiftX, surface + 320)
        ..close();
    }
    return path;
  }

  void _paintBubbles(Canvas canvas, double t, double p, double surface) {
    final depth = _bottom - surface;
    if (depth < 28) {
      return;
    }
    final count = 2 + (p * 4).round();
    final start = depth + 6; // below the surface, in px
    const end = 14.0;
    if (start - end < 12) {
      return;
    }
    final paint = Paint();
    for (var i = 0; i < count; i++) {
      final begin = _bubbleBegin + i * _bubbleStagger;
      if (t < begin) {
        continue;
      }
      final duration = _bubbleDuration[i];
      final phase = ((t - begin) % duration) / duration;
      final y = surface + start + (end - start) * phase;
      final x = _bubbleX[i] + _wobble(phase);
      paint.color = _lightLabel.withValues(alpha: _bubbleOpacity(phase));
      canvas.drawCircle(Offset(x, y), _bubbleRadius[i], paint);
    }
  }

  /// Horizontal wobble: x → x+4 → x-3 → x over three equal parts.
  static double _wobble(double phase) {
    if (phase < 1 / 3) {
      return 4 * (phase * 3);
    }
    if (phase < 2 / 3) {
      return 4 - 7 * ((phase - 1 / 3) * 3);
    }
    return -3 + 3 * ((phase - 2 / 3) * 3);
  }

  /// Opacity keyframes 0 → 0.55 → 0.55 → 0 at 0, 0.15, 0.8 and 1.
  static double _bubbleOpacity(double phase) {
    if (phase < 0.15) {
      return 0.55 * (phase / 0.15);
    }
    if (phase < 0.8) {
      return 0.55;
    }
    return 0.55 * (1 - (phase - 0.8) / 0.2);
  }

  /// Drop pulse: 1 → 1.14 → 1 in the first 30% of a 2.4 s cycle (after 0.6 s).
  static double _pulseScale(double t) {
    const begin = 0.6, cycle = 2.4;
    if (t < begin) {
      return 1;
    }
    final phase = ((t - begin) % cycle) / cycle;
    if (phase < 0.15) {
      return 1 + 0.14 * (phase / 0.15);
    }
    if (phase < 0.3) {
      return 1.14 - 0.14 * ((phase - 0.15) / 0.15);
    }
    return 1;
  }

  void _updateText(String label) {
    if (label == _cachedLabel) {
      return;
    }
    _cachedLabel = label;
    _darkText = _layoutText(label, AppColors.onPrimary);
    _lightText = _layoutText(label, _lightLabel);
  }

  static TextPainter _layoutText(String label, Color color) => TextPainter(
    text: TextSpan(
      text: label,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.bold,
        fontSize: _fontSize,
        color: color,
        height: 1,
      ),
    ),
    textDirection: TextDirection.ltr,
    textScaler: TextScaler.noScaling,
  )..layout();

  void _paintLabel(Canvas canvas, TextPainter text, Color color, double dropScale) {
    canvas.save();
    canvas.translate(_center.dx, _dropCenterY);
    canvas.scale(dropScale);
    canvas.drawPath(_drop, Paint()..color = color);
    canvas.restore();

    final baseline = text.computeDistanceToActualBaseline(TextBaseline.alphabetic);
    text.paint(canvas, Offset(_center.dx - text.width / 2, _labelBaseline - baseline));
  }

  /// `M0 -13 C6 -5 10 0 10 5 A10 10 0 0 1 -10 5 C-10 0 -6 -5 0 -13Z`
  static final _drop = Path()
    ..moveTo(0, -13)
    ..cubicTo(6, -5, 10, 0, 10, 5)
    ..arcToPoint(const Offset(-10, 5), radius: const Radius.circular(10))
    ..cubicTo(-10, 0, -6, -5, 0, -13)
    ..close();

  @override
  bool shouldRepaint(WaterPainter oldDelegate) =>
      oldDelegate.time != time ||
      oldDelegate.level != level ||
      oldDelegate.pulse != pulse;
}
