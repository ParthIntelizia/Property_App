import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidget {
  static SizedBox commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  static textBoldWight500(
      {required String text,
      double? fontSize,
      Color? color,
      FontWeight fontWeight = FontWeight.w500,
      TextDecoration textDecoration = TextDecoration.none}) {
    return Text(
      text,
      style: TextStyle(
        decoration: textDecoration,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static textBoldWight700(
      {required String text,
      double? fontSize,
      Color? color,
      TextDecoration textDecoration = TextDecoration.none}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        decoration: textDecoration,
        color: color,
      ),
    );
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
