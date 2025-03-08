import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

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
}
