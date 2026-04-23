import 'package:flutter/material.dart';

class AppTheme {
  static const Color profitGreen = Color(0xFF43A047);
  static const Color lossRed = Color(0xFFE53935);
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;
  static const Color background = Colors.white;
  static const Color divider = Colors.black12;

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: background,
      primaryColor: Colors.blue.shade700,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
      ),
      dividerColor: divider,
      fontFamily: 'Roboto',
    );
  }
}