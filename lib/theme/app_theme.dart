import 'package:flutter/material.dart';
import 'package:jarvis/theme/app_colors.dart';

class AppTheme {
  static lightTheme() {
    return ThemeData(
      fontFamily: 'Cera Pro',
      useMaterial3: true,
      colorScheme: lightColorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static darkTheme() {
    return ThemeData(
      fontFamily: 'Cera Pro',
      useMaterial3: true,
      colorScheme: darkColorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
