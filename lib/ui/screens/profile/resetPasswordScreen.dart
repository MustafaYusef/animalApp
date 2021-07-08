import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/authController/loginController.dart';
import 'package:animal_app/controller/authController/resetPasswordController.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/authScreen/regesterSceen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final ResetPasswordController _loginController =
      Get.put(ResetPasswordController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "أعادة تعيين كلمة المرور",
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
              height: Get.height,
              width: Get.width,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/tebaLogo.png",
                          width: 200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "TEBA FASHION",
                          style: TextStyle(
                              fontSize: 22,
                              color: Get.theme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
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
                                        "البريد الألكتروني",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller:
                                      _loginController.emailSendController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "البريد الألكتروني",
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
                                      contentPadding: EdgeInsets.all(10)),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // validator: (value) => value.trim().isEmpty
                                  //     ? "يجب عليك ادخال البريد الألكتروني"
                                  //     : null,
                                ).addDirectionality(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "رمز التفعيل",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller: _loginController.codeController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "رمز التفعيل",
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
                                      contentPadding: EdgeInsets.all(10)),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // validator: (value) => value.trim().isEmpty
                                  //     ? "يجب عليك ادخال البريد الألكتروني"
                                  //     : null,
                                ).addDirectionality(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "كلمة المرور الجديدة",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller:
                                      _loginController.passwordTextController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "كلمة المرور الجديدة",
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
                                      contentPadding: EdgeInsets.all(10)),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // validator: (value) => value.trim().isEmpty
                                  //     ? "يجب عليك ادخال البريد الألكتروني"
                                  //     : null,
                                ).addDirectionality(),
                                SizedBox(height: 30),
                                Container(
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: Get.theme.primaryColorDark,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // if (GetUtils.isPhoneNumber(
                                        //     _loginController
                                        //         .phoneController.text
                                        //         .toString())) {
                                        _loginController.resetPassword();
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'تغيير',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ).addDirectionality(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
