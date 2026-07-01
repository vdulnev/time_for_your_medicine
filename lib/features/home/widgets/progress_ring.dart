import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// A circular progress ring with a hollow center (mirrors the design's
/// conic-gradient ring).
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.percent,
    required this.child,
    this.size = 40,
    this.thickness = 5,
  });

  final int percent;
  final double size;
  final double thickness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(percent / 100, thickness),
        child: Center(child: child),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.fraction, this.thickness);

  final double fraction;
  final double thickness;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2 - thickness / 2;

    final track = Paint()
      ..color = AppColors.ringTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    canvas.drawCircle(center, radius, track);

    if (fraction <= 0) return;
    final arc = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * fraction.clamp(0, 1),
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction || old.thickness != thickness;
}
