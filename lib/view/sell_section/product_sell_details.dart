import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/view/product_selling/mobile_sell.dart';
import 'package:market/view/product_selling/tablet_sell.dart';
import 'package:market/view/product_selling/watch_sell_details.dart';

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
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProductSellType.accessoriesHeadphones:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProductSellType.smartwatch:
        return WatchSellDetails();
      case ProductSellType.car:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProductSellType.bike:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
