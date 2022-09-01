import 'dart:io';

import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/controller/mainController/mainScreenController.dart';
import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/controller/servicesController.dart';
import 'package:animal_app/main.dart';
import 'package:animal_app/metods/alerts.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';

class LoginController extends GetxController {
  TextEditingController? phoneController;
  TextEditingController? passwordTextController;
  var isPassHide = true.obs;
  var isPassHideReg = true.obs;

  TextEditingController? nameTextController;
  TextEditingController? phoneRegController;
  TextEditingController? passwordRegTextController;
  // TextEditingController emailController;
  TextEditingController? passDeleteAccountTextController;

  RxString? selectedcity;
  RxMap<String, List<String>>? selectedProv = Map<String, List<String>>().obs;
  var profile = ProfileModel().obs;
  var needLogin = true.obs;
  var noNetFlage = false.obs;

  var inReview = true.obs;
  late AuthRepostary repo;
  var isLoading = true.obs;
  @override
  void onInit() {
    phoneController = TextEditingController();
    passwordTextController = TextEditingController();
    nameTextController = TextEditingController();
    phoneRegController = TextEditingController();
    passwordRegTextController = TextEditingController();
    passDeleteAccountTextController = TextEditingController();
    inReview.value = false;

    // needLogin.value = false;
    // selectedProv.value = null;
    // selectedcity = null;
    repo = AuthRepostary();
    getProfile();
    super.onInit();
  }

  Future<void> loginRequest() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      var playerId;
      try {
        playerId = await getId();
      } catch (_) {
        playerId = "null";
      }
      print("changeToEngilish     " +
          phoneController!.text.toString().changeToEngilish());
      final login = await repo.Login(
          phoneController!.text.toString().changeToEngilish(),
          passwordTextController!.text.toString(),
          playerId);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', login.data!.token!);

      String token = await prefs.getString('token')!;

      print("token    :" + token);
      final dd = await getProfile();
      Get.back();
      Get.delete<LoginController>();
      // Get.delete<MainController>();
      // Get.delete<ItemDetailsController>();
      // Get.delete<FavouriteController>();
      // Get.delete<MyPetsController>();
      // Get.delete<ServicesController>();

      Get.offAll(Main(0));
      // Get.dialog(null);
      showSnake("تم تسجيل الدخول بنجاح");

      // emit(AuthcubitLogin(login));
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString().split(":")[1]);
    }
  }

  Future<void> regesterRequest() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      var playerId;
      try {
        playerId = await getId();
      } catch (_) {
        playerId = "null";
      }
      final login = await repo.Regester(
          nameTextController!.text.toString(),
          phoneRegController!.text.toString().changeToEngilish(),
          passwordRegTextController!.text.toString(),
          playerId);

      Get.back();
      Get.offAll(LoginScreen());
      nameTextController!.clear();
      phoneRegController!.clear();
      // emailController.clear();

      passwordRegTextController!.clear();
      selectedProv = null;
      selectedcity = null;
      showSnake("تم انشاء حساب بنجاح");
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString().split(":")[1]);
    }
  }

  Future<void> deleteAccount() async {
    // isLoading.value = true;
    Get.dialog(popUpLoading(), barrierDismissible: false);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // inReview.value = prefs.getBool("inReview")==null?false;
      // inReview.value = false;
      String token = prefs.getString('token')!;
      print(
          "String? token = prefs.getString('token') .. . .. .. .. . .... . ..");
      print(token);
      final login = await repo.deleteAccount(
          token, passDeleteAccountTextController!.text.toString());
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      Get.back();
      prefs.clear();
      // Get.delete<MainController>();
      // Get.delete<FavouriteController>();
      // Get.delete<ItemDetailsController>();
      // Get.delete<OrderController>();
      // Get.delete<SectionsController>();
      // Get.delete<LoginController>();
      Get.offAll(LoginScreen());
    } on SocketException catch (_) {
      // profile.value = null;
      Get.back();

      // isLoading.value = false;
      // noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      Get.back();

      // isLoading.value = false;
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // // inReview.value = prefs.getBool("inReview")!;
      // // inReview.value = false;
      // String? token = prefs.getString('token');
      // print(
      //     "String? token = prefs.getString('token') .. . .. .. .. . .... . ..");

      // print(token);
      showSnake(_.toString());
    }
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    needLogin.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // inReview.value = prefs.getBool("inReview")==null?false;
      // inReview.value = false;
      String? token = prefs.getString('token');
      print(
          "String? token = prefs.getString('token') .. . .. .. .. . .... . ..");

      print(token);
      if (token == null) {
        needLogin.value = true;
      } else {
        final login = await repo.getProfile(token);
        await prefs.setString('name', login.data!.profile!.name!);
        await prefs.setString('phone', login.data!.profile!.phone!);

        profile.value = login;
        needLogin.value = false;
      }
      // var playerId = await getuserId();
      isLoading.value = false;
    } on SocketException catch (_) {
      // profile.value = null;
      isLoading.value = false;
      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      isLoading.value = false;
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // // inReview.value = prefs.getBool("inReview")!;
      // // inReview.value = false;
      // String? token = prefs.getString('token');
      // print(
      //     "String? token = prefs.getString('token') .. . .. .. .. . .... . ..");

      // print(token);
      showSnake(_.toString());
    }
  }
}
