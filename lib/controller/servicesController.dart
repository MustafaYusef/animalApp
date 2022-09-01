import 'dart:io';

import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/data/myBookingServices.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/data/servicesModel.dart';
import 'package:animal_app/metods/alerts.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:animal_app/ui/screens/profile/myBookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../constant.dart';

class ServicesController extends GetxController {
  Rx<ServicesModel?> sectionsList = ServicesModel().obs;
  var noNetFlage = false.obs;
  TextEditingController? phoneController;
  TextEditingController? addressController;
  TextEditingController? petNameController;
  TextEditingController? notesController;
  var isLoadingServecis = false.obs;
  var selectedPet = MyPet(id: null).obs;
  var isEmptyFlage = false.obs;
  var page = 1.obs;
  var isLoading = false.obs;

  // TextEditingController nameTextController;
  // var selectedType = "".obs;
  // MyPetsController controller = Get.find();
  var myPets = <MyPet>[].obs;

  late MainRepostary repo;
  @override
  void onInit() {
    // selectedPet = null;
    phoneController = TextEditingController();
    addressController = TextEditingController();
    petNameController = TextEditingController();
    notesController = TextEditingController();
    // sectionsList.value = null;
    getProfile();
    repo = MainRepostary();
    print("init booking  ...........");
    // getPets();
    super.onInit();
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    phoneController!.text =
        prefs.getString('phone') == null ? "" : prefs.getString('phone')!;
  }
  // Future<void> getPets() async {
  //   myPets.assignAll(controller.petsList.value.data.myPet);
  //   await controller.getMyPets();
  //   if (myPets.isEmpty) {
  //     myPets.add(MyPet(name: ".. إضافة حيوان"));
  //   }
  //   myPets.assignAll(controller.petsList.value.data.myPet);
  // }

  Future<void> getSections(int? inHouse) async {
    isLoadingServecis.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      // nuill all
// 0=false
// 1=true
      final banners1 = await repo.getServices(inHouse);
      sectionsList.value = banners1;
      print(sectionsList);
      isLoadingServecis.value = false;
    } on SocketException catch (_) {
      noNetFlage.value = true;
      isLoadingServecis.value = false;
      showSnake(noNet);
    } catch (_) {
      isLoadingServecis.value = false;

      // Get.back();
      showSnake(_.toString().split(":")[1]);
    }
  }

  Future<void> bookServices(int? service_id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      // nuill all
// 0=false
// 1=true
      final banners1 = await repo.bookServices(
        token: token,
        address: addressController!.text.toString(),
        pet: selectedPet.value.id.toString(),
        service_id: service_id,
        phone: phoneController!.text.toString(),
        notes: notesController!.text.toString(),
      );
      Get.back();
      phoneController!.clear();
      addressController!.clear();

      notesController!.clear();
      selectedPet = MyPet().obs;

      // Get.delete<ServicesController>();
      Get.off(MyBookingScreen());
      showSnake(banners1.data!.msg!);
    } on SocketException catch (_) {
      Get.back();
      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      Get.back();
      showSnake(_.toString().split(":")[1]);
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

      String? token = await prefs.getString('token');
      // nuill all
// 0=false
// 1=true
      final banners1 = await repo.getMyBooking(token, page.value, 10);
      // myBooking.value = banners1.data.myList;
      isLoading.value = false;
      if (banners1.data!.myList!.isEmpty) {
        lastPage.value = true;
      } else {
        myBooking.addAll(banners1.data!.myList!);
        page.value++;
      }

      if (myBooking.isEmpty) {
        isEmptyFlage.value = true;
      }
      print(myBooking);
    } on SocketException catch (_) {
      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      showSnake(_.toString().split(":")[1]);
    }
  }
}
