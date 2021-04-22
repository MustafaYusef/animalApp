import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:animal_app/controller/servicesController.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/main.dart';
import 'package:animal_app/metods/compressImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animal_app/data/favouriteModel.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/repostarys/mainRepastory.dart';
import 'package:animal_app/ui/customWidget/popLoading.dart';

import '../../constant.dart';

class MyPetsController extends GetxController {
  MainRepostary repo = MainRepostary();
  var petsList = MyPetsModel().obs;
  var noNetFlage = false.obs;
  var needLogin = false.obs;
  TextEditingController ageController;
  TextEditingController petNameController;
  TextEditingController descController;
  TextEditingController vacsinDateController;
  // TextEditingController addressController;

  var selectedFromDate = DateTime.now().obs;
  var selectedAgeDate = DateTime.now().obs;

  var isLoading = false.obs;

  var isEmptyFlage = false.obs;
  var page = 1.obs;
  // TextEditingController nameTextController;
  var selectedType = "".obs;
  var selectedSex = "".obs;

  var selectedImage = "".obs;

  var imageName = "".obs;
  var isCamera = false.obs;
  var imageFile = File("").obs;
  var picker = ImagePicker();
  String imageBase64 = "";
  TextEditingController imageController;
  ServicesController controller = Get.put(ServicesController());
  @override
  void onInit() {
    petsList.value = null;
    repo = MainRepostary();
    needLogin.value = false;
    selectedType.value = null;
    ageController = TextEditingController();
    petNameController = TextEditingController();
    descController = TextEditingController();
    vacsinDateController = TextEditingController();
    imageController = TextEditingController();
    // addressController = TextEditingController();
    selectedImage.value = null;
    imageFile.value = null;
    selectedSex.value = null;
    super.onInit();
  }

  Future getImage() async {
    // imageFile = File("").obs;

    final pickedFile = await picker.getImage(
        source: isCamera.value ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);

      imageController.text = imageFile.value.path;
      imageName.value = imageFile.value.path;
      Uint8List imageBytes = await compressFile(imageFile.value);
      // print(imageBytes);
      imageBase64 =
          "data:image/${imageFile.value.path.split("/")[imageFile.value.path.split("/").length - 1].split(".")[1]};base64," +
              base64Encode(imageBytes);
      print('string is');
      print(imageBase64);

      Get.back();
      print("image path   " +
          imageFile.value.path
              .split("/")[imageFile.value.path.split("/").length - 1]
              .split(".")[1]);
    } else {
      print('No image selected.');
    }
    // setState(() {

    // });
  }

  Future<void> getMyPets() async {
    // Get.dialog(popUpLoading(), barrierDismissible: false);
    noNetFlage.value = false;
    needLogin.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      if (token == null) {
        needLogin.value = true;
      } else {
        final banners1 = await repo.getMyPets(token);
        petsList.value = banners1;
        controller.myPets.clear();
        controller.myPets.assignAll(petsList.value.data.myPet);
        controller.myPets.add(MyPet(name: ".. إضافة حيوان"));
        print(petsList);
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
      print(_.toString());
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

  Future<void> addPets() async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.addPets(
          token: token,
          age: ageController.text.toString(),
          base64: imageBase64,
          desc: descController.text.toString(),
          last_vaccine: vacsinDateController.text.toString(),
          pet: petNameController.text.toString(),
          sex: sexes.indexOf(selectedSex.value).toString(),
          type: selectedType.value);
      await getMyPets();
      Get.back();

      Get.back();
      selectedType.value = null;
      ageController.clear();
      petNameController.clear();
      descController.clear();
      vacsinDateController.clear();
      imageController.clear();
      // addressController.clear();
      imageBase64 = "";
      selectedImage.value = null;
      imageFile.value = null;
      selectedSex.value = null;
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

  Future<void> deletePet(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(id);

      String token = await prefs.getString('token');
      final banners1 = await repo.deletePete(token, id);
      print(token);
      Get.back();
      await getMyPets();
      Get.off(Main(0));
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
      print(_);

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

  Future<void> editPets(int id) async {
    Get.dialog(popUpLoading(), barrierDismissible: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = await prefs.getString('token');
      final banners1 = await repo.editPets(
          id: id,
          token: token,
          age: ageController.text.toString(),
          base64: imageBase64,
          desc: descController.text.toString(),
          last_vaccine: vacsinDateController.text.toString(),
          pet: petNameController.text.toString(),
          sex: sexes.indexOf(selectedSex.value).toString(),
          type: selectedType.value);
      Get.back();

      selectedType.value = null;
      ageController.clear();
      petNameController.clear();
      descController.clear();
      vacsinDateController.clear();
      imageController.clear();
      // addressController.clear();
      selectedImage.value = null;
      imageFile.value = null;
      selectedSex.value = null;

      Get.off(Main(0));
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
}
