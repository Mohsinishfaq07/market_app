import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellSectionProvider {
  final mainSelectedCategory = StateProvider<String>((ref) {
    return 'Mobiles';
  });
}
