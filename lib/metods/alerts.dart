import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

showSnake(String text) {
  // Get.snackbar(getTranslate(text), getTranslate(text),
  //     duration: Duration(seconds: 3),
  //     icon: Icon(
  //       Icons.info,
  //       color: Get.theme.primaryColorDark,
  //     ),
  //     colorText: Colors.black,
  //     backgroundColor: Colors.white.withOpacity(0.9));

  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      // webBgColor: Colors.white.withOpacity(0.9),
      textColor: Colors.white,
      fontSize: 18.0);
}
