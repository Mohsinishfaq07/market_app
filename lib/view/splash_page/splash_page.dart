import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';

bool _splashInitialized = false;

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!_splashInitialized) {
        // check login status
        authServices.checkUserStatus(context: context);
        _splashInitialized = true;
      }
    });
    return Scaffold(
      body: const Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
