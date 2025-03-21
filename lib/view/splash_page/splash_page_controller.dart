import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';
import 'package:market/view/auth/login.dart';

import '../home_page/home_page.dart'; // Create this file for your home page

class SplashController {
  static final SplashController _instance = SplashController._internal();
  bool _splashInitialized = false;
  bool _animationCompleted = false;

  factory SplashController() {
    return _instance;
  }

  SplashController._internal();

  void initializeSplash(BuildContext context) {
    if (!_splashInitialized) {
      Future.delayed(const Duration(seconds: 5), () {
        _animationCompleted = true;
        if (_animationCompleted) {
          authServices.checkUserStatus(context: context);
          _splashInitialized = true;
        }
      });
    }
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void continueAsGuest(BuildContext context) {
    // Navigate to home page or main app screen for guest users
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(), // Create your home page
      ),
    );
  }

  void onAnimationComplete(BuildContext context) {
    _animationCompleted = true;
    // Don't automatically navigate, wait for user choice
  }
}
