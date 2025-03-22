import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/core/constants/background_decoration.dart';
import 'package:market/core/constants/colors.dart';
import 'package:market/models/user_detail.dart';

import 'package:market/widgets/custom_input/custom_input_field.dart';

class EditProfilePage extends ConsumerWidget {
  final UserDetail userDetail;
  const EditProfilePage({
    super.key,
    required this.userDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 1), () {
      updateControllers(userDetail, ref);
    });

    return PopScope(
      onPopInvokedWithResult: (val, res) {
        authProvider.clearSignupProviderSection(ref: ref);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: AppBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image Section
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: AppColors.primaryGradient,
                          ),
                          boxShadow: [AppColors.softShadow],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Text(
                            userDetail.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [AppColors.softShadow],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Form Fields
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [AppColors.softShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Consumer(
                          builder: (context, ref, child) {
                            return _buildTextField(
                              ref: ref,
                              icon: Icons.person_outline,
                              label: 'Full Name',
                              onChanged: (value) {
                                ref
                                    .read(authProvider.nameController.notifier)
                                    .state = value;
                              },
                              initialValue: userDetail.name,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Consumer(
                          builder: (context, ref, child) {
                            return _buildTextField(
                              ref: ref,
                              icon: Icons.phone_outlined,
                              label: 'Phone Number',
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                ref
                                    .read(authProvider
                                        .phoneNumberController.notifier)
                                    .state = value;
                              },
                              initialValue: userDetail.phoneNumber,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Consumer(
                          builder: (context, ref, child) {
                            return _buildTextField(
                              ref: ref,
                              icon: Icons.email_outlined,
                              label: 'Email Address',
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                ref
                                    .read(authProvider.emailController.notifier)
                                    .state = value;
                              },
                              initialValue: userDetail.email,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Save Button
                  Consumer(
                    builder: (context, ref, child) {
                      final nameController =
                          ref.watch(authProvider.nameController);
                      final phoneNumberController =
                          ref.watch(authProvider.phoneNumberController);
                      final emailController =
                          ref.watch(authProvider.emailController);

                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add validation here
                            if (nameController.isEmpty ||
                                phoneNumberController.isEmpty ||
                                emailController.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all fields')),
                              );
                              return;
                            }
                            // Update profile logic
                            globalFunctions.showLog(
                                message: 'Name: $nameController');
                            globalFunctions.showLog(
                                message: 'Phone: $phoneNumberController');
                            globalFunctions.showLog(
                                message: 'Email: $emailController');
                          },
                          style: AppColors.primaryButtonStyle,
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required WidgetRef ref,
    required IconData icon,
    required String label,
    required Function(String) onChanged,
    required String initialValue,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  void updateControllers(UserDetail userDetail, WidgetRef ref) {
    ref.read(authProvider.nameController.notifier).state = userDetail.name;
    ref.read(authProvider.phoneNumberController.notifier).state =
        userDetail.phoneNumber;
    ref.read(authProvider.emailController.notifier).state = userDetail.email;
  }
}
