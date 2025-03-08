import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/user_detail.dart';
import 'package:market/view/auth/login.dart';
import 'package:market/view/home_page/home_page.dart';

class AuthServices {
  checkUserStatus({
    required BuildContext context,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      globalFunctions.showLog(message: 'user logged in');
      globalFunctions.nextScreen(context, HomePage());
    } else {
      globalFunctions.showLog(message: 'user not logged in');
      globalFunctions.nextScreen(context, LoginPage());
    }
  }

  createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        phoneNumber.isEmpty) {
      globalFunctions.showToast(
          message: 'Please enter all details', toastType: ToastType.error);
      return;
    } else if (!email.contains('@')) {
      globalFunctions.showToast(
          message: 'Please enter valid email', toastType: ToastType.error);
      return;
    } else if (password.length < 6) {
      globalFunctions.showToast(
          message: 'Password should be minimum 6 characters',
          toastType: ToastType.error);
      return;
    } else if (name.length < 3) {
      globalFunctions.showToast(
          message: 'Name should be minimum 3 characters',
          toastType: ToastType.error);
    } else if (phoneNumber.length < 10) {
      globalFunctions.showToast(
          message: 'Phone number should be minimum 10 characters',
          toastType: ToastType.error);
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        debugPrint('account created');
        bool dataStored = await firestoreService.storeUserData(
          user: UserDetail(
            name: name,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            userId: credential.user!.uid,
          ),
        );
        if (dataStored) {
          globalFunctions.showToast(
              message: 'Account created successfully',
              toastType: ToastType.info);
          globalFunctions.showToast(
              message: 'Account created successfully',
              toastType: ToastType.info);
          authProvider.clearSignupProviderSection(ref: ref);
          globalFunctions.nextScreen(context, HomePage());
        } else {
          await credential.user!.delete();

          globalFunctions.showToast(
              message: 'Failed to create account\n try again in 5 minutes',
              toastType: ToastType.error);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          globalFunctions.showToast(
              message: 'The password provided is too weak.',
              toastType: ToastType.error);
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          globalFunctions.showToast(
              message: 'The account already exists for that email.',
              toastType: ToastType.error);
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  login(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef widgetRef}) async {
    if (email.isEmpty || password.isEmpty) {
      globalFunctions.showToast(
          message: 'Please enter email and password',
          toastType: ToastType.error);
      return;
    } else if (!email.contains('@')) {
      globalFunctions.showToast(
          message: 'Please enter valid email', toastType: ToastType.error);
      return;
    } else if (password.length < 6) {
      globalFunctions.showToast(
          message: 'Password should be minimum 6 characters',
          toastType: ToastType.error);
      return;
    } else {
      try {
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        authProvider.clearLoginProviderSection(ref: widgetRef);
        globalFunctions.nextScreen(context, HomePage());
        return userCredential;
      } on FirebaseAuthException catch (e) {
        globalFunctions.showToast(
            message: 'Credentials are incorrect', toastType: ToastType.error);
        if (e.code == 'user-not-found') {
          globalFunctions.showToast(
              message: 'user not found', toastType: ToastType.error);
          debugPrint('The user does not exist.');
        } else if (e.code == 'wrong-password') {
          globalFunctions.showToast(
              message: 'Credentials are incorrect', toastType: ToastType.error);
          debugPrint('The password is invalid for that user.');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  signOut({
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signOut().then((val) {
        globalFunctions.showLog(message: 'sign out');
        globalFunctions.nextScreen(context, LoginPage());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  forgotPassword({
    required String email,
  }) async {
    if (email.isEmpty) {
      globalFunctions.showToast(
          message: 'Please enter email', toastType: ToastType.error);
      return;
    } else if (!email.contains('@')) {
      globalFunctions.showToast(
          message: 'Please enter valid email', toastType: ToastType.error);
      return;
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        globalFunctions.showToast(
            message: 'Password reset link has been sent to your email',
            toastType: ToastType.success);
      } catch (e) {
        globalFunctions.showToast(
            message: 'Something went wrong', toastType: ToastType.error);
        debugPrint(e.toString());
      }
    }
  }
}
