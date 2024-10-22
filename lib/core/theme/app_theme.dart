import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.deepPurple[200],
    brightness: Brightness.light,
  );

  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Colors.deepPurple[900],
    brightness: Brightness.dark,
    // textTheme: TextTheme()
  );
}
