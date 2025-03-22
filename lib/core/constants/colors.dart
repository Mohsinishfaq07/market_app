import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF6C63FF); // Modern Purple
  static const Color secondary = Color(0xFF8A84FF); // Light Purple

  // Background colors
  static const Color background = Color(0xFFFCFCFF); // Almost White
  static const Color surfaceLight = Color(0xFFF8F9FF); // Lighter Purple Tint
  static const Color surfaceMedium = Color(0xFFF3F4FF); // Light Purple Tint

  // Text colors
  static const Color textPrimary = Color(0xFF2C3E50); // Dark Blue Gray
  static const Color textSecondary = Color(0xFF7F8C8D); // Medium Gray
  static const Color textLight = Color(0xFFBDC3C7); // Light Gray

  // Accent colors
  static const Color accent1 = Color(0xFFFF6B6B); // Coral Red
  static const Color accent2 = Color(0xFFA594F9); // Soft Purple
  static const Color accent3 = Color(0xFF7C4DFF); // Deep Purple

  // Gradient colors
  static const Color gradientStart = Color(0xFF7B4DFF); // Rich Purple
  static const Color gradientMiddle = Color(0xFF6C63FF); // Modern Purple
  static const Color gradientEnd = Color(0xFF9D6FFF); // Bright Purple
  static const Color gradientAccent = Color(0xFFB39DDB); // Soft Lavender

  static List<Color> primaryGradient = [
    gradientStart,
    gradientMiddle,
    gradientEnd,
    gradientAccent.withOpacity(0.95),
  ];

  static List<Color> accentGradient = [
    accent3,
    accent3.withOpacity(0.8),
    accent2,
    accent2.withOpacity(0.9),
  ];

  // New subtle gradient for backgrounds
  static List<Color> backgroundGradient = [
    shimmerLight,
    lightAccent.withOpacity(0.8),
    surfaceLight.withOpacity(0.5),
    background.withOpacity(0.9),
  ];

  // New vibrant gradient for CTAs
  static List<Color> actionGradient = [
    accent1,
    accent1.withOpacity(0.8),
    accent3.withOpacity(0.9),
    accent3,
  ];

  // Status colors
  static const Color success = Color(0xFF7C4DFF); // Deep Purple
  static const Color error = Color(0xFFE74C3C); // Soft Red
  static const Color warning = Color(0xFFFF9F43); // Soft Orange
  static const Color info = Color(0xFF6C63FF); // Modern Purple

  // Shadow effects
  static BoxShadow primaryShadow = BoxShadow(
    color: primary.withOpacity(0.25),
    blurRadius: 20,
    offset: const Offset(0, 10),
    spreadRadius: 0,
  );

  static BoxShadow softShadow = BoxShadow(
    color: textPrimary.withOpacity(0.08),
    blurRadius: 15,
    offset: const Offset(0, 5),
    spreadRadius: 0,
  );

  // Button styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primary,
    side: const BorderSide(color: primary, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );

  // Input Decoration
  static InputDecoration getInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: primary.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: primary,
        ),
      ),
    );
  }

  // Container Decorations
  static BoxDecoration gradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: primaryGradient,
      stops: const [0.0, 0.3, 0.6, 1.0],
    ),
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: gradientStart.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: gradientEnd.withOpacity(0.2),
        blurRadius: 15,
        offset: const Offset(0, -5),
        spreadRadius: -5,
      ),
    ],
  );

  static BoxDecoration surfaceBoxDecoration = BoxDecoration(
    color: surfaceLight,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [softShadow],
  );

  // Add new gradient decorations
  static BoxDecoration softGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ...backgroundGradient,
      ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: darkAccent.withOpacity(0.03),
        blurRadius: 20,
        spreadRadius: 0,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: primary.withOpacity(0.02),
        blurRadius: 15,
        spreadRadius: -5,
        offset: const Offset(0, -5),
      ),
    ],
  );

  static BoxDecoration vibrantGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: actionGradient,
      stops: const [0.0, 0.4, 0.7, 1.0],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: accent1.withOpacity(0.3),
        blurRadius: 15,
        offset: const Offset(0, 8),
        spreadRadius: -2,
      ),
    ],
  );

  // Add new background and dark accent colors
  static const Color darkAccent = Color(0xFF2A2D3E); // Dark Blue-Gray
  static const Color darkSurface = Color(0xFF1F1D2B); // Rich Dark
  static const Color lightAccent = Color(0xFFF8F9FF); // Very Light Purple
  static const Color shimmerLight = Color(0xFFFFFFFF); // Pure White

  // Add new subtle dark gradient
  static List<Color> darkGradient = [
    darkAccent.withOpacity(0.05),
    darkSurface.withOpacity(0.02),
    Colors.black.withOpacity(0.01),
    darkAccent.withOpacity(0.03),
  ];

  // Add new glass effect decoration
  static BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.8),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.white.withOpacity(0.5),
      width: 1.5,
    ),
    boxShadow: [
      BoxShadow(
        color: darkAccent.withOpacity(0.03),
        blurRadius: 15,
        spreadRadius: -5,
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        blurRadius: 10,
        spreadRadius: -5,
      ),
    ],
  );

  // Add layered gradient decoration
  static BoxDecoration layeredGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: backgroundGradient,
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: darkAccent.withOpacity(0.05),
        blurRadius: 25,
        spreadRadius: -5,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.7),
        blurRadius: 20,
        spreadRadius: -5,
        offset: const Offset(0, -8),
      ),
    ],
  );
}
