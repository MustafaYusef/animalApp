import 'dart:io';

import 'package:animal_app/metods/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../../constant.dart';

class OfferPopularController extends GetxController {
  var noNetFlage = false.obs;
  var isLoading = false.obs;

  var isEmptyFlage = false.obs;
  var page = 1.obs;
  var status = 0.obs;
  // var selectedShipPrice = 0.obs;
  late MainRepostary repo;
  final itemsOffPop = <ItemOffer>[].obs;
  // final _paginationFilter = PaginationFilter().obs;
  final lastPage = false.obs;
  @override
  void onInit() {
    repo = MainRepostary();

    super.onInit();
  }

  Future<void> getPopolarOfffer() async {
    noNetFlage.value = false;
    isEmptyFlage.value = false;
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String token = await prefs.getString('token');
      print("order page  " + page.toString());

      final order =
          await repo.getOfferOrPopularItems(status.value, page.value, 10);

      isLoading.value = false;
      if (order.data!.items!.isEmpty) {
        lastPage.value = true;
      } else {
        itemsOffPop.addAll(order.data!.items!);
        page.value++;
      }

      if (itemsOffPop.isEmpty) {
        isEmptyFlage.value = true;
      }
      // print("token    :" + token);
      // Get.back();

    } on SocketException catch (_) {
      noNetFlage.value = true;
      isLoading.value = false;

      // Get.back();
      showSnake(noNet);
    } catch (_) {
      isLoading.value = false;

      // Get.back();
      print(_.toString());
      showSnake("لديك خطأ في معلومات الدخول");
    }
  }
}
