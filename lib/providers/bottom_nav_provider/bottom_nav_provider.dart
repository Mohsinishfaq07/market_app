import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavProvider {
  final currentIndex = StateProvider<int>((ref) => 0);
}
