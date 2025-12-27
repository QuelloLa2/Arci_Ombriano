import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark, 
    primary: Color(0xFFC74E43),
    onPrimary: Color(0xFF171717),
    secondary: Color(0xFFEEB573), 
    onSecondary: Color(0xFF171717), 
    error: Color(0xFFD5373A), 
    onError: Color(0xFFFFF8EE), 
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFFFFF8EE)
    ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFE9E3E3),
    foregroundColor: Color(0xFF171717),
    elevation: 0,
    surfaceTintColor: Colors.transparent,
  ),

  textTheme: TextTheme(
    headlineMedium: GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.bold),
    bodyMedium: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)
  )
);