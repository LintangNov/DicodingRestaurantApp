import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color.fromARGB(255, 151, 151, 151);
const Color secondaryColor = Color(0xFF6B38FB);
const Color darkColor = Color(0xFF121212);

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
    seedColor: secondaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    brightness: Brightness.light, 
  ),
  textTheme: myTextTheme,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  )
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor,
  primary: darkColor,
  secondary: secondaryColor,
  brightness: Brightness.dark,
  ),
  textTheme: myTextTheme,
  useMaterial3: true,
  scaffoldBackgroundColor: darkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);

