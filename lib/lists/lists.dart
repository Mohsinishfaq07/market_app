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
                subCategoryList: getCarCategoryList(context: context),
              ));
        },
      },
      {
        'name': 'Bikes',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              SubCategoriesPage(
                subCategoryList: getBikeCategoryList(context: context),
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

  // cars category list
  List<Map<String, dynamic>> getCarCategoryList(
      {required BuildContext context}) {
    return [
      {
        'name': 'Cars',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.car,
              ));
        },
      },
      {
        'name': 'Spare Parts',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.carSpareParts,
              ));
        },
      },
    ];
  }

  // bike category list
  List<Map<String, dynamic>> getBikeCategoryList(
      {required BuildContext context}) {
    return [
      {
        'name': 'Bikes',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.bike,
              ));
        },
      },
      {
        'name': 'Bike Parts',
        'onTap': () {
          globalFunctions.nextScreen(
              context,
              ProductSellDetails(
                productSellType: ProductSellType.bikeSpareParts,
              ));
        },
      },
    ];
  }
}
