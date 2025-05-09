import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zatiq/src/core/utils/colors/app_colors.dart';

class AppToasts {
  AppToasts._();

  static void longToast(message, {ToastGravity? gravity, Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: color ?? AppColors.toastBg,
      textColor: Colors.white,
      fontSize: 12,
    );
  }

  static void shortToast(message, {ToastGravity? gravity, Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: color ?? AppColors.toastBg,
      textColor: Colors.white,
      fontSize: 12,
    );
  }
}
