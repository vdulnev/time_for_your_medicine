import 'package:flutter/material.dart';

/// A small decorative confetti shape scattered around the Done celebration.
class ConfettiDot extends StatelessWidget {
  const ConfettiDot({
    super.key,
    required this.size,
    required this.color,
    this.square = false,
    this.angle = 0,
  });

  final double size;
  final Color color;
  final bool square;
  final double angle;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: square ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: square ? BorderRadius.circular(2) : null,
      ),
    );
    if (angle == 0) return dot;
    return Transform.rotate(angle: angle * 3.1415926535 / 180, child: dot);
  }
}
