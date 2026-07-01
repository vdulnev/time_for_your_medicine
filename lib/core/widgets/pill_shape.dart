import 'package:flutter/material.dart';

import '../models/medicine.dart';
import '../models/pill_kind.dart';

/// Renders the little pill glyph used throughout the app: a two-tone rotated
/// capsule or a solid round tablet.
class PillShape extends StatelessWidget {
  const PillShape({
    super.key,
    required this.kind,
    required this.c1,
    this.c2,
    required this.capsuleWidth,
    required this.capsuleHeight,
    required this.capsuleRadius,
    required this.roundSize,
  });

  /// Convenience constructor for a [Medicine]'s own colors at a given scale.
  factory PillShape.forMedicine(
    Medicine med, {
    required double capsuleWidth,
    required double capsuleHeight,
    required double capsuleRadius,
    required double roundSize,
  }) {
    return PillShape(
      kind: med.kind,
      c1: Color(med.c1),
      c2: med.c2 == null ? null : Color(med.c2 ?? med.c1),
      capsuleWidth: capsuleWidth,
      capsuleHeight: capsuleHeight,
      capsuleRadius: capsuleRadius,
      roundSize: roundSize,
    );
  }

  final PillKind kind;
  final Color c1;
  final Color? c2;
  final double capsuleWidth;
  final double capsuleHeight;
  final double capsuleRadius;
  final double roundSize;

  @override
  Widget build(BuildContext context) {
    if (kind == PillKind.round) {
      return Container(
        width: roundSize,
        height: roundSize,
        decoration: BoxDecoration(color: c1, shape: BoxShape.circle),
      );
    }
    return Transform.rotate(
      angle: -28 * 3.1415926535 / 180,
      child: Container(
        width: capsuleWidth,
        height: capsuleHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(capsuleRadius),
          gradient: LinearGradient(
            colors: [c1, c2 ?? c1],
            stops: const [0.5, 0.5],
          ),
        ),
      ),
    );
  }
}
