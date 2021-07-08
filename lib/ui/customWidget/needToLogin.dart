import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';
import 'package:animal_app/ui/screens/authScreen/regesterSceen.dart';

class NeedToLoginWidget extends StatelessWidget {
  const NeedToLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/cat_image.png",
              width: 100,
              height: 100,
              alignment: Alignment.center,
              fit: BoxFit.cover),
          SizedBox(
            height: 10,
          ),
          Text(
            "يجب عليك تسجيل الدخول",
            style: TextStyle(
              fontSize: 18,
            ),
          ).addDirectionality(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                width: 200,
                child: RaisedButton(
                  color: Get.theme.accentColor,
                  onPressed: () {
                    Get.to(LoginScreen());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
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
                          'تسجيل الدخول',
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                width: 200,
                child: RaisedButton(
                  color: Get.theme.accentColor,
                  onPressed: () {
                    Get.to(RegesterScreen());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
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
                          'أنشاء حساب جديد',
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
    );
  }
}
