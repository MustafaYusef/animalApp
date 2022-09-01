import 'dart:io';

import 'package:animal_app/metods/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../../constant.dart';

class SectionsController extends GetxController {
  var sectionsList = <MainCategory>[].obs;
  var noNetFlage = false.obs;
  late MainRepostary repo;
  var isLoading = false.obs;
  @override
  void onInit() {
    // sectionsList.value = null;
    repo = MainRepostary();
    getSections();
    super.onInit();
  }

  Future<void> getSections() async {
    isLoading.value = true;
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      final banners1 = await repo.getMainCategory();
      sectionsList.assignAll(banners1.data!.categories!);
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;

      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      isLoading.value = false;

      // Get.back();
      showSnake("لديك خطأ في معلومات الدخول");
    }
  }
}
