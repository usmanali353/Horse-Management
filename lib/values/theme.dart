import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.teal,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: const Color(0x1FFFFFFF),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.teal,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.teal,
  accentIconTheme: IconThemeData(color: Colors.teal),
  dividerColor: Colors.grey,
);
