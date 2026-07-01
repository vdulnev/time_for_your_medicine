import 'package:flutter/material.dart';

/// The large checkmark badge that pops in on the Done screen (mirrors the
/// prototype's `pop` keyframe animation: scale .6→1.08→1 with a fade-in).
class PopCheck extends StatelessWidget {
  const PopCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      builder: (context, t, child) {
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.scale(scale: t, child: child),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 86,
          height: 86,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 46,
            color: Color(0xFF5566D6),
          ),
        ),
      ),
    );
  }
}
