import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallet.dart';

class AppTheme {
  static border([Color color= AppPallete.borderColor])=>OutlineInputBorder(
        borderSide:  BorderSide(
          color: color,
        ),
        borderRadius: BorderRadius.circular(10)
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: border(),
      border: border(),
      focusedBorder: border(AppPallete.gradient2),
      errorBorder: border(AppPallete.errorColor)
    )
  );
  
}
