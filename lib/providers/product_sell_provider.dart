import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSellProvider {
  final imageLists = StateProvider((ref) {
    return [];
  });

  final productName = StateProvider<String>((ref) {
    return '';
  });

  final productDescription = StateProvider<String>((ref) {
    return '';
  });
  final productPrice = StateProvider<String>((ref) {
    return '';
  });
  final productLocation = StateProvider<String>((ref) {
    return '';
  });
  final productTitle = StateProvider<String>((ref) {
    return '';
  });
  final productCondition = StateProvider<String>((ref) {
    return '';
  });
}
