import 'dart:io';

import 'package:animal_app/data/profileModel.dart';
import 'package:animal_app/main.dart';
import 'package:animal_app/repostarys/authRepostary.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/metods/methods.dart';

import '../../constant.dart';
import '../../metods/alerts.dart';

class EditProfileController extends GetxController {
  TextEditingController? phoneController;
  // TextEditingController passwordTextController;

  TextEditingController? nameTextController;

  // TextEditingController emailController;
  RxString? selectedcity = "".obs;
  RxMap<String, List<String>>? selectedProv = Map<String, List<String>>().obs;
  var profile = ProfileModel().obs;
  var needLogin = false.obs;

  late AuthRepostary repo;

  @override
  void onInit() {
    phoneController = TextEditingController();
    // passwordTextController = TextEditingController();
    nameTextController = TextEditingController();

    // emailController = TextEditingController();

    needLogin.value = false;
    selectedProv = null;
    selectedcity = null;
    getProfile();
    repo = AuthRepostary();

    super.onInit();
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    phoneController!.text = prefs.getString('phone')!;
    nameTextController!.text = prefs.getString('name')!;
    // selectedcity.value = prefs.getString('city');
    // emailController.text = prefs.getString('email');

    print("object");
    // print(prefs.getString('prov'));
    // if (prefs.getString('prov') == "" || prefs.getString('prov') == null) {
    //   selectedProv.value = null;
    // } else {
    //   selectedProv.value = States.js[
    //       States.js.indexWhere((e) => e.keys.first == prefs.getString('prov'))];
    // }
  }

  Future<void> editProfile() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // var playerId = await getuserId();

      SharedPreferences prefs = await SharedPreferences.getInstance();

      // await prefs.setString('token', login.data.token);

      String? token = await prefs.getString('token');
      final login = await repo.updateProfile(
        token,
        nameTextController!.text.toString(),
        phoneController!.text.toString().changeToEngilish(),
      );

      Get.back();
      // Get.off(ProfileScreen());
      Get.delete<EditProfileController>();
      Get.offAll(Main(3));
      nameTextController!.clear();
      phoneController!.clear();
      // emailController.clear();

      // passwordTextController.clear();
      selectedProv = null;
      selectedcity = null;
      showSnake("تم تعديل الحساب بنجاح");
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString());
    }
  }
}
