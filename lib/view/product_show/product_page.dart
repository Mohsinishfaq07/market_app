import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';
import 'package:market/core/constants/colors.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/charger_model.dart';
import 'package:market/models/selling_models/headphone_model.dart';
import 'package:market/models/selling_models/mobile_model.dart';
import 'package:market/models/selling_models/tablet_model.dart';
import 'package:market/models/user_detail.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Categories productSellType;
  const ProductPage({
    super.key,
    required this.productData,
    required this.productSellType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Image Slider
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: _buildImageSlider(context),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Product Details
          SliverToBoxAdapter(
            child: _buildProductDetails(context),
          ),
        ],
      ),
      bottomNavigationBar: _buildContactButtons(context),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    final images = _getProductImages();
    return FlexibleSpaceBar(
      background: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.file(
            File(images[index]),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    final details = _getProductDetails();
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price and Location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${details['price']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    details['location'] ?? '',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Product Title
          Text(
            details['title'] ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Specifications
          ..._buildSpecifications(details['specifications'] ?? {}),
          const SizedBox(height: 16),

          // Description
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            details['description'] ?? '',
            style: const TextStyle(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              height: 40,
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Product Available?'),
                  TextButton(
                    onPressed: () {
                      firestoreService.chatService.sendFirstMessage(
                          message: 'Is This Product Available?',
                          sellerId: productData['uploadedBy'],
                          buyerId: FirebaseAuth.instance.currentUser!.uid);
                    },
                    child: Text('Send Message'),
                  )
                ],
              ))
        ],
      ),
    );
  }

  List<Widget> _buildSpecifications(Map<String, String> specs) {
    return [
      const Text(
        'Specifications',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: specs.entries.map((spec) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${spec.key}: ${spec.value}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          );
        }).toList(),
      ),
    ];
  }

  Widget _buildContactButtons(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _makePhoneCall(context),
                icon: const Icon(Icons.phone),
                label: const Text('Call'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _openWhatsApp(context),
                icon: const Icon(Icons.message),
                label: const Text('WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(BuildContext context) async {
    final ownerDetails = await authServices.getUserDetails(
      userId: productData['uploadedBy'],
    );
    globalFunctions.openPhoneDialer(ownerDetails.phoneNumber);
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final ownerDetails = await authServices.getUserDetails(
      userId: productData['uploadedBy'],
    );
    globalFunctions.openWhatsApp(phoneNumber: ownerDetails.phoneNumber);
  }

  List<String> _getProductImages() {
    switch (productSellType) {
      case Categories.mobiles:
        return MobileSellModel.fromMap(productData).images;
      case Categories.tablets:
        return TabletSellModel.fromMap(productData).images;
      case Categories.chargers:
        return AccessoryChargerModel.fromMap(productData).images;
      case Categories.headphones:
        return AccessoryHeadphonesModel.fromMap(productData).images;
    }
  }

  Map<String, dynamic> _getProductDetails() {
    switch (productSellType) {
      case Categories.mobiles:
        final model = MobileSellModel.fromMap(productData);
        return {
          'title': model.productBrand,
          'price': model.productPrice,
          'location': model.productLocation,
          'description': model.productDescription,
          'specifications': {
            'Brand': model.productBrand,
            'Type': 'Mobile Phone',
            'Location': model.productLocation,
          },
        };
      case Categories.tablets:
        final model = TabletSellModel.fromMap(productData);
        return {
          'title': model.productBrand,
          'price': model.productPrice,
          'location': model.productLocation,
          'description': model.productDescription,
          'specifications': {
            'Brand': model.productBrand,
            'Type': 'Tablet',
            'Location': model.productLocation,
          },
        };
      case Categories.chargers:
        final model = AccessoryChargerModel.fromMap(productData);
        return {
          'title': '${model.chargerType} Charger',
          'price': model.productPrice,
          'location': model.productLocation,
          'description': model.productDescription,
          'specifications': {
            'Type': model.chargerType,
            'For Device': model.chargerForDevice,
            'Condition': model.productCondition,
          },
        };
      case Categories.headphones:
        final model = AccessoryHeadphonesModel.fromMap(productData);
        return {
          'title': '${model.headphoneType} Headphones',
          'price': model.productPrice,
          'location': model.productLocation,
          'description': model.productDescription,
          'specifications': {
            'Type': model.headphoneType,
            'Condition': model.productCondition,
          },
        };
    }
  }
}
