import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final _border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppPallete.borderColor, width: 3),
      borderRadius: BorderRadius.circular(10));
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,

    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border,
      focusedBorder: _border.copyWith(
        borderSide: const BorderSide(color: AppPallete.gradient2, width: 3),
      ),
    ),
  );
}
