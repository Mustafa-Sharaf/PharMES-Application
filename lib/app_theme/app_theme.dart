import 'package:flutter/material.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData.light().copyWith(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: Colors.blue.withOpacity(0.4),
      selectionHandleColor: Colors.blue,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: Colors.blue.withOpacity(0.4),
      selectionHandleColor: Colors.blue,
    ),

  );
}
