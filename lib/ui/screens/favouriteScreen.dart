import 'package:animal_app/ui/screens/cartScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/ui/customWidget/favouriteItemCard.dart';
import 'package:animal_app/ui/customWidget/needToLogin.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/sectionCard.dart';
import 'package:animal_app/metods/extentions.dart';

import '../../constant.dart';
import '../../controller/mainController/itemDetailsController.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteController favouriteController = Get.find();
  ItemDetailsController cartController = Get.find();

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
        () => Stack(
          children: [
            cartController.isLoading.value
                ? Container()
                : Container(
                    padding: EdgeInsets.only(
                        bottom: cartController.cartModel.length == 0 ? 0 : 55),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            child: favouriteController.needLogin.value
                                ? NeedToLoginWidget()
                                : Container(
                                    child:
                                        favouriteController
                                                    .favouriteList.value.data ==
                                                null
                                            ? Container(
                                                width: Get.width,
                                                height: Get.height,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: GetPlatform.isIOS
                                                          ? Get.height - 180
                                                          : Get.height - 110,
                                                      child:
                                                          favouriteController
                                                                  .favouriteList
                                                                  .value
                                                                  .data!
                                                                  .myFavorite!
                                                                  .isEmpty
                                                              ? Container(
                                                                  width:
                                                                      Get.width,
                                                                  height: Get
                                                                      .height,
                                                                  child: Center(
                                                                    child: Text(
                                                                        "لا يوجد لديك مفضلة"),
                                                                  ),
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          RefreshIndicator(
                                                                        onRefresh:
                                                                            () {
                                                                          return favouriteController
                                                                              .getFavourite();
                                                                        },
                                                                        child: ListView.builder(
                                                                            itemCount: favouriteController.favouriteList.value.data!.myFavorite!.length,
                                                                            itemBuilder: (context, index) {
                                                                              return FavouriteCard(favouriteController.favouriteList.value.data!.myFavorite![index]);
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
            Obx(
              () => cartController.isLoading.value
                  ? Container()
                  : cartController.needLogin.value
                      ? Container()
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Obx(
                            () => cartController.cartModel.isEmpty
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    width: Get.width,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[500]!,
                                              blurRadius: 6)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            topLeft: Radius.circular(5))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "كلفة الطلب : " +
                                                      cartController.sumCart
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Get.theme.primaryColor),
                                          height: 45,
                                          width: 170,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: RaisedButton(
                                                color: Get.theme.primaryColor,
                                                onPressed: () async {
                                                  Get.to(CartScreen());
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "عرض السلة",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.teal[900],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                        cartController
                                                            .cartModel.length
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
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
