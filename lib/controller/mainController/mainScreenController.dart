import 'dart:io';

import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/metods/alerts.dart';
import 'package:animal_app/ui/customWidget/updateAppPoo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/bannersModel.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/metods/editEmailPop.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';

import '../../constant.dart';

class MainController extends GetxController {
  MainRepostary repo = MainRepostary();

  var mainCategory = <MainCategory>[].obs;
  var noNetFlage = false.obs;
  var banners1 = <BannerItem>[].obs;
  var banners2 = <BannerItem>[].obs;
  var inReview = true.obs;
  var popularItem = <ItemOffer>[].obs;
  var offersItem = <ItemOffer>[].obs;
  var offerEmpty = false.obs;
  Rx<MyPetsModel?> myPets = MyPetsModel().obs;
  var noPets = false.obs;
  MyPetsController controller = Get.put(MyPetsController());
  // status 0== offers
  // status 1==popular
  @override
  void onInit() {
    repo = MainRepostary();
    // myPets.value = null;
    getMain();
    super.onInit();
  }

  Future<void> getMain() async {
    noPets.value = false;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    offerEmpty.value = false;
    // noPets.value = trfaue;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');
      print("beforrrrr in reviewwwwww");
      int id = 9;
      final reviewCheck = await repo.getReviewCheck(id);
      getReview(id);

      print("in reviewwwwww");
      print(reviewCheck.data!.reviewCheck!.inReview!);
      await prefs.setBool("inReview", reviewCheck.data!.reviewCheck!.inReview!);
      inReview.value = prefs.getBool("inReview")!;
      // inReview.value = false;
      final banners = await repo.getFirstBanner();
      banners1.assignAll(banners.data!.banners!);
      final banners33 = await repo.getMainCategory();
      mainCategory.assignAll(banners33.data!.categories!);
      if (token != null) {
        print(token);
        await controller.getMyPets();

        // final banners22 = await repo.getMyPets(token);
        // myPets.value = controller.petsList.value;
        // print(myPets.value.data.myPet);
      } else {
        noPets.value = true;
      }

      final items = await repo.getOfferOrPopularItems(1, 1, 5);
      popularItem.assignAll(items.data!.items!);

      final itemsw = await repo.getOfferOrPopularItems(0, 1, 5);
      offersItem.assignAll(itemsw.data!.items!);
      if (offersItem.isEmpty) {
        offerEmpty.value = true;
      }
    } on SocketException catch (_) {
      // Get.back();
      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      print(_.toString());
      showSnake(_.toString());
    }
  }

  Future<void> getReview(int id) async {
    noPets.value = false;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    offerEmpty.value = false;
    // noPets.value = trfaue;
    try {
      int idReview = id + 1;
      print("beforrrrr in reviewwwwww");
      final reviewCheck = await repo.getReviewCheck(idReview);
      if (!reviewCheck.data!.reviewCheck!.inReview!) {
        UpdateAppPopUp(Get.context);
      }
    } on SocketException catch (_) {
      // Get.back();
      noNetFlage.value = true;
      showSnake(noNet);
    } catch (_) {
      print("no update .......................");
      // Get.snackbar(_.toString(), _.toString(),
      //     duration: Duration(seconds: 3),
      //     icon: Icon(
      //       Icons.info,
      //       color: Colors.white,
      //     ),
      //     colorText: Colors.white,
      //     backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    }
  }
}
