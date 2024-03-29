import 'dart:io';

import 'package:animal_app/metods/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/favouriteModel.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';

import '../../constant.dart';

class FavouriteController extends GetxController {
  MainRepostary repo = MainRepostary();
  var isLoading = false.obs;
  var favouriteList = FavouriteModel().obs;
  var noNetFlage = false.obs;
  var needLogin = false.obs;
  @override
  void onInit() {
    // favouriteList.value.data = null;
    repo = MainRepostary();
    needLogin.value = false;

    getFavourite();
    super.onInit();
  }

  Future<void> getFavourite() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    needLogin.value = false;
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      if (token == null) {
        needLogin.value = true;
      } else {
        final banners1 = await repo.getFavourite(token);
        favouriteList.value = banners1;
        print(favouriteList);
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;

      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      isLoading.value = false;

      print(_.toString());
      showSnake(_.toString());
    }
  }

  Future<void> addFavourite(int? id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      final banners1 = await repo.addFavourite(id, token);
      Get.back();
      print("is opennnnnnnnn");
      print(Get.isDialogOpen);

      getFavourite();
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      Get.back();
      print(_);
      showSnake(_.toString());
    }
  }

  Future<void> deleteFavourite(int? id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(id);

      String? token = await prefs.getString('token');
      final banners1 = await repo.deleteFavourite(id, token);
      print(token);
      Get.back();
      // Get.back();

      getFavourite();
    } on SocketException catch (_) {
      Get.back();
      print(_);
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString());
    }
  }
}
