import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../../constant.dart';

class SectionsController extends GetxController {
  var sectionsList = List<MainCategory>().obs;
  var noNetFlage = false.obs;
  MainRepostary repo;
  @override
  void onInit() {
    // sectionsList.value = null;
    repo = MainRepostary();
    getSections();
    super.onInit();
  }

  Future<void> getSections() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.getMainCategory();
      sectionsList.assignAll(banners1.data.categories);
      print(sectionsList);
    } on SocketException catch (_) {
      noNetFlage.value = true;
      Get.snackbar(noNet, noNet,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    } catch (_) {
      // Get.back();
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
}
