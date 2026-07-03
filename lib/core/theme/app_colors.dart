import 'package:flutter/material.dart';

/// Design tokens (colors) extracted from the Pillnote design handoff.
///
/// Keep these in sync with SPEC.md §3.
abstract final class AppColors {
  const AppColors._();

  // Brand + backgrounds
  static const Color primary = Color(0xFF5566D6);
  static const Color appBg = Color(0xFFEDEAF3);
  static const Color screenBg = Color(0xFFFCFBFE);

  // Text / ink
  static const Color ink = Color(0xFF28253D);
  static const Color ink2 = Color(0xFF52507A);
  static const Color muted = Color(0xFF807CA0);
  static const Color muted2 = Color(0xFFA6A2C0);
  static const Color muted3 = Color(0xFFB6B2CC);

  // Surfaces
  static const Color surface = Color(0xFFF4F3FB);
  static const Color surface2 = Color(0xFFF0EEF8);
  static const Color surfaceIndigo = Color(0xFFE7E8FB);
  static const Color card = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFF2F0F8);
  static const Color track = Color(0xFFF0EEF8);
  static const Color ringTrack = Color(0xFFE2E0EF);
  static const Color checkBorder = Color(0xFFDAD7E8);

  // Status / accents
  static const Color danger = Color(0xFFD9533A);
  static const Color success = Color(0xFF3E9C73);
  static const Color successBg = Color(0xFFEAF4EF);
  static const Color successDot = Color(0xFF5BAE8A);

  // Refill alert
  static const Color alertBg = Color(0xFFFBEFE9);
  static const Color alertIcon = Color(0xFFF2C6B4);
  static const Color alertInk = Color(0xFF9A3F26);
  static const Color alertInk2 = Color(0xFFC0573A);
  static const Color alertBar = Color(0xFFE8896B);

  // Delete dialog
  static const Color deleteBg = Color(0xFFFBEAE4);

  // Progress bar mid tone
  static const Color primarySoft = Color(0xFFA6B0EE);
  static const Color primaryFaint = Color(0xFFC3C7F4);

  /// Standard elevated-card shadow (approx `0 4px 14px -5px rgba(60,55,90,.12)`).
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x1F3C375A),
      blurRadius: 14,
      offset: Offset(0, 4),
      spreadRadius: -5,
    ),
  ];
}
