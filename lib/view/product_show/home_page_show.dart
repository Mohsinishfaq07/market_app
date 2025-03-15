import 'dart:io';

import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/charger_model.dart';
import 'package:market/models/selling_models/headphone_model.dart';
import 'package:market/models/selling_models/mobile_model.dart';
import 'package:market/models/selling_models/tablet_model.dart';
import 'package:market/view/product_show/product_page.dart';

class HomePageProductShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Categories productSellType;
  const HomePageProductShow(
      {super.key, required this.productData, required this.productSellType});

  @override
  Widget build(BuildContext context) {
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

class MobileHomePageShow extends StatelessWidget {
  final Map<String, dynamic> productData;
  const MobileHomePageShow({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    MobileSellModel mobileModel = MobileSellModel.fromMap(productData);
    return GestureDetector(
      onTap: () {
        globalFunctions.nextScreen(
            context,
            ProductPage(
                productData: productData, productSellType: Categories.mobiles));
      },
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.file(File(mobileModel.images[0])),
            ),
            Text('Mobile Brand: ${mobileModel.productBrand}'),
            Text('Location: ${mobileModel.productLocation}'),
            Text('Price: ${mobileModel.productPrice}'),
            Text('Description:\n${mobileModel.productDescription}'),
          ],
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
    TabletSellModel tabletModel = TabletSellModel.fromMap(productData);
    return GestureDetector(
      onTap: () {
        globalFunctions.nextScreen(
            context,
            ProductPage(
                productData: productData, productSellType: Categories.tablets));
      },
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.file(File(tabletModel.images[0])),
            ),
            Text('Tablets Brand: ${tabletModel.productBrand}'),
            Text('Location: ${tabletModel.productLocation}'),
            Text('Price: ${tabletModel.productPrice}'),
            Text('Description:\n${tabletModel.productDescription}'),
          ],
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
    AccessoryChargerModel chargerModel =
        AccessoryChargerModel.fromMap(productData);
    return GestureDetector(
      onTap: () {
        globalFunctions.nextScreen(
            context,
            ProductPage(
                productData: productData,
                productSellType: Categories.chargers));
      },
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.file(File(chargerModel.images[0])),
            ),
            Text('Charger for: ${chargerModel.chargerForDevice}'),
            Text('Charger Type: ${chargerModel.chargerType}'),
            Text('Charger Condition: ${chargerModel.productCondition}'),
            Text('Location: ${chargerModel.productLocation}'),
            Text('Price: ${chargerModel.productPrice}'),
            Text('Description:\n${chargerModel.productDescription}'),
          ],
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
    AccessoryHeadphonesModel headphonesModel =
        AccessoryHeadphonesModel.fromMap(productData);
    return GestureDetector(
      onTap: () {
        globalFunctions.nextScreen(
            context,
            ProductPage(
                productData: productData,
                productSellType: Categories.headphones));
      },
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.file(File(headphonesModel.images[0])),
            ),
            Text('HeadPhone Type: ${headphonesModel.headphoneType}'),
            Text('HeadPhone Condition: ${headphonesModel.productCondition}'),
            Text('Location: ${headphonesModel.productLocation}'),
            Text('Price: ${headphonesModel.productPrice}'),
            Text('Description:\n${headphonesModel.productDescription}'),
          ],
        ),
      ),
    );
  }
}
