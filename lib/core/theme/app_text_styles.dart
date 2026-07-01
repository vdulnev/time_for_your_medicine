import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography helpers for the two design fonts.
///
/// - Bricolage Grotesque → headings & numbers.
/// - Plus Jakarta Sans → body & labels.
abstract final class AppText {
  const AppText._();

  static TextStyle bricolage({
    required double size,
    FontWeight weight = FontWeight.w800,
    Color color = AppColors.ink,
    double height = 1.1,
  }) {
    return GoogleFonts.bricolageGrotesque(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle jakarta({
    required double size,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.ink,
    double height = 1.2,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
