import 'dart:io';

import 'package:animal_app/data/myBookingServices.dart';
import 'package:animal_app/data/servicesModel.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:animal_app/ui/screens/profile/myBookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../constant.dart';

class ServicesController extends GetxController {
  var sectionsList = ServicesModel().obs;
  var noNetFlage = false.obs;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController petNameController;
  TextEditingController notesController;
  var isLoading = false.obs;

  var isEmptyFlage = false.obs;
  var page = 1.obs;
  // TextEditingController nameTextController;
  var selectedType = "".obs;

  MainRepostary repo;
  @override
  void onInit() {
    phoneController = TextEditingController();
    addressController = TextEditingController();
    petNameController = TextEditingController();
    notesController = TextEditingController();
    sectionsList.value = null;
    selectedType.value = null;
    repo = MainRepostary();
    // getSections();
    super.onInit();
  }

  Future<void> getSections(int inHouse) async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      // nuill all
// 0=false
// 1=true
      final banners1 = await repo.getServices(inHouse);
      sectionsList.value = banners1;
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

  Future<void> bookServices(int service_id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      // nuill all
// 0=false
// 1=true
      final banners1 = await repo.bookServices(
          token: token,
          address: addressController.text.toString(),
          pet: petNameController.text.toString(),
          service_id: service_id,
          phone: phoneController.text.toString(),
          notes: notesController.text.toString(),
          type: selectedType.value);
      Get.back();
      Get.delete<ServicesController>();
      Get.off(MyBookingScreen());
      Get.snackbar(banners1.data.msg, banners1.data.msg,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
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

  final myBooking = <MyList>[].obs;
  // final _paginationFilter = PaginationFilter().obs;
  final lastPage = false.obs;

  Future<void> getMyBooking() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      // nuill all
// 0=false
// 1=true
      final banners1 = await repo.getMyBooking(token, page.value, 10);
      // myBooking.value = banners1.data.myList;
      isLoading.value = false;
      if (banners1.data.myList.isEmpty) {
        lastPage.value = true;
      } else {
        myBooking.addAll(banners1.data.myList);
        page.value++;
      }

      if (myBooking.isEmpty) {
        isEmptyFlage.value = true;
      }
      print(myBooking);
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
