import 'package:flutter/material.dart';

final appTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFC74E43),
    onPrimary: Colors.white,
    secondary: Color(0xFFEEB573),
    onSecondary: Color(0xFF171717),
    error: Color(0xFFD5373A),
    onError: Colors.white,
    surface: Color(0xFFF8F8F8),
    onSurface: Color(0xFF171717),
  ),

  fontFamily: "Poppins",

  scaffoldBackgroundColor: Color(0xFFF8F8F8),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF171717),
    elevation: 1,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: Color(0xFF171717),
    ),
    iconTheme: IconThemeData(color: Color(0xFF171717)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFC74E43),
      foregroundColor: Colors.white,
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      textStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFC74E43),
      side: BorderSide(color: Color(0xFFC74E43), width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFC74E43),
      textStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFC74E43), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFD5373A), width: 1),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  ),

  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFC74E43),
    unselectedItemColor: Color(0xFF7B8284),
    selectedLabelStyle: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      fontSize: 13,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    elevation: 8,
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF171717),
    contentTextStyle: TextStyle(
      fontFamily: "Poppins",
      color: Colors.white,
      fontSize: 14,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    behavior: SnackBarBehavior.floating,
  ),

  expansionTileTheme: ExpansionTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFC74E43),
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
