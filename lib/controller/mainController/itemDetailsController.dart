import 'dart:io';

import 'package:animal_app/metods/alerts.dart';
import 'package:animal_app/ui/screens/authScreen/regesterSceen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/cartModel.dart';
import 'package:animal_app/data/itemDetails.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';

import '../../constant.dart';

class ItemDetailsController extends GetxController {
  MainRepostary repo = MainRepostary();
  var count = 1.obs;
  var sumCart = 0.obs;
  int? id;
  var selectedSize = SizeItem().obs;
  var selectedColor = ColorItem().obs;
  var needLogin = false.obs;
  var isEmpty = false;
  // var itemDetails = ItemDetails().obs;
  var cartModel = <MyCart>[].obs;
  var current = 0.obs;
  var noNetFlage = false.obs;
  var image = "".obs;
  var isLoading = false.obs;
  var countArray = <int>[].obs;
  @override
  void onInit() {
    repo = MainRepostary();
    getCart();
    // itemDetails.value = null;

    // selectedSize.value = null;
    // selectedColor.value = null;
    // cartModel.value = null;
    super.onInit();
  }

  Future<void> updateCart(int? id, int count1) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      if (token == null) {
        Get.to(LoginScreen());
      } else {
        Get.dialog(popUpLoading(), barrierDismissible: false);
        final banners1 = await repo.addCart(id, count1, token);
        getCart();
        Get.back();
        showSnake(banners1.data!.msg!);
      }
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

  Future<void> addCart(int? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      if (token == null) {
        Get.to(RegesterScreen());
      } else {
        Get.dialog(popUpLoading(), barrierDismissible: false);
        final banners1 = await repo.addCart(id, count.value, token);
        count.value = 1;
        await getCart();
        Get.back();
        showSnake(banners1.data!.msg!);
      }
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

  Future<void> deleteCart(int? id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      final banners1 = await repo.deleteCart(id, token);
      Get.back();
      showSnake("تم حذف المنتج ");

      // cartModel.value = CartModel();
      getCart();
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

  Future<void> getCart() async {
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    needLogin.value = false;
    sumCart.value = 0;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      if (token == null) {
        needLogin.value = true;

        // isEmpty.value = true;
      } else {
        final banners1 = await repo.getCart(token);
        countArray.value = banners1.data!.myCart!.map((e) => e.count!).toList();
        cartModel.assignAll(banners1.data!.myCart!);
        cartModel.value.forEach((e) {
          sumCart.value +=
              e.offer! ? e.itemOfferPrice! * e.count! : e.itemPrice! * e.count!;
        });
        print("carttttttttt ..........   ");
        print(cartModel.value);
      }

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      isLoading.value = false;

      // Get.back();
      showSnake(_.toString());
    }
  }
}
