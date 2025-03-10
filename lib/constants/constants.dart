import 'package:market/functions/global_functions.dart';
import 'package:market/lists/lists.dart';
import 'package:market/providers/sell_section_providers/sell_section_provider.dart';
import 'package:market/services/auth/auth_services.dart';
import 'package:market/providers/auth_providers/auth_provider.dart';
import 'package:market/services/firestore/firestore_service.dart';

GlobalFunctions globalFunctions = GlobalFunctions();
AuthServices authServices = AuthServices();

FirestoreService firestoreService = FirestoreService();
Lists lists = Lists();

// provider

AuthenticationProvider authProvider = AuthenticationProvider();
SellSectionProvider sellSectionProvider = SellSectionProvider();
