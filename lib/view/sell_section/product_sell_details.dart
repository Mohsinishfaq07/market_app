import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        appBar: AppBar(
          title: const Text('Product Sell Details'),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: getProductPage(productSellType: productSellType),
        )));
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
