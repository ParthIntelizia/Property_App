import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class CommonWidget {
  static SizedBox commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  static getSnackBar(
      {required String title,
      required String message,
      Color color = const Color.fromRGBO(37, 45, 85, 1.0),
      Color colorText = Colors.white,
      int duration = 1}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: colorText,
      duration: Duration(seconds: duration),
      backgroundColor: color,
    );
  }
}
