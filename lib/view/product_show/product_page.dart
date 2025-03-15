import 'dart:io';

import 'package:flutter/material.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/charger_model.dart';
import 'package:market/models/selling_models/headphone_model.dart';
import 'package:market/models/selling_models/mobile_model.dart';
import 'package:market/models/selling_models/tablet_model.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Categories productSellType;
  const ProductPage(
      {super.key, required this.productData, required this.productSellType});

  @override
  Widget build(BuildContext context) {
    switch (productSellType) {
      case Categories.mobiles:
        return MobileMainProductPage(productData: productData);
      case Categories.tablets:
        return TabletMainProductPage(productData: productData);
      case Categories.chargers:
        return ChargerMainPRoductPage(productData: productData);
      case Categories.headphones:
        return HeadPhoneMainProductPage(productData: productData);
    }
  }
}

class MobileMainProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  const MobileMainProductPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    MobileSellModel mobileModel = MobileSellModel.fromMap(productData);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Product Page',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.sizeOf(context).width - 30,
              child: ListView.builder(
                itemCount: mobileModel.images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Image.file(File(mobileModel.images[index])));
                },
              ),
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

class TabletMainProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  const TabletMainProductPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    TabletSellModel tabletModel = TabletSellModel.fromMap(productData);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Product Page',
      ),
      body: SafeArea(
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
                height: 200,
                width: MediaQuery.sizeOf(context).width - 30,
                child: ListView.builder(
                  itemCount: tabletModel.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Image.file(File(tabletModel.images[index])));
                  },
                ),
              ),
              Text('Tablets Brand: ${tabletModel.productBrand}'),
              Text('Location: ${tabletModel.productLocation}'),
              Text('Price: ${tabletModel.productPrice}'),
              Text('Description:\n${tabletModel.productDescription}'),
            ],
          ),
        ),
      ),
    );
  }
}

class ChargerMainPRoductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  const ChargerMainPRoductPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    AccessoryChargerModel chargerModel =
        AccessoryChargerModel.fromMap(productData);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Product Page',
      ),
      body: SafeArea(
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
                height: 200,
                width: MediaQuery.sizeOf(context).width - 30,
                child: ListView.builder(
                  itemCount: chargerModel.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Image.file(File(chargerModel.images[index])));
                  },
                ),
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
      ),
    );
  }
}

class HeadPhoneMainProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;
  const HeadPhoneMainProductPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    AccessoryHeadphonesModel headphonesModel =
        AccessoryHeadphonesModel.fromMap(productData);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Product Page',
      ),
      body: SafeArea(
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
                height: 200,
                width: MediaQuery.sizeOf(context).width - 30,
                child: ListView.builder(
                  itemCount: headphonesModel.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Image.file(File(headphonesModel.images[index])));
                  },
                ),
              ),
              Text('HeadPhone Type: ${headphonesModel.headphoneType}'),
              Text('HeadPhone Condition: ${headphonesModel.productCondition}'),
              Text('Location: ${headphonesModel.productLocation}'),
              Text('Price: ${headphonesModel.productPrice}'),
              Text('Description:\n${headphonesModel.productDescription}'),
            ],
          ),
        ),
      ),
    );
  }
}
