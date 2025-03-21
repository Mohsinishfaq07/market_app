import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
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
          body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            spacing: 20.0,
            children: [
              Consumer(builder: (context, ref, child) {
                return MyTextField(
                  hintText: 'Name',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    ref.read(authProvider.nameController.notifier).state =
                        value;
                  },
                );
              }),
              Consumer(builder: (context, ref, child) {
                return MyTextField(
                  hintText: 'Number',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    ref
                        .read(authProvider.phoneNumberController.notifier)
                        .state = value;
                  },
                );
              }),
              Consumer(builder: (context, ref, child) {
                return MyTextField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    ref.read(authProvider.emailController.notifier).state =
                        value;
                  },
                );
              }),
              Consumer(builder: (context, ref, child) {
                final nameController = ref.watch(authProvider.nameController);
                final phoneNumberController =
                    ref.watch(authProvider.phoneNumberController);
                final emailController = ref.watch(authProvider.emailController);
                return ElevatedButton(
                  onPressed: () {
                    globalFunctions.showLog(message: 'Name: $nameController');
                    globalFunctions.showLog(
                        message: 'Phone: $phoneNumberController');
                    globalFunctions.showLog(message: 'Email: $emailController');
                  },
                  child: const Text('Edit Profile'),
                );
              }),
            ],
          ),
        ),
      )),
    );
  }

  updateControllers(UserDetail userDetail, WidgetRef ref) {
    ref.read(authProvider.nameController.notifier).state = userDetail.name;
    ref.read(authProvider.phoneNumberController.notifier).state =
        userDetail.phoneNumber;
    ref.read(authProvider.emailController.notifier).state = userDetail.email;
  }
}
