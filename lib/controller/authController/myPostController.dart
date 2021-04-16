import 'dart:convert';
import 'dart:io';

import 'package:animal_app/data/myPostModel.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';

import '../../constant.dart';

class MyPostController extends GetxController {
  var noNetFlage = false.obs;
  var isLoading = false.obs;
  TextEditingController descController;
  var isEmptyFlage = false.obs;
  var page = 1.obs;
  var status = 0.obs;
  // var selectedShipPrice = 0.obs;
  MainRepostary repo;
  final itemsOffPop = <MyPost>[].obs;
  // final _paginationFilter = PaginationFilter().obs;
  final lastPage = false.obs;
  var selectedImage = "".obs;

  var imageName = "".obs;
  var isCamera = false.obs;
  var imageFile = File("").obs;
  var picker = ImagePicker();
  String imageBase64 = "";
  @override
  void onInit() {
    repo = MainRepostary();
    descController = TextEditingController();
    selectedImage.value = null;
    imageFile.value = null;
    super.onInit();
  }

  Future getImage() async {
    // imageFile = File("").obs;

    final pickedFile = await picker.getImage(
        source: isCamera.value ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);

      // imageController.text = imageFile.value.path;
      imageName.value = imageFile.value.path;
      List<int> imageBytes = imageFile.value.readAsBytesSync();
      print(imageBytes);
      imageBase64 =
          "data:image/${imageFile.value.path.split("/")[imageFile.value.path.split("/").length - 1].split(".")[1]};base64," +
              base64Encode(imageBytes);
      print('string is');
      print(imageBase64);

      Get.back();
      print("image path   " + imageName.value);
    } else {
      print('No image selected.');
    }
    // setState(() {

    // });
  }

  Future<void> getMyPost() async {
    noNetFlage.value = false;
    isEmptyFlage.value = false;
    isLoading.value = true;
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString('token');
      print("order page  " + page.toString());

      final order = await repo.getMyPost(token, page.value, 10);

      isLoading.value = false;
      if (order.data.myPosts.isEmpty) {
        lastPage.value = true;
      } else {
        itemsOffPop.addAll(order.data.myPosts);
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

  Future<void> addPost() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.addPost(
        token: token,
        base64: imageBase64,
        desc: descController.text.toString(),
      );
      descController.clear();
      selectedImage.value = null;
      imageFile.value = null;
      page.value = 1;
      itemsOffPop.clear();
      lastPage.value = false;
      getMyPost();
      Get.back();

      Get.back();

      Get.snackbar(banners1.data.msg, banners1.data.msg,
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

  Future<void> deletePost(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.deletePost(token, id);

      page.value = 1;
      itemsOffPop.clear();
      lastPage.value = false;
      getMyPost();
      Get.back();

      Get.back();

      Get.snackbar(banners1.data.msg, banners1.data.msg,
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

  Future<void> editPost() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.addPost(
        token: token,
        base64: imageBase64,
        desc: descController.text.toString(),
      );
      descController.clear();
      selectedImage.value = null;
      imageFile.value = null;
      page.value = 1;
      itemsOffPop.clear();
      lastPage.value = false;
      getMyPost();
      Get.back();

      Get.back();

      Get.snackbar(banners1.data.msg, banners1.data.msg,
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

  Future<void> likePost(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.likePost(id, token);
      Get.back();

      Get.snackbar(banners1.data.msg, banners1.data.msg,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));

      // getMyPets();
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
}
