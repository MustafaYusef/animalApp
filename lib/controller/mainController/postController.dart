import 'dart:convert';
import 'dart:io';

import 'package:animal_app/data/allPostRes.dart';
import 'package:animal_app/data/myPostModel.dart';
import 'package:animal_app/metods/alerts.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../../constant.dart';

class PostController extends GetxController {
  var noNetFlage = false.obs;
  var isLoading = false.obs;
  TextEditingController? descController;
  var isEmptyFlage = false.obs;
  var page = 1.obs;
  var status = 0.obs;
  // var selectedShipPrice = 0.obs;
  late MainRepostary repo;
  final itemsOffPop = <AllPost>[].obs;
  // final _paginationFilter = PaginationFilter().obs;
  final lastPage = false.obs;
  // var selectedImage = "".obs;

  // var imageName = "".obs;
  // var isCamera = false.obs;
  // var imageFile = File("").obs;
  // var picker = ImagePicker();
  // String imageBase64 = "";
  @override
  void onInit() {
    repo = MainRepostary();
    descController = TextEditingController();
    // selectedImage.value = null;
    // imageFile.value = null;
    super.onInit();
  }

  // Future getImage() async {
  //   // imageFile = File("").obs;

  //   final pickedFile = await picker.getImage(
  //       source: isCamera.value ? ImageSource.camera : ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imageFile.value = File(pickedFile.path);

  //     // imageController.text = imageFile.value.path;
  //     imageName.value = imageFile.value.path;
  //     List<int> imageBytes = imageFile.value.readAsBytesSync();
  //     print(imageBytes);
  //     imageBase64 =
  //         "data:image/${imageFile.value.path.split("/")[imageFile.value.path.split("/").length - 1].split(".")[1]};base64," +
  //             base64Encode(imageBytes);
  //     print('string is');
  //     print(imageBase64);

  //     Get.back();
  //     print("image path   " + imageName.value);
  //   } else {
  //     print('No image selected.');
  //   }
  //   // setState(() {

  //   // });
  // }

  Future<void> getMyPost() async {
    noNetFlage.value = false;
    isEmptyFlage.value = false;
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // String token = prefs.getString('token');
      print("order page  " + page.toString());

      final order = await repo.getPost(page.value, 10);

      isLoading.value = false;
      if (order.data!.allPosts!.isEmpty) {
        lastPage.value = true;
      } else {
        itemsOffPop.addAll(order.data!.allPosts!);
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
      showSnake(_.toString());
    }
  }

  Future<void> likePost(int? id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = await prefs.getString('token');
      final banners1 = await repo.likePost(id, token);
      Get.back();
      showSnake(banners1.data!.msg!);

      // getMyPets();
    } on SocketException catch (_) {
      Get.back();
      showSnake(noNet);
    } catch (_) {
      // Get.back();
      Get.back();
      print(_);
      showSnake(_.toString().split(":")[1]);
    }
  }
}
