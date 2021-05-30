import 'package:animal_app/controller/searchController.dart';
import 'package:animal_app/ui/customWidget/searchItemCard.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_grid/responsive_grid.dart';
import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/ui/customWidget/favouriteItemCard.dart';
import 'package:animal_app/ui/customWidget/needToLogin.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/sectionCard.dart';
import 'package:animal_app/metods/extentions.dart';

import '../../constant.dart';

class SearchScreen extends StatelessWidget {
  SerchController favouriteController = Get.put(SerchController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.delete<SerchController>();
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "بحث عن منتجات",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ).addDirectionality(),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                controller: favouriteController.searchController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "بحث عن منتج",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    // floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding: EdgeInsets.all(10)),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                onFieldSubmitted: (text) {
                  favouriteController.searchItems.clear();
                  favouriteController.getSerch();
                },
                // validator: (value) =>
                //     value.trim().isEmpty ? "يجب عليك ادخال الأسم الكامل" : null,
              ).addDirectionality(),
            ),
            Expanded(
              child: Obx(
                () => Container(
                  height: Get.height,
                  child: favouriteController.noNetFlage.value
                      ? Container(
                          height: Get.height,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    NoInternetWidget(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        favouriteController.getSerch();
                                      },
                                      child: Text(
                                        "إعادة المحاولة",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ))
                      : Container(
                          child: Container(
                              child: favouriteController.isLoading.value
                                  ? Container(
                                      width: Get.width,
                                      height: Get.height,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: GetPlatform.isIOS
                                                ? Get.height - 180
                                                : Get.height - 110,
                                            child: favouriteController
                                                    .searchItems.value.isEmpty
                                                ? Container(
                                                    width: Get.width,
                                                    height: Get.height,
                                                    child: Center(
                                                      child: Text(
                                                          "لا يوجد نتائج "),
                                                    ),
                                                  )
                                                : Column(
                                                    children: [
                                                      Expanded(
                                                        child: ListView.builder(
                                                            itemCount:
                                                                favouriteController
                                                                    .searchItems
                                                                    .value
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return searchItemCard(
                                                                  favouriteController
                                                                      .searchItems
                                                                      .value[index]);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ],
                                    )),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
