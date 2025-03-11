import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/view/sell_section/product_sell_details.dart';
import 'package:market/view/sell_section/sub_categories.dart';

class Lists {
  List<Map<String, dynamic>> mainCategoryListMap(
      {required BuildContext context}) {
    return [
      {
        'name': 'Mobiles',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              SubCategoriesPage(
                subCategoryList: getMobCategoryList(context: context),
              ));
        },
      },
      {
        'name': 'Cars',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              SubCategoriesPage(
                subCategoryList: [],
              ));
        },
      },
      {
        'name': 'Bikes',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              SubCategoriesPage(
                subCategoryList: [],
              ));
        },
      },
    ];
  }

  // mobile category list
  List<Map<String, dynamic>> getMobCategoryList(
      {required BuildContext context}) {
    return [
      {
        'name': 'Mobiles',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.mobile,
              ));
        },
      },
      {
        'name': 'Tablets',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.tablets,
              ));
        },
      },
      {
        'name': 'Accessories',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              SubCategoriesPage(
                subCategoryList: getMobAccessoriesList(context: context),
              ));
        },
      },
      {
        'name': 'Smart Watches',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.smartwatch,
              ));
        },
      },
    ];
  }

  // mobile accessories list
  List<Map<String, dynamic>> getMobAccessoriesList(
      {required BuildContext context}) {
    return [
      {
        'name': 'Chargers',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.accessoriesCharger,
              ));
        },
      },
      {
        'name': 'Headphones',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.accessoriesHeadphones,
              ));
        },
      },
    ];
  }
}
