import 'dart:io';

import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/controller/mainController/mainScreenController.dart';
import 'package:animal_app/main.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';
import 'package:animal_app/ui/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:animal_app/data/profileModel.dart';
import 'package:animal_app/repostarys/authRepostary.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:animal_app/ui/screens/profile/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';

class LoginController extends GetxController {
  TextEditingController phoneController;
  TextEditingController passwordTextController;

  TextEditingController nameTextController;
  TextEditingController phoneRegController;
  TextEditingController passwordRegTextController;
  // TextEditingController emailController;
  var selectedcity = "".obs;
  var selectedProv = Map<String, List<String>>().obs;
  var profile = ProfileModel().obs;
  var needLogin = false.obs;

  AuthRepostary repo;

  @override
  void onInit() {
    phoneController = TextEditingController();
    passwordTextController = TextEditingController();
    nameTextController = TextEditingController();
    phoneRegController = TextEditingController();
    passwordRegTextController = TextEditingController();
    // emailController = TextEditingController();

    needLogin.value = false;
    selectedProv.value = null;
    selectedcity.value = null;
    repo = AuthRepostary();

    super.onInit();
  }

  Future<void> loginRequest() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      final login = await repo.Login(phoneController?.text.toString(),
          passwordTextController?.text.toString(), "ddd");

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', login.data.token);

      String token = await prefs.getString('token');

      print("token    :" + token);
      final dd = await getProfile();
      Get.back();
      Get.delete<LoginController>();
      Get.delete<MainController>();
      Get.delete<ItemDetailsController>();
      Get.delete<FavouriteController>();

      Get.offAll(Main(0));
      // Get.dialog(null);
      Get.snackbar("تم تسجيل الدخول بنجاح", "تم تسجيل الدخول بنجاح",
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
      Get.snackbar("لديك خطأ في معلومات الدخول", "لديك خطأ في معلومات الدخول",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    }
  }

  Future<void> regesterRequest() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // var playerId = await getuserId();
      final login = await repo.Regester(
          nameTextController?.text.toString(),
          phoneRegController?.text.toString(),
          passwordRegTextController?.text.toString(),
          "ggg");

      Get.back();
      Get.offAll(LoginScreen());
      nameTextController.clear();
      phoneRegController.clear();
      // emailController.clear();

      passwordRegTextController.clear();
      selectedProv.value = null;
      selectedcity.value = null;

      Get.snackbar("تم انشاء حساب بنجاح", "تم انشاء حساب بنجاح",
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
      Get.snackbar("لديك خطأ في معلومات الدخول", "لديك خطأ في معلومات الدخول",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    }
  }

  Future<void> getProfile() async {
    needLogin.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      print(token);
      if (token == null) {
        needLogin.value = true;
      } else {
        final login = await repo.getProfile(token);
        await prefs.setString('name', login.data.profile.name);
        await prefs.setString('phone', login.data.profile.phone);
        await prefs.setString('prov', login.data.profile.government);
        await prefs.setString('city', login.data.profile.city);
        await prefs.setString('email', login.data.profile.email);

        profile.value = login;
      }
      // var playerId = await getuserId();

    } on SocketException catch (_) {
      profile.value = null;

      Get.snackbar(noNet, noNet,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    } catch (_) {
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
