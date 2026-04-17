import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFF0F0F13);
  static const Color surface = Color(0xFF17171E);
  static const Color surface2 = Color(0xFF1F1F2A);
  static const Color surface3 = Color(0xFF27273A);
  static const Color accent = Color(0xFF7C6AF0);
  static const Color accent2 = Color(0xFFA594F9);
  static const Color accentGlow = Color(0x267C6AF0);
  static const Color green = Color(0xFF4ADE80);
  static const Color greenDim = Color(0x1F4ADE80);
  static const Color amber = Color(0xFFFBBF24);
  static const Color textPrimary = Color(0xFFF0EFF8);
  static const Color textSecondary = Color(0xFF9B99B8);
  static const Color textTertiary = Color(0xFF5A5878);
  static const Color border = Color(0x12FFFFFF);
  static const Color border2 = Color(0x1FFFFFFF);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent2,
        surface: surface,
      ),
      fontFamily: 'DMSans',
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'DMSerifDisplay',
          fontSize: 26,
          color: textPrimary,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xE60F0F13),
        selectedItemColor: accent2,
        unselectedItemColor: textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}
