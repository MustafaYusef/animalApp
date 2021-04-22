import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/controller/mainController/mainScreenController.dart';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:animal_app/controller/mainController/sectionsController.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';

LogoutPopUp(contex2) {
  // TextEditingController text = TextEditingController();
  var alertStyle = AlertStyle(
    // animationType: AnimationType.fromTop,
    isCloseButton: true,
    isOverlayTapDismiss: true,

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
      context: contex2,
      type: AlertType.info,
      title: "هل تريد تسجيل الخروج",
      closeFunction: () {
        Get.back();
      },
      buttons: [
        DialogButton(
          color: Theme.of(contex2).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          radius: BorderRadius.circular(20),
          onPressed: () => null,
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString("token", null);
              Get.delete<MainController>();
              Get.delete<FavouriteController>();
              Get.delete<ItemDetailsController>();
              Get.delete<OrderController>();
              Get.delete<SectionsController>();

              Get.offAll(LoginScreen());
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(contex2).size.width - 200,
              child: Center(
                child: Text(
                  "تسجيل الخروج",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ).addDirectionality(),
              ),
            ),
          ),
        )
      ]).show();
}
