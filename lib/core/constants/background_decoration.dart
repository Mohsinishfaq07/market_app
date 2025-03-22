import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';

class AppBackgroundDecoration {
  // Main background decoration used across the app
  static BoxDecoration mainBackground = BoxDecoration(
    color: AppColors.background,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary.withOpacity(0.1),
        AppColors.background,
        AppColors.secondary.withOpacity(0.1),
      ],
    ),
  );

  // For decorative circles, create a separate widget
  static Widget backgroundWithCircles({required Widget child}) {
    return Stack(
      children: [
        Container(decoration: mainBackground),
        // Top right circle
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.primary.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ),
        // Bottom left circle
        Positioned(
          bottom: -150,
          left: -100,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary.withOpacity(0.2),
                  AppColors.secondary.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }

  // Alternative background for modals and dialogs
  static BoxDecoration modalBackground = BoxDecoration(
    color: AppColors.background,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary.withOpacity(0.05),
        AppColors.background,
        AppColors.secondary.withOpacity(0.05),
      ],
    ),
  );

  // Background with more emphasis for important screens
  static BoxDecoration accentBackground = BoxDecoration(
    color: AppColors.background,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary.withOpacity(0.15),
        AppColors.background,
        AppColors.accent2.withOpacity(0.1),
      ],
    ),
  );
}
class AppBackground extends ConsumerWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // Top Positioned Circle
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.primary.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ),
        // Bottom Positioned Circle
        Positioned(
          bottom: -150,
          left: -100,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary.withOpacity(0.2),
                  AppColors.secondary.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ),
        // Main App Content
        child,
      ],
    );
  }
}