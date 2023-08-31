import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF63E5FF),
    secondary: Color(0xFFFFFFFF),
    background: Color(0xFFD4D4D4),
    tertiary: Color(0xFF000000),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF43AFBD),
    secondary: Color(0xFF171719),
    background: Color(0xFF202427),
    tertiary: Color(0xFFFFFFFF),
  ),
);
