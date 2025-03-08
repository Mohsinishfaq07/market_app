import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationProvider {
  final emailController = StateProvider<String>((ref) {
    return '';
  });

  final passwordController = StateProvider<String>((ref) {
    return '';
  });

  final nameController = StateProvider<String>((ref) {
    return '';
  });

  final phoneNumberController = StateProvider<String>((ref) {
    return '';
  });

  final showPassword = StateProvider<bool>((ref) {
    return false;
  });
  clearLoginProviderSection({
    required WidgetRef ref,
  }) {
    ref.read(emailController.notifier).state = '';
    ref.read(passwordController.notifier).state = '';
  }

  clearSignupProviderSection({
    required WidgetRef ref,
  }) {
    ref.read(emailController.notifier).state = '';
    ref.read(passwordController.notifier).state = '';
    ref.read(nameController.notifier).state = '';
    ref.read(phoneNumberController.notifier).state = '';
  }
}
