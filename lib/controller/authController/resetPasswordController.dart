import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/profileModel.dart';
import 'package:animal_app/main.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/repostarys/authRepostary.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';
import 'package:animal_app/ui/screens/profile/resetPasswordScreen.dart';

import '../../constant.dart';

class ResetPasswordController extends GetxController {
  // TextEditingController phoneController;
  TextEditingController passwordTextController;

  TextEditingController codeController;

  TextEditingController emailSendController;
  // TextEditingController emailResetController;

  var selectedcity = "".obs;
  var selectedProv = Map<String, List<String>>().obs;
  var profile = ProfileModel().obs;
  var needLogin = false.obs;

  AuthRepostary repo;

  @override
  void onInit() {
    passwordTextController = TextEditingController();
    codeController = TextEditingController();
    emailSendController = TextEditingController();
    // emailResetController = TextEditingController();

    repo = AuthRepostary();

    super.onInit();
  }

  Future<void> resetPassword() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      final login = await repo.resetPassword(
          emailSendController.text.toString(),
          codeController.text.toString(),
          passwordTextController.text.toString());

      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // await prefs.setString('token', login.data.token);

      // String token = await prefs.getString('token');

      // print("token    :" + token);
      // final dd = await getProfile();
      Get.back();
      Get.delete<ResetPasswordController>();
      Get.offAll(LoginScreen());
      // Get.dialog(null);
      Get.snackbar(" تم تغيير كلمة المرور بنجاح", "تم تغيير كلمة المرور بنجاح ",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
      // emit(AuthcubitLogin(login));
    } on SocketException catch (_) {
      Get.back();

      Get.snackbar(noNet, noNet,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    } catch (_) {
      Get.back();
      Get.snackbar(_.toString(), _.toString(),
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    }
  }

  Future<void> sendEmail() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      print("senddddddddddddd");
      // var playerId = await getuserId();
      final login = await repo.SendEmail(emailSendController.text.toString());

      Get.back();
      Get.off(ResetPasswordScreen());

      Get.snackbar("تم ارسال الرمز بنجاح", "تم ارسال الرمز بنجاح",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    } on SocketException catch (_) {
      Get.back();

      Get.snackbar(noNet, noNet,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    } catch (_) {
      Get.back();
      Get.snackbar(_.toString(), _.toString(),
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    }
  }
}
