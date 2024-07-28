import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ColorScheme get colorTheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.blueGrey.shade800,
    onSecondary: Colors.white,
    error: Colors.red.shade400,
    onError: Colors.white,
    surface: Colors.grey.shade50,
    onSurface: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.grey.shade50,
    elevation: 0.0,
    backgroundColor: Colors.grey.shade50,
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 48.0,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    displayMedium: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    displaySmall: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    titleLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    titleMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    titleSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    labelLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    labelMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: -0.5,
      height: 1.0,
    ),
  ),
);
