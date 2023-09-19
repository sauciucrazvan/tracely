import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF3498DB),
    secondary: Color(0xFFD2D3DB),
    background: Color(0xFFE4E5F1),
    tertiary: Color(0xFF000000),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3498DB),
    secondary: Color(0xFF202427),
    background: Color(0xFF121212),
    tertiary: Color(0xFFFFFFFF),
  ),
);

const Map<String, Color> colors = {
  'red': Colors.red,
  'cyan': Colors.cyan,
  'lightblue': Colors.lightBlue,
  'blue': Colors.blue,
  'green': Colors.green,
  'lightgreen': Colors.lightGreen,
  'lime': Colors.lime,
  'yellow': Colors.yellow,
  'amber': Colors.amber,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'purple': Colors.purple,
};
