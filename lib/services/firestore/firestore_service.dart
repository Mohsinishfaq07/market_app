import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
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

  // upload product on firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProductData({
    required String collectionName,
    required Map<String, dynamic> productData,
  }) async {
    try {
      await _firestore.collection('categories').doc('categories').update({
        'collections': FieldValue.arrayUnion([collectionName]),
      });

      await _firestore
          .collection('categories')
          .doc('categories')
          .collection(collectionName)
          .add(productData);
      globalFunctions.showLog(
          message: "Product uploaded successfully to $collectionName");
      globalFunctions.showToast(message: 'Posted', toastType: ToastType.info);
    } catch (e) {
      globalFunctions.showLog(message: "Error uploading product: $e");
      rethrow;
    }
  }

  // fetch categories
  Stream<List<String>> fetchCategoryNames() {
    return FirebaseFirestore.instance
        .collection("categories")
        .doc("categories")
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        List<dynamic> data = snapshot.data()?["categories"] ?? [];
        return List<String>.from(data);
      } else {
        return [];
      }
    });
  }

  Stream<List<Map<String, dynamic>>> fetchCategoryProducts({
    required String categoryName,
  }) {
    return FirebaseFirestore.instance
        .collection("categories")
        .doc("categories")
        .collection(categoryName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
