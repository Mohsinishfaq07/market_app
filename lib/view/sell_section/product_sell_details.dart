import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/core/constants/colors.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/view/product_selling/bike_section/bike_sell_details.dart';
import 'package:market/view/product_selling/bike_section/bike_spare_parts_sell_details.dart';
import 'package:market/view/product_selling/cars_section/cars_sell_details.dart';
import 'package:market/view/product_selling/cars_section/cars_spare_parts_seel_details.dart';
import 'package:market/view/product_selling/mobile_section/charger_selling_details.dart';
import 'package:market/view/product_selling/mobile_section/headphone_selling_details.dart';
import 'package:market/view/product_selling/mobile_section/mobile_sell.dart';
import 'package:market/view/product_selling/mobile_section/tablet_sell.dart';
import 'package:market/view/product_selling/mobile_section/watch_sell_details.dart';

class ProductSellDetails extends ConsumerWidget {
  final ProductSellType productSellType;
  const ProductSellDetails({super.key, required this.productSellType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(_getPageTitle(productSellType)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: getProductPage(productSellType: productSellType),
            ),
          ),

          // Bottom Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Handle next step
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPageTitle(ProductSellType type) {
    switch (type) {
      case ProductSellType.mobile:
        return 'Sell Mobile Phone';
      case ProductSellType.tablets:
        return 'Sell Tablet';
      case ProductSellType.accessories:
        return 'Sell Accessories';
      case ProductSellType.accessoriesCharger:
        return 'Sell Charger';
      case ProductSellType.accessoriesHeadphones:
        return 'Sell Headphones';
      case ProductSellType.smartwatch:
        return 'Sell Smartwatch';
      case ProductSellType.car:
        return 'Sell Car';
      case ProductSellType.carSpareParts:
        return 'Sell Car Parts';
      case ProductSellType.bike:
        return 'Sell Bike';
      case ProductSellType.bikeSpareParts:
        return 'Sell Bike Parts';
    }
  }

  Widget getProductPage({required ProductSellType productSellType}) {
    switch (productSellType) {
      case ProductSellType.mobile:
        return MobileSell();
      case ProductSellType.tablets:
        return TabletSell();
      case ProductSellType.accessories:
        return WatchSellDetails();
      case ProductSellType.accessoriesCharger:
        return AccessoryCharger();
      case ProductSellType.accessoriesHeadphones:
        return AccessoryHeadphones();
      case ProductSellType.smartwatch:
        return WatchSellDetails();
      case ProductSellType.car:
        return CarsSell();
      case ProductSellType.carSpareParts:
        return CarsSparePartsSellDetails();
      case ProductSellType.bike:
        return BikeSell();
      case ProductSellType.bikeSpareParts:
        return BikeSparePartsSellDetails();
    }
  }
}
