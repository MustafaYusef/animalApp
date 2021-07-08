import 'dart:convert';
import 'dart:io';

import 'package:animal_app/data/allPostRes.dart';
import 'package:animal_app/data/itemsSerach.dart';
import 'package:animal_app/data/myPostModel.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../constant.dart';

class SerchController extends GetxController {
  var noNetFlage = false.obs;
  var isLoading = false.obs;
  TextEditingController? searchController;
  var isEmptyFlage = false.obs;
  var page = 1.obs;
  var status = 0.obs;
  late MainRepostary repo;

  final searchItems = <ItemSearch>[].obs;

  @override
  void onInit() {
    repo = MainRepostary();
    searchController = TextEditingController();
    // selectedImage.value = null;
    // imageFile.value = null;
    super.onInit();
  }

  Future<void> getSerch() async {
    noNetFlage.value = false;
    isEmptyFlage.value = false;
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // String token = prefs.getString('token');
      print("order page  " + page.toString());

      final order = await repo.getSearch(searchController!.text.toString());

      searchItems.addAll(order.data!.item!);

      if (searchItems.isEmpty) {
        isEmptyFlage.value = true;
      }
      isLoading.value = false;
      // print("token    :" + token);
      // Get.back();

    } on SocketException catch (_) {
      noNetFlage.value = true;
      isLoading.value = false;

      // Get.back();

      Get.snackbar(noNet, noNet,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    } catch (_) {
      isLoading.value = false;

      // Get.back();
      print(_.toString());
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
