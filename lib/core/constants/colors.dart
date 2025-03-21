import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3); // Main Blue
  static const Color secondary = Color(0xFF4CAF50); // Main Green

  // Background Colors
  static const Color background = Colors.white;
  static const Color surfaceLight = Color(0xFFF5F9FF); // Light Blue Background
  static const Color surfaceMedium =
      Color(0xFFE3F2FD); // Medium Blue Background

  // Accent Colors
  static const Color accent = Color(0xFF81C784); // Light Green
  static const Color accentLight = Color(0xFFE8F5E9); // Very Light Green

  // Text Colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);

  // Gradient Colors
  static List<Color> primaryGradient = [
    primary,
    primary.withOpacity(0.8),
    secondary.withOpacity(0.9),
    secondary,
  ];

  static List<Color> surfaceGradient = [
    primary.withOpacity(0.1),
    background,
    secondary.withOpacity(0.1),
  ];

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);

  // Shadow Colors
  static BoxShadow primaryShadow = BoxShadow(
    color: primary.withOpacity(0.3),
    blurRadius: 20,
    offset: const Offset(0, 10),
  );

  static BoxShadow secondaryShadow = BoxShadow(
    color: secondary.withOpacity(0.3),
    blurRadius: 20,
    offset: const Offset(0, -10),
  );

  static BoxShadow softShadow = BoxShadow(
    color: primary.withOpacity(0.1),
    blurRadius: 20,
    offset: const Offset(0, 5),
  );

  // Button Styles
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
      stops: const [0.0, 0.3, 0.7, 1.0],
    ),
    borderRadius: BorderRadius.circular(30),
    boxShadow: [primaryShadow, secondaryShadow],
  );

  static BoxDecoration surfaceBoxDecoration = BoxDecoration(
    color: surfaceLight,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [softShadow],
  );
}
