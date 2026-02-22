import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF6B38FB);
const Color secondaryColor = Color(0xFF9D76FC);
const Color darkColor = Color(0xFF121212);
const Color darkSurfaceColor = Color(0xFF1E1E1E);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(fontSize: 57, fontWeight: FontWeight.bold),
  displayMedium: GoogleFonts.poppins(fontSize: 45, fontWeight: FontWeight.bold),
  displaySmall: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
  headlineLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
  headlineMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
  headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
  titleLarge: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
  titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
  titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
  bodyLarge: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w400),
  bodySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400),
  labelLarge: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w500),
);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    surface: Colors.white, 
    onSurface: Colors.black, 
    brightness: Brightness.light,
  ),
  textTheme: myTextTheme,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey.shade50,
  cardColor: Colors.white, 
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor, 
    secondary: secondaryColor,
    surface: darkSurfaceColor,
    onSurface: Colors.white, 
    brightness: Brightness.dark,
  ),
  textTheme: myTextTheme.apply(
    bodyColor: Colors.white, 
    displayColor: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: darkColor,
  cardColor: darkSurfaceColor, 
  appBarTheme: const AppBarTheme(
    backgroundColor: darkColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);

