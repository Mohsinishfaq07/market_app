import 'dart:math' show sin, pi;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/view/product_show/home_page_show.dart';
import 'package:market/view/product_show/product_page.dart';
import 'package:market/view/profile_page/profile_page.dart';
import 'package:market/view/sell_section/main_categories.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';
import 'package:market/core/constants/colors.dart';
import 'package:market/providers/bottom_nav_provider.dart';
import 'package:market/core/constants/background_decoration.dart';

extension MediaQueryHelpers on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double wp(double percentage) => screenWidth * (percentage / 100);
  double hp(double percentage) => screenHeight * (percentage / 100);
}

// First, move the DrawerHeaderClipper class outside of HomePage class, at the top level of the file
class DrawerHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Starting point
    path.lineTo(0, size.height * 0.8);

    // First wave
    var firstControlPoint = Offset(size.width * 0.15, size.height * 0.85);
    var firstEndPoint = Offset(size.width * 0.3, size.height * 0.8);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // Second wave
    var secondControlPoint = Offset(size.width * 0.45, size.height * 0.75);
    var secondEndPoint = Offset(size.width * 0.6, size.height * 0.85);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // Third wave
    var thirdControlPoint = Offset(size.width * 0.75, size.height * 0.95);
    var thirdEndPoint = Offset(size.width * 0.9, size.height * 0.85);
    path.quadraticBezierTo(
      thirdControlPoint.dx,
      thirdControlPoint.dy,
      thirdEndPoint.dx,
      thirdEndPoint.dy,
    );

    // Final curve to bottom right
    var finalControlPoint = Offset(size.width * 0.95, size.height * 0.8);
    var finalEndPoint = Offset(size.width, size.height * 0.85);
    path.quadraticBezierTo(
      finalControlPoint.dx,
      finalControlPoint.dy,
      finalEndPoint.dx,
      finalEndPoint.dy,
    );

    // Complete the path
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Add this map at the top of the file, outside any class
final Map<String, IconData> categoryIcons = {
  'Mobiles': Icons.phone_android,
  'Laptops': Icons.laptop_mac,
  'Tablets': Icons.tablet_mac,
  'Smart Watches': Icons.watch,
  'Cameras': Icons.camera_alt,
  'TVs': Icons.tv,
  'Audio': Icons.headphones,
  'Gaming': Icons.sports_esports,
  'Accessories': Icons.cable,
  'Other': Icons.devices_other,
};

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> mainCategoryList =
        lists.mainCategoryListMap(context: context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            // Fixed Header
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.circular(MediaQuery.of(context).size.width * 0.08),
                ),
                boxShadow: [AppColors.softShadow],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Builder(
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.menu, color: Colors.white),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Market App',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [AppColors.softShadow],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search products...',
                                hintStyle: TextStyle(
                                  color:
                                      AppColors.textSecondary.withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.tune,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Categories section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Container(
                                height: 0.1,
                                color: Colors.black,
                                width: 100,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('See All'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.16,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                              itemCount: mainCategoryList.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> category =
                                    mainCategoryList[index];
                                final isSelected = ref
                                        .watch(productSellProvider
                                            .selectedCategory)
                                        .name ==
                                    category['name'];

                                return GestureDetector(
                                  onTap: () {
                                    final selectedCategoryEnum =
                                        Categories.values.firstWhere(
                                      (e) =>
                                          e.toString().split('.').last ==
                                          category['name'],
                                      orElse: () => Categories.mobiles,
                                    );
                                    ref
                                        .read(productSellProvider
                                            .selectedCategory.notifier)
                                        .state = selectedCategoryEnum;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04,
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: isSelected
                                            ? [
                                                AppColors.primary,
                                                AppColors.primary
                                                    .withOpacity(0.8),
                                              ]
                                            : [
                                                Colors.white,
                                                Colors.white.withOpacity(0.9),
                                              ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isSelected
                                              ? AppColors.primary
                                                  .withOpacity(0.3)
                                              : Colors.black.withOpacity(0.05),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.white.withOpacity(0.2)
                                                : AppColors.primary
                                                    .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            category['icon'] ?? Icons.category,
                                            size: 28,
                                            color: isSelected
                                                ? Colors.white
                                                : AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          category['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? Colors.white
                                                : AppColors.textPrimary,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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
                    ),
                    _buildCategorySection(
                      context: context,
                      ref: ref,
                      title: 'Mobiles',
                      category: Categories.mobiles,
                    ),

                    // Tablets Section
                    _buildCategorySection(
                      context: context,
                      ref: ref,
                      title: 'Tablets',
                      category: Categories.tablets,
                    ),

                    // Chargers Section
                    _buildCategorySection(
                      context: context,
                      ref: ref,
                      title: 'Chargers',
                      category: Categories.chargers,
                    ),

                    // Headphones Section
                    _buildCategorySection(
                      context: context,
                      ref: ref,
                      title: 'Headphones',
                      category: Categories.headphones,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Clean and modern header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_outline,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Info
                  const Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'user@email.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  _buildDrawerItem(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () => globalFunctions.nextScreen(
                        context, const ProfilePage()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.add_box_outlined,
                    title: 'Sell Product',
                    onTap: () => globalFunctions.nextScreen(
                        context, const MainCategoriesPage()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_outline,
                    title: 'Favorites',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    onTap: () {},
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(height: 40),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_outline,
                    title: 'About',
                    onTap: () {},
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(height: 40),
                  ),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    isDestructive: true,
                    onTap: () => authServices.signOut(context: context),
                  ),
                ],
              ),
            ),
          ),

          // App Version
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      minLeadingWidth: 20,
      horizontalTitleGap: 12,
    );
  }

  Widget _buildCategorySection({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required Categories category,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: firestoreService.fetchCategoryProducts(
                categoryName: category.name,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error loading $title",
                      style: const TextStyle(color: AppColors.error),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            categoryIcons[title] ?? Icons.category,
                            size: 32,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "No $title available",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: HomePageProductShow(
                          productData: snapshot.data![index],
                          productSellType: category,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
