import 'package:flutter/material.dart';

final appTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  scaffoldBackgroundColor: const Color(0xFF121212),
  backgroundColor: const Color(0xFF121212),
  primaryColor: const Color(0xFF1DB954),
  // accentColor: const Color(0xFF1DB954),
  iconTheme: const IconThemeData().copyWith(color: Colors.white),
  fontFamily: 'Montserrat',
  cardColor: ThemeData.dark().cardColor.withOpacity(0.2),
  textTheme: TextTheme(
    headline2: const TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 12.0,
      color: Colors.grey[300],
      fontWeight: FontWeight.w500,
      letterSpacing: 2.0,
    ),
    bodyText1: TextStyle(
      color: Colors.grey[300],
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    ),
    bodyText2: TextStyle(
      color: Colors.grey[300],
      letterSpacing: 1.0,
    ),
  ),
);
