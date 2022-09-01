import 'dart:io';

import 'package:animal_app/data/cityModel.dart';
import 'package:animal_app/data/govModel.dart';
import 'package:animal_app/metods/alerts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/controller/authController/loginController.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/metods/state.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';

import '../../constant.dart';
import '../../metods/giftPopUp.dart';
import '../../metods/locationEnablePop.dart';
import '../../metods/locationServices.dart';
import '../../ui/screens/profile/myOrderScreen.dart';
import 'itemDetailsController.dart';

class OrderController extends GetxController {
  TextEditingController? phoneController;
  TextEditingController? addressController;
  ItemDetailsController cartController = Get.find();
  late final AudioCache _audioCache;
  late Position? location;
  var isLocSelected = false.obs;
  TextEditingController? nameTextController;
  TextEditingController? noteController;
  var notFast = 1.obs;
  var fast = 0.obs;
  var isFastAvailable = false.obs;
  var noNetFlage = false.obs;
  var isLoading = false.obs;
  var selectedcity = City(
          id: null,
          name: "",
          shippingPrice: null,
          fastShipping: null,
          fastPrice: null)
      .obs;
  // var selectedProv = Map<String, List<String>>().obs;
  // var shippingPrice = ShippingPriceRes().obs;
  var isEmptyFlage = false.obs;
  var page = 1.obs;

  var selectedShipPrice = 0.obs;
  var disscountAmount = 0.obs;
  var goverment = <Governorate>[].obs;
  var selectedProv = Governorate(id: null, name: null).obs;
  var cities = <City>[].obs;
  // var selectedCity = "".obs;
  late MainRepostary repo;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    // location = null;
    phoneController = TextEditingController();
    addressController = TextEditingController();
    nameTextController = TextEditingController();
    noteController = TextEditingController();
    _audioCache = AudioCache(
      prefix: 'assets/audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
    repo = MainRepostary();
    location = null;
    // selectedProv.value = States.js[0];
    // selectedcity.value = null;
    // selectedProv = null;
    // selectedProv = null;
    // selectedProv.value = null;
    // shippingPrice.value = null;
    // selectedProv.value = null;
    // selectedcity.value = null;
    getRes();
    getProfile();
    // getShippingPrice();

    // repo = MainRepostary();

    super.onInit();
  }

  Future<void> getCity() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      final order = await repo.getCityByGovId(selectedProv.value.id!);
      cities.assignAll(order.data!.cities!);
    } on SocketException catch (_) {
      noNetFlage.value = true;

      // Get.back();
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      print(_.toString());
      showSnake("لديك خطأ في معلومات الدخول");
    }
  }

  Future<void> getRes() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // String? token = await prefs.getString('token');
      final order = await repo.getGoverment();
      goverment.assignAll(order.data!.governorate!);
    } on SocketException catch (_) {
      noNetFlage.value = true;

      // Get.back();
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      print(_.toString() + "get goverment d, ,d,m ,mx xmmc, m m,xmc ");
      showSnake(_.toString());
    }
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    phoneController!.text =
        prefs.getString('phone') == null ? "" : prefs.getString('phone')!;
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
      String? token = await prefs.getString('token');
      print("order page  " + page.toString());
      // print("order limit  " + _paginationFilter.value.limit.toString());

      final order = await repo.getOrder(token, page.value, 10);
      // if (order.data.myOrders.isEmpty) {
      //   _lastPage.value = true;
      // }
      isLoading.value = false;
      if (order.data!.myOrders!.isEmpty) {
        lastPage.value = true;
      } else {
        orders.addAll(order.data!.myOrders!);
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
      showSnake(noNet);
    } catch (_) {
      isLoading.value = false;

      // Get.back();
      print(_.toString());
      showSnake("لديك خطأ في معلومات الدخول");
    }
  }

  Future<void> cancelOrder(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token')!;
      final login = await repo.cancelOrder(token, id);

      print("token    :" + token);

      Get.back();
      Get.back();
      Get.back();
      page.value = 1;
      orders.clear();
      getOrder();
      showSnake(login.data!.msg!);
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString());
    }
  }

  Future<void> makeOrder() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // String playerId = await getuserId();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token')!;

      // print(selectedProv.value.keys.first);
     
      final login = await repo.makeOrder(
          token: token,
          name: nameTextController!.text.toString(),
          phone: phoneController!.text.toString().changeToEngilish(),
          government: selectedProv.value.name!,
          city: selectedcity.value.name!,
          address: addressController!.text.isEmpty
              ? "null"
              : addressController!.text.toString(),
          shippingPrice: selectedShipPrice.value,
          notes: noteController!.text.toString(),
          isFast: fast.value == 1 ? true : false,
          lat: location == null ? "" : location!.latitude.toString(),
          lon: location == null ? "" : location!.longitude.toString());
      cartController.getCart();
      print(
          "token  cartController.getCart();cartController.getCart();cartController.getCart();cartController.getCart(); ....  :" +
              token);
      print("token    :" + token);

      Get.back();
      Get.off(MyOrderScreen());

      if (login.data!.gift_flag!) {
        _audioCache.play('my_audio.mp3');
        GiftPopUp(login.data!.giftItem);
      }
      phoneController!.clear();
      addressController!.clear();
      nameTextController!.clear();

      showSnake("تم ارسال الطلب بنجاح");

      // emit(AuthcubitLogin(login));
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString());
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
