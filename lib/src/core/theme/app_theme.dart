import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/theme/app_colors.dart';
import 'package:flutter_boilerplate/src/core/theme/app_text_styles.dart';

abstract final class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
    ),
    useMaterial3: true,
  );
}
