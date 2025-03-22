import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/core/constants/colors.dart';
import 'package:market/core/constants/background_decoration.dart';

class MainCategoriesPage extends ConsumerWidget {
  const MainCategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> mainCategoryList =
        lists.mainCategoryListMap(context: context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: AppBackgroundDecoration.mainBackground,
          ),
          Column(
            children: [
              // App Bar with gradient
              Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  boxShadow: [AppColors.softShadow],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // IconButton(
                        //   icon:
                        //       const Icon(Icons.arrow_back, color: Colors.white),
                        //   onPressed: () => Navigator.of(context).pop(),
                        // ),
                        // const SizedBox(width: 8),
                        const Text(
                          'Select Category',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Choose a category for your product',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Categories Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: mainCategoryList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> category = mainCategoryList[index];
                    final isSelected =
                        ref.watch(productSellProvider.selectedCategory).name ==
                            category['name'];

                    return InkWell(
                      onTap: category['onTap'],
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: AppColors.primaryGradient,
                                )
                              : null,
                          color: isSelected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [AppColors.softShadow],
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: AppColors.primary.withOpacity(0.1),
                                ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withOpacity(0.2)
                                    : AppColors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                category['icon'] ?? Icons.category,
                                size: 32,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              category['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap to select',
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white.withOpacity(0.8)
                                    : AppColors.textSecondary.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


