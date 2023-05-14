import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightTheme() => ThemeData(
        scaffoldBackgroundColor: const Color(0xffFEF8F4),
        fontFamily: "Tajawal",
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 13,
            fontWeight: FontWeight.bold,
            height: 1.3,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            height: 4 / 3,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            height: 4 / 3,
            color: Color(0xff707070),
          ),
        ),
      );
}
