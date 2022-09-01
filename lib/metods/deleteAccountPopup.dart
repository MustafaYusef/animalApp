import 'package:animal_app/controller/authController/loginController.dart';
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

DeleteAccountPopUp() {
  LoginController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

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
      context: Get.context!,
      type: AlertType.error,
      title: "هل تريد تعطيل الحساب ؟",
      closeFunction: () {
        Get.back();
      },
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //       child: Text(
            //         "كلمة المرور",
            //         style: TextStyle(
            //           fontSize: 18,
            //           color: Colors.black,
            //           fontWeight: FontWeight.normal,
            //         ),
            //       ).addDirectionality(),
            //     ),
            //   ],
            // ),
            Obx(
              () => TextFormField(
                controller: controller.passDeleteAccountTextController,
                keyboardType: TextInputType.text,
                obscureText: controller.isPassHide.value,
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  suffix: Container(
                    height: 30,
                    child: controller.isPassHide.value
                        ? InkWell(
                            child: Icon(
                              Icons.visibility_off,
                              color: Get.theme.primaryColor,
                              size: 20,
                            ),
                            onTap: () {
                              // setState(() {
                              if (controller.isPassHide.value) {
                                controller.isPassHide.value = false;
                              } else {
                                controller.isPassHide.value = true;
                              }
                              // });
                            },
                          )
                        : InkWell(
                            child: Icon(
                              Icons.visibility,
                              color: Get.theme.primaryColor,
                              size: 20,
                            ),
                            onTap: () {
                              if (controller.isPassHide.value) {
                                controller.isPassHide.value = false;
                              } else {
                                controller.isPassHide.value = true;
                              }
                            },
                          ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                validator: (value) =>
                    value!.trim().isEmpty ? "يجب عليك ادخال كلمة المرور" : null,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ).addDirectionality(),
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color: Get.theme.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          radius: BorderRadius.circular(20),
          onPressed: () => null,
          child: InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                controller.deleteAccount();
              }
            },
            child: Container(
              height: 50,
              width: Get.width - 200,
              child: Center(
                child: Text(
                  "تعطيل الحساب",
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
