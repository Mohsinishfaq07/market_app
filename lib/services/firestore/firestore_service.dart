import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/constants/constants.dart';
import 'package:market/models/user_detail.dart';

class FirestoreService {
  // save user details
  Future<bool> storeUserData({required UserDetail user}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userId)
          .set(user.toJson());
      return true;
    } catch (e) {
      globalFunctions.showLog(
          message: 'Failed to store user data:${e.toString()}');
      return false;
    }
  }
}
