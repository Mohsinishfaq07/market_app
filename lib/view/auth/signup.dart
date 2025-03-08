import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/models/user_detail.dart';

import 'package:market/widgets/custom_input/custom_input_field.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const Text('Sign up page '),
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
                final showPassword = ref.watch(authProvider.showPassword);
                return MyTextField(
                  hintText: 'Password',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    ref.read(authProvider.passwordController.notifier).state =
                        value;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      ref.read(authProvider.showPassword.notifier).state =
                          !showPassword;
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  obscureText: showPassword,
                );
              }),
              Consumer(builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    authServices.createAccount(
                      email: ref.read(authProvider.emailController),
                      password: ref.read(authProvider.passwordController),
                      name: ref.read(authProvider.nameController),
                      phoneNumber: ref.read(authProvider.phoneNumberController),
                      context: context,
                      ref: ref,
                    );
                  },
                  child: const Text('Sign Up'),
                );
              }),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text('Already Have account? Login'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
