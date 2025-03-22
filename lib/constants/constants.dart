import 'package:market/functions/global_functions.dart';
import 'package:market/lists/lists.dart';
import 'package:market/providers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:market/providers/chat_provider/chat_provider.dart';
import 'package:market/providers/product_sell_provider.dart';
import 'package:market/providers/sell_section_providers/sell_section_provider.dart';
import 'package:market/services/auth/auth_services.dart';
import 'package:market/providers/auth_providers/auth_provider.dart';
import 'package:market/services/firestore/firestore_service.dart';
import 'package:market/view/chat_page/chat_page.dart';

GlobalFunctions globalFunctions = GlobalFunctions();

Lists lists = Lists();

// provider

AuthenticationProvider authProvider = AuthenticationProvider();
SellSectionProvider sellSectionProvider = SellSectionProvider();
ProductSellProvider productSellProvider = ProductSellProvider();
BottomNavProvider bottomNavProvider = BottomNavProvider();
ChatProvider chatProvider = ChatProvider();
// services
AuthServices authServices = AuthServices();

FirestoreService firestoreService = FirestoreService();
