import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/view/sell_section/main_categories.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'HomePage',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                globalFunctions.nextScreen(context, MainCategoriesPage());
              },
              child: const Text('Sell Page'),
            ),
            ElevatedButton(
              onPressed: () {
                authServices.signOut(context: context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
