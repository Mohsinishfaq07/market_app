import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market/constants/constants.dart';
import 'package:market/models/user_detail.dart';
import 'package:market/view/edit_profile_page/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (currentUserId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: const Center(child: Text("No user logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User data not found"));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final user = UserDetail.fromJson(userData);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildProfileInfo("Name", user.name),
                _buildProfileInfo("Email", user.email),
                _buildProfileInfo("Phone", user.phoneNumber),
                _buildProfileInfo("User ID", user.userId),
                ElevatedButton(
                  onPressed: () {
                    globalFunctions.nextScreen(
                        context, EditProfilePage(userDetail: user));
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
