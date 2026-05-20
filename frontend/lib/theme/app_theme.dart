import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF2E3192);
const Color accentPurple = Color(0xFFB39DDB);
const Color backgroundGray = Color(0xFFF5F5F5);
const Color buttonViolet = Color(0xFF7E57C2);
const Color textGray = Color(0xFF333333);

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: backgroundGray,

    colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonViolet,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
