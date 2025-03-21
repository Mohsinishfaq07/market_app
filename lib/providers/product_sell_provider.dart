import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/enums/global_enums.dart';

class ProductSellProvider {
  final imageLists = StateProvider.autoDispose<List<String>>((ref) {
    return [];
  });

  final productName = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });

  final productDescription = StateProvider.autoDispose<String>((ref) {
    return '';
  });
  final productPrice = StateProvider.autoDispose<String>((ref) {
    return '';
  });
  final productLocation = StateProvider.autoDispose<String>((ref) {
    return '';
  });
  final productTitle = StateProvider.autoDispose<String>((ref) {
    return '';
  });
  final productCondition = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });

  final chargerForDevice = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });
  final chargerType = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });
  final headphoneType = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });
  final carCompanyName = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });
  final sparePartType = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });

  final bikeCompanyName = StateProvider.autoDispose<String>((ref) {
    return 'Select';
  });

  final selectedCategory = StateProvider.autoDispose<Categories>((ref) {
    return Categories.chargers;
  });

  final searchProduct = StateProvider.autoDispose<String>((ref) {
    return '';
  });
}
