import 'dart:io';

import 'package:animal_app/metods/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/itemsPagination.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../../constant.dart';

class SectionsItemsController extends GetxController {
  var sectionsList = ItemsPaginationModel().obs;
  var noNetFlage = false.obs;
  var id = 0.obs;
  late MainRepostary repo;

  var isLoading = false.obs;
  var isMainLoading = false.obs;

  var isEmptyFlage = false.obs;
  var page = 1.obs;
  var status = 0.obs;
  // var selectedShipPrice = 0.obs;

  final itemsOffPop = <Item>[].obs;
  // final _paginationFilter = PaginationFilter().obs;
  final lastPage = false.obs;
  @override
  void onInit() {
    // sectionsList.value = null;
    repo = MainRepostary();
    super.onInit();
  }

  Future<void> getSubCategory() async {
    noNetFlage.value = false;
    isEmptyFlage.value = false;

    // isMainLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // String token = await prefs.getString('token');
      final banners1 = await repo.getCategoryItem(id.value, page.value, 10);
      isMainLoading.value = false;

      if (banners1.data!.subCategory!.isEmpty) {
        sectionsList.value = banners1;
        isLoading.value = false;
        if (banners1.data!.paginationItems!.items!.isEmpty) {
          lastPage.value = true;
        } else {
          itemsOffPop.addAll(banners1.data!.paginationItems!.items!);
          page.value++;
        }

        if (itemsOffPop.isEmpty) {
          isEmptyFlage.value = true;
        }
      } else {
        sectionsList.value = banners1;
      }
      isMainLoading.value = false;
    } on SocketException catch (_) {
      isMainLoading.value = false;

      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      isMainLoading.value = false;
      showSnake("لديك خطأ في معلومات الدخول");
    }
  }
}
