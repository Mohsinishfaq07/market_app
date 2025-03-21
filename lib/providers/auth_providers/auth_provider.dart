import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationProvider {
  final emailController = StateProvider.autoDispose<String>((ref) {
    return '';
  });

  final passwordController = StateProvider.autoDispose<String>((ref) {
    return '';
  });

  final nameController = StateProvider.autoDispose<String>((ref) {
    return '';
  });

  final phoneNumberController = StateProvider.autoDispose<String>((ref) {
    return '';
  });

  final showPassword = StateProvider.autoDispose<bool>((ref) {
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
