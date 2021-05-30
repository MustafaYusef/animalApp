import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/controller/authController/loginController.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/data/shippingPrice.dart';
import 'package:animal_app/metods/state.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';

import 'package:animal_app/ui/screens/profile/myOrderScreen.dart';

import '../../constant.dart';
import 'itemDetailsController.dart';

class OrderController extends GetxController {
  TextEditingController phoneController;
  TextEditingController addressController;
  ItemDetailsController cartController = Get.find();

  TextEditingController nameTextController;
  TextEditingController noteController;

  var noNetFlage = false.obs;
  var isLoading = false.obs;
  var selectedcity = "".obs;
  var selectedProv = Map<String, List<String>>().obs;
  var shippingPrice = ShippingPriceRes().obs;
  var isEmptyFlage = false.obs;
  var page = 1.obs;

  var selectedShipPrice = 0.obs;
  var disscountAmount = 0.obs;

  MainRepostary repo;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    phoneController = TextEditingController();
    addressController = TextEditingController();
    nameTextController = TextEditingController();
    noteController = TextEditingController();
    shippingPrice.value = null;
    selectedProv.value = null;
    selectedcity.value = null;
    getProfile();
    getShippingPrice();

    repo = MainRepostary();

    super.onInit();
  }

  Future<void> getShippingPrice() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');

      final order = await repo.getShipingPrice(token);
      shippingPrice.value = order;
      print("token    :" +
          shippingPrice.value.data.getShippingPrice[0].amount.toString());
      // if (selectedProv.value?.keys.toString() == "(بغداد)") {
      //   selectedShipPrice.value =
      //       shippingPrice.value.data.getShippingPrice[0].amount;
      // } else {
      //   selectedShipPrice.value =
      //       shippingPrice.value.data.getShippingPrice[1].amount;
      // }
      // Get.back();
      // emit(AuthcubitLogin(login));
    } on SocketException catch (_) {
      noNetFlage.value = true;

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

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    phoneController.text = prefs.getString('phone');
  }

  // Future<void> initial() {
  //   orders.clear();
  //   ever(_paginationFilter, (_) => getOrder());
  //   _changePaginationFilter(1, 10);
  // }

  final orders = <MyOrder>[].obs;
  // final _paginationFilter = PaginationFilter().obs;
  final lastPage = false.obs;

  Future<void> getOrder() async {
    noNetFlage.value = false;
    isEmptyFlage.value = false;
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // if (_paginationFilter.value.page > 1) {
      //   isLoading.value = true;
      // }
      String token = await prefs.getString('token');
      print("order page  " + page.toString());
      // print("order limit  " + _paginationFilter.value.limit.toString());

      final order = await repo.getOrder(token, page.value, 10);
      // if (order.data.myOrders.isEmpty) {
      //   _lastPage.value = true;
      // }
      isLoading.value = false;
      if (order.data.myOrders.isEmpty) {
        lastPage.value = true;
      } else {
        orders.addAll(order.data.myOrders);
        page.value++;
      }

      if (orders.isEmpty) {
        isEmptyFlage.value = true;
      }
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

  Future<void> cancelOrder(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final login = await repo.cancelOrder(token, id);

      print("token    :" + token);

      Get.back();
      Get.back();
      Get.back();
      page.value = 1;
      orders.clear();
      getOrder();
      Get.snackbar(login.data.msg, login.data.msg,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
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
      Get.back();

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

  Future<void> makeOrder() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');

      print(selectedProv.value.keys.first);
      final login = await repo.makeOrder(
          token,
          nameTextController.text.toString(),
          phoneController.text.toString().changeToEngilish(),
          selectedProv.value.keys.first,
          selectedcity.value,
          addressController.text.toString(),
          selectedShipPrice.value,
          noteController.text.toString());
      cartController.getCart();
      print("token    :" + token);

      Get.back();

      phoneController.clear();
      addressController.clear();
      nameTextController.clear();
      Get.off(MyOrderScreen());
      Get.snackbar("تم ارسال الطلب بنجاح", "تم ارسال الطلب بنجاح",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));

      // emit(AuthcubitLogin(login));
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
      Get.back();
      Get.snackbar(_.toString().split(":")[1], _.toString().split(":")[1],
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    }
  }

  // void changeTotalPerPage(int limitValue) {
  //   orders.clear();
  //   _lastPage.value = false;
  //   _changePaginationFilter(1, limitValue);
  // }

  // void _changePaginationFilter(int page, int limit) {
  //   _paginationFilter.update((val) {
  //     val.page = page;
  //     val.limit = limit;
  //   });
  // }

  // void loadNextPage() => _changePaginationFilter(_page + 1, limit);
}

// class PaginationFilter {
//   int page;
//   int limit;

//   @override
//   String toString() => 'PaginationFilter(page: $page, limit: $limit)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is PaginationFilter && o.page == page && o.limit == limit;
//   }

//   @override
//   int get hashCode => page.hashCode ^ limit.hashCode;
// }
