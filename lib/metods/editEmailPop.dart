import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/ui/screens/profile/editeProfileScreen.dart';

EditeProfileWarnning() {
  // TextEditingController text = TextEditingController();

  // print("time ....  " + dateTimeNow.toString());
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: true,
    isOverlayTapDismiss: false,

    descStyle: TextStyle(fontWeight: FontWeight.bold),
    // descTextAlign: TextAlign.start,
    alertPadding: EdgeInsets.all(10),
    buttonAreaPadding: EdgeInsets.all(10),
    animationDuration: Duration(milliseconds: 200),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.black,
    ),
    alertAlignment: Alignment.center,
  );

  Alert(
      style: alertStyle,
      closeFunction: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('isPop', false);
        print("close");
        print(prefs.getBool('isPop'));
        Get.back();
      },
      context: Get.context,
      type: AlertType.warning,
      title: "يجب عليك إضافة البريد الألكتروني الى معلومات الحساب",
      buttons: [
        DialogButton(
          color: Get.theme.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          radius: BorderRadius.circular(20),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setBool('isPop', false);
            print("close");
            print(prefs.getBool('isPop'));
            Get.back();
            Get.to(EditProfileScreen());
          },
          child: Container(
            height: 50,
            width: Get.width - 200,
            child: Center(
              child: Text(
                "تعديل الحساب",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ]).show();
}
