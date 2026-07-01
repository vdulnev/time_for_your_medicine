import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Temporary body for pages not yet implemented. Replaced as each feature
/// phase lands.
class PlaceholderBody extends StatelessWidget {
  const PlaceholderBody({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          '$title\ncoming soon',
          textAlign: TextAlign.center,
          style: AppText.bricolage(size: 18, color: AppColors.muted),
        ),
      ),
    );
  }
}
