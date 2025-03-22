import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/user_detail.dart';

class FirestoreService {
  ChatService chatService = ChatService();
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
        'categories': FieldValue.arrayUnion([collectionName]),
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

    ChatService chatService = ChatService();
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

class ChatService {
  Future<void> sendFirstMessage({
    required String message,
    required String sellerId,
    required String buyerId,
  }) async {
    try {
      String chatId = buyerId.hashCode <= sellerId.hashCode
          ? '${buyerId}_$sellerId'
          : '${sellerId}_$buyerId';

      final chatRef =
          FirebaseFirestore.instance.collection('chats').doc(chatId);

      await chatRef.set({
        'buyerId': buyerId,
        'sellerId': sellerId,
        'lastMessage': message,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await chatRef.collection('messages').add({
        'message': message,
        'senderId': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      globalFunctions.showToast(
          message: 'Message Sended', toastType: ToastType.success);
    } catch (e) {
      globalFunctions.showLog(message: 'Error sending message: $e');
      globalFunctions.showToast(
          message: 'Error sending message: $e', toastType: ToastType.error);
    }
  }

  Future<void> sendMessage({
    required String message,
    required String chatId,
    required String currentUserId,
  }) async {
    try {
      final chatRef =
          FirebaseFirestore.instance.collection('chats').doc(chatId);

      await chatRef.set({
        'lastMessage': message,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await chatRef.collection('messages').add({
        'message': message,
        'senderId': currentUserId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      globalFunctions.showLog(message: 'Error sending message: $e');
    }
  }
}
