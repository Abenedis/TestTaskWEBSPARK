import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF2196F3);

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
    appBarTheme: const AppBarTheme(
      backgroundColor: _seed,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF64B5F6),
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: Color(0xFF1565C0)),
        ),
      ),
    ),
  );
}
