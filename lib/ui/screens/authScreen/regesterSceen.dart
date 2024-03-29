import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/authController/loginController.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/metods/state.dart';

import '../../../metods/pricecyPopUp.dart';

class RegesterScreen extends StatelessWidget {
  RegesterScreen({Key? key}) : super(key: key);
  final LoginController _loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            "",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ).addDirectionality(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/cat_image.png",
                    width: 200,
                    height: 150,
                  ),
                  Text(
                    "إنشاء حساب جديد",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ).addDirectionality(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey[300]!),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    // padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "الأسم الكامل",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller:
                                      _loginController.nameTextController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: "الأسم الكامل",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
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
                                      // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                      contentPadding: EdgeInsets.all(10)),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  validator: (value) => value!.trim().isEmpty
                                      ? "يجب عليك ادخال الأسم الكامل"
                                      : null,
                                ).addDirectionality(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "رقم الهاتف",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller:
                                      _loginController.phoneRegController,
                                  keyboardType: TextInputType.phone,
                                  // maxLength: 11,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9,٠-٩]')),
                                  ],
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: "رقم الهاتف",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
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
                                      // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                      contentPadding: EdgeInsets.all(10)),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  validator: (value) => value!.trim().isEmpty
                                      ? "يجب عليك ادخال رقم الهاتف"
                                      : null,
                                ).addDirectionality(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "إنشاء كلمة المرور",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => TextFormField(
                                    controller: _loginController
                                        .passwordRegTextController,
                                    keyboardType: TextInputType.text,
                                    obscureText:
                                        _loginController.isPassHideReg.value,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "إنشاء كلمة المرور",
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
                                        child: _loginController
                                                .isPassHideReg.value
                                            ? InkWell(
                                                child: Icon(
                                                  Icons.visibility_off,
                                                  color: Get.theme.primaryColor,
                                                  size: 20,
                                                ),
                                                onTap: () {
                                                  // setState(() {
                                                  if (_loginController
                                                      .isPassHideReg.value) {
                                                    _loginController
                                                        .isPassHideReg
                                                        .value = false;
                                                  } else {
                                                    _loginController
                                                        .isPassHideReg
                                                        .value = true;
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
                                                  if (_loginController
                                                      .isPassHideReg.value) {
                                                    _loginController
                                                        .isPassHideReg
                                                        .value = false;
                                                  } else {
                                                    _loginController
                                                        .isPassHideReg
                                                        .value = true;
                                                  }
                                                },
                                              ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                    ),
                                    validator: (value) => value!.trim().isEmpty
                                        ? "يجب عليك ادخال كلمة المرور"
                                        : null,
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
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text(
                            "بالضغط على تسجيل أوافق على أنني قد قرأت ووافقت على سياسة الخصوصية الخاصة بنا",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ).addDirectionality(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                PrivecyPopUp();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text(
                                  "سياسة الخصوصية",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Get.theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).addDirectionality(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Container(
                              height: 60.0,
                              width: 200,
                              child: RaisedButton(
                                color: Get.theme.accentColor,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // if (_loginController
                                    //         .phoneRegController!.text
                                    //         .toString()
                                    //         .length ==
                                    //     11) {
                                    _loginController.regesterRequest();
                                    // } else {
                                    //   // Toast.show(validEmail(), Get.context,
                                    //   //     duration: Toast.LENGTH_LONG,
                                    //   //     gravity: Toast.BOTTOM);
                                    //   Get.snackbar("ادخل رقم هاتف صحيح",
                                    //       "ادخل رقم هاتف صحيح",
                                    //       duration: Duration(seconds: 3),
                                    //       icon: Icon(
                                    //         Icons.info,
                                    //         color: Colors.white,
                                    //       ),
                                    //       colorText: Colors.white,
                                    //       backgroundColor: Get
                                    //           .theme.primaryColorDark
                                    //           .withOpacity(0.3));
                                    // }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "إنشاء حساب",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              fontSize: 18,
                              color: Get.theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ).addDirectionality(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 0),
                        child: Text(
                          "هل لديك حساب ؟",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ).addDirectionality(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        )));
  }
}
