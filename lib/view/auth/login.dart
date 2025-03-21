import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/services/auth/auth_services.dart';
import 'package:market/view/auth/signup.dart';
import 'package:market/widgets/custom_input/custom_input_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  get passwordController => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Text('Login page '),
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
              SizedBox(
                height: 10,
              ),
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
                    globalFunctions.showLog(
                        message:
                            'email:${ref.watch(authProvider.emailController)}');
                    globalFunctions.showLog(
                        message:
                            'password:${ref.watch(authProvider.passwordController)}');
                    authServices.login(
                        email: ref.watch(authProvider.emailController),
                        password: ref.watch(authProvider.passwordController),
                        context: context,
                        widgetRef: ref);
                  },
                  child: const Text('Login'),
                );
              }),
              SizedBox(
                height: 10,
              ),
              Consumer(builder: (context, ref, child) {
                return TextButton(
                  onPressed: () {
                    authServices.forgotPassword(
                      email: ref.read(authProvider.emailController),
                    );
                  },
                  child: const Text('Forgot Password'),
                );
              }),
              TextButton(
                onPressed: () {
                  authProvider.clearLoginProviderSection(ref: ref);
                  globalFunctions.nextScreen(context, SignupPage());
                },
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
