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

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    favouriteController.getFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "المفضلة",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ).addDirectionality(),
      ),
      body: Obx(
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
                                favouriteController.getFavourite();
                              },
                              child: Text(
                                "إعادة المحاولة",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ))
              : Container(
                  child: favouriteController.needLogin.value
                      ? NeedToLoginWidget()
                      : Container(
                          child: favouriteController.favouriteList.value == null
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
                                        child: favouriteController.favouriteList
                                                .value.data.myFavorite.isEmpty
                                            ? Container(
                                                width: Get.width,
                                                height: Get.height,
                                                child: Center(
                                                  child: Text(
                                                      "لا يوجد لديك مفضلة"),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  Expanded(
                                                    child: RefreshIndicator(
                                                      onRefresh: () {
                                                        return favouriteController
                                                            .getFavourite();
                                                      },
                                                      child: ListView.builder(
                                                          itemCount:
                                                              favouriteController
                                                                  .favouriteList
                                                                  .value
                                                                  .data
                                                                  .myFavorite
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return FavouriteCard(
                                                                favouriteController
                                                                    .favouriteList
                                                                    .value
                                                                    .data
                                                                    .myFavorite[index]);
                                                          }),
                                                    ),
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
    );
  }
}
