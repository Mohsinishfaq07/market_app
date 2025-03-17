import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market/enums/global_enums.dart';

class GlobalFunctions {
  // check user status

  nextScreen(BuildContext context, screenName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }

  popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  Widget spaceByHeight({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget spaceByWidth({required double width}) {
    return SizedBox(
      width: width,
    );
  }

  double getScreenHeight({required BuildContext context}) {
    return MediaQuery.sizeOf(context).height;
  }

  double getScreenWidth({required BuildContext context}) {
    return MediaQuery.sizeOf(context).width;
  }

  showLog({required String message}) {
    developer.log(message);
  }

  showToast({required String message, required ToastType toastType}) {
    Color toastColor = getToastColor(toastType: toastType);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  getToastColor({
    required ToastType toastType,
  }) {
    switch (toastType) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.info:
        return Colors.blue;
    }
  }

  Future<void> openPhoneDialer(String phoneNumber) async {
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      showLog(message: 'Error launching phone dialer: $e');
      showToast(
          message: 'Error launching phone dialer: $e',
          toastType: ToastType.error);
    }
  }

  Future<void> openWhatsApp({
    required String phoneNumber,
    String text = '',
  }) async {
    String contact = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    if (!contact.startsWith('+')) {
      contact = '+92$contact';
    }

    String encodedText = Uri.encodeComponent(text);

    String androidUrl = 'whatsapp://send?phone=$contact&text=$encodedText';
    String iosUrl = 'https://wa.me/$contact?text=$encodedText';
    String fallbackUrl =
        'https://api.whatsapp.com/send?phone=$contact&text=$encodedText';

    try {
      Uri uriToLaunch;
      if (Platform.isIOS) {
        uriToLaunch = Uri.parse(iosUrl);
      } else {
        uriToLaunch = Uri.parse(androidUrl);
      }

      if (await canLaunchUrl(uriToLaunch)) {
        await launchUrl(
          uriToLaunch,
          mode: LaunchMode.externalApplication,
        );
      } else {
        await launchUrl(
          Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      showLog(message: 'Error launching WhatsApp: $e');

      await launchUrl(
        Uri.parse(fallbackUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
