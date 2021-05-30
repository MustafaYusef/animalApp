import 'dart:io';

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
  int id;
  var selectedSize = SizeItem().obs;
  var selectedColor = ColorItem().obs;
  var needLogin = false.obs;

  // var itemDetails = ItemDetails().obs;
  var cartModel = CartModel().obs;
  var current = 0.obs;
  var noNetFlage = false.obs;
  var image = "".obs;

  var countArray = <int>[].obs;
  @override
  void onInit() {
    repo = MainRepostary();
    getCart();
    // itemDetails.value = null;
    needLogin.value = false;

    // selectedSize.value = null;
    // selectedColor.value = null;
    cartModel.value = null;
    super.onInit();
  }

  Future<void> updateCart(int id, int count1) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      if (token == null) {
        Get.to(LoginScreen());
      } else {
        Get.dialog(popUpLoading(), barrierDismissible: false);
        final banners1 = await repo.addCart(id, count1, token);
        getCart();
        Get.back();
        Get.snackbar(banners1.data.msg, banners1.data.msg,
            duration: Duration(seconds: 3),
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
      }
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
      // Get.back();
      Get.back();
      print(_);
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

  Future<void> addCart(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      if (token == null) {
        Get.to(RegesterScreen());
      } else {
        Get.dialog(popUpLoading(), barrierDismissible: false);
        final banners1 = await repo.addCart(id, count.value, token);
        count.value = 1;
        getCart();
        Get.back();
        Get.snackbar(banners1.data.msg, banners1.data.msg,
            duration: Duration(seconds: 3),
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
      }
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
      // Get.back();
      Get.back();
      print(_);
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

  Future<void> deleteCart(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.deleteCart(id, token);
      Get.back();
      Get.snackbar("تم حذف المنتج ", "تم حذف المنتج من السلة",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
      cartModel.value = null;
      getCart();
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
      // Get.back();
      Get.back();
      print(_);
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

  Future<void> getCart() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    needLogin.value = false;
    sumCart.value = 0;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      if (token == null) {
        needLogin.value = true;
      } else {
        final banners1 = await repo.getCart(token);
        countArray.assignAll(banners1.data.myCart.map((e) => e.count).toList());
        cartModel.value = banners1;
        cartModel.value.data.myCart.forEach((e) {
          sumCart.value +=
              e.offer ? e.itemOfferPrice * e.count : e.itemPrice * e.count;
        });
        print(cartModel.value.data.myCart);
      }
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
