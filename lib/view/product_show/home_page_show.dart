import 'dart:io';

import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/charger_model.dart';
import 'package:market/models/selling_models/headphone_model.dart';
import 'package:market/models/selling_models/mobile_model.dart';
import 'package:market/models/selling_models/tablet_model.dart';
import 'package:market/view/product_show/product_page.dart';

import '../../core/constants/colors.dart';

class HomePageProductShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Categories productSellType;
  const HomePageProductShow({
    super.key,
    required this.productData,
    required this.productSellType,
  });

  @override
  Widget build(BuildContext context) {
    // Remove the Scaffold and just return the product card
    switch (productSellType) {
      case Categories.mobiles:
        return MobileHomePageShow(productData: productData);
      case Categories.tablets:
        return TabletHomePageShow(productData: productData);
      case Categories.chargers:
        return ChargerHomePageShow(productData: productData);
      case Categories.headphones:
        return HeadPhoneHomePageShow(productData: productData);
    }
  }
}

Widget _buildProductImage(String? imagePath, IconData placeholderIcon) {
  return Container(
    height: 180,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primary.withOpacity(0.05),
          AppColors.surfaceLight,
        ],
      ),
    ),
    child: imagePath != null && imagePath.isNotEmpty
        ? ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder(placeholderIcon);
              },
            ),
          )
        : _buildPlaceholder(placeholderIcon),
  );
}

Widget _buildPlaceholder(IconData icon) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 40,
          color: AppColors.primary,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'No Image Available',
        style: TextStyle(
          color: AppColors.textSecondary.withOpacity(0.7),
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget _buildProductCard({
  required Widget image,
  required String title,
  required String location,
  required String price,
  required String description,
  required VoidCallback onTap,
  Map<String, String>? specifications,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: image,
                ),
              ),
              // Price Tag
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '₹$price',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Details Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: AppColors.textSecondary.withOpacity(0.7),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (specifications != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: specifications.entries
                        .take(2)
                        .map((spec) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${spec.value}',
                                style: TextStyle(
                                  color:
                                      AppColors.textSecondary.withOpacity(0.8),
                                  fontSize: 11,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class MobileHomePageShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  const MobileHomePageShow({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    MobileSellModel model = MobileSellModel.fromMap(productData);
    return _buildProductCard(
      image: _buildProductImage(
        model.images.isNotEmpty ? model.images[0] : null,
        Icons.phone_android,
      ),
      title: model.productBrand,
      location: model.productLocation,
      price: model.productPrice,
      description: model.productDescription,
      specifications: {
        'Brand': model.productBrand,
        'Category': 'Mobile',
        'Price': '₹${model.productPrice}',
      },
      onTap: () => globalFunctions.nextScreen(
        context,
        ProductPage(
          productData: productData,
          productSellType: Categories.mobiles,
        ),
      ),
    );
  }
}

class TabletHomePageShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  const TabletHomePageShow({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    TabletSellModel model = TabletSellModel.fromMap(productData);
    return _buildProductCard(
      image: _buildProductImage(
        model.images.isNotEmpty ? model.images[0] : null,
        Icons.tablet_mac,
      ),
      title: model.productBrand,
      location: model.productLocation,
      price: model.productPrice,
      description: model.productDescription,
      specifications: {
        'Brand': model.productBrand,
        'Category': 'Tablet',
        'Price': '₹${model.productPrice}',
      },
      onTap: () => globalFunctions.nextScreen(
        context,
        ProductPage(
          productData: productData,
          productSellType: Categories.tablets,
        ),
      ),
    );
  }
}

class ChargerHomePageShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  const ChargerHomePageShow({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    AccessoryChargerModel model = AccessoryChargerModel.fromMap(productData);
    return _buildProductCard(
      image: _buildProductImage(
        model.images.isNotEmpty ? model.images[0] : null,
        Icons.charging_station,
      ),
      title: 'Charger',
      location: model.productLocation,
      price: model.productPrice,
      description: model.productDescription,
      specifications: {
        'Type': model.chargerType,
        'For Device': model.chargerForDevice,
        'Price': '₹${model.productPrice}',
      },
      onTap: () => globalFunctions.nextScreen(
        context,
        ProductPage(
          productData: productData,
          productSellType: Categories.chargers,
        ),
      ),
    );
  }
}

class HeadPhoneHomePageShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  const HeadPhoneHomePageShow({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    AccessoryHeadphonesModel model =
        AccessoryHeadphonesModel.fromMap(productData);
    return _buildProductCard(
      image: _buildProductImage(
        model.images.isNotEmpty ? model.images[0] : null,
        Icons.headphones,
      ),
      title: 'Headphone',
      location: model.productLocation,
      price: model.productPrice,
      description: model.productDescription,
      specifications: {
        'Type': model.headphoneType,
        'Category': 'Audio',
        'Price': '₹${model.productPrice}',
      },
      onTap: () => globalFunctions.nextScreen(
        context,
        ProductPage(
          productData: productData,
          productSellType: Categories.headphones,
        ),
      ),
    );
  }
}
