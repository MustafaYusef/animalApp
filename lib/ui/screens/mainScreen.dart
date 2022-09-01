import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/ui/customWidget/addPetsCard.dart';
import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:animal_app/ui/customWidget/petsCard.dart';
import 'package:animal_app/ui/screens/pets/addPetScreen.dart';
import 'package:animal_app/ui/screens/searchScreen.dart';
import 'package:animal_app/ui/screens/servicesScreen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/mainScreenController.dart';
import 'package:animal_app/ui/customWidget/itemCard.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/sectionCard.dart';
import 'package:animal_app/metods/extentions.dart';

import 'package:animal_app/ui/customWidget/sliderSection.dart';

import 'package:animal_app/ui/screens/sectionsScreen.dart';

import 'allOfferPopularScreen.dart';
import 'cartScreen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  // var listImage = [
  //   "https://img.freepik.com/free-photo/pretty-young-stylish-sexy-woman-pink-luxury-dress-summer-fashion-trend-chic-style-sunglasses-blue-studio-background-shopping-holding-paper-bags-talking-mobile-phone-shopaholic_285396-2957.jpg?size=626&ext=jpg",
  //   "https://thumbs.dreamstime.com/b/portrait-pretty-woman-sunglasses-hat-over-blue-colorful-portrait-pretty-woman-sunglasses-hat-over-blue-103615694.jpg",
  //   "https://assets.vogue.com/photos/5f5fac8b7d9362f52d645560/16:9/w_1280,c_limit/social-holding.jpg"
  // ];
  int _current = 0;
  ItemDetailsController cartController = Get.find();
  MainController controller = Get.find();
  FavouriteController favouriteController1 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              Image.asset(
                "assets/images/splash.png",
                width: 60,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          leading: Padding(
            padding: EdgeInsets.only(right: 15, top: 10),
            child: Container(
              child: InkWell(
                  onTap: () {
                    Get.to(SearchScreen());
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 27,
                  )),
            ),
          ),
          actions: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(right: 15, top: 10),
                child: Container(
                  child: cartController.isLoading.value ||
                          cartController.needLogin.value
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Get.to(CartScreen());
                          },
                          child: Container(
                            child: cartController.cartModel.length == 0
                                ? Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  )
                                : Badge(
                                    badgeContent: Text(
                                      cartController.cartModel.length
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    badgeColor: Colors.deepOrange,
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return controller.getMain();
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Obx(
                  () => cartController.isLoading.value
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(
                              bottom: cartController.cartModel.length == 0
                                  ? 0
                                  : 50),
                          child: controller.noNetFlage.value
                              ? Container(
                                  height: Get.height,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            NoInternetWidget(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cartController.getCart();
                                                favouriteController1
                                                    .getFavourite();
                                                controller.getMain();
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
                                  child: controller.banners1.value.isEmpty
                                      ? Container(
                                          height: Get.height - 200,
                                          width: Get.width,
                                          child: Center(
                                            child: Container(
                                                child: circularProgress()),
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            sliderSection(
                                              current: _current,
                                              banners:
                                                  controller.banners1.value,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            controller.inReview.value
                                                ? Container()
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/icon_cat.png",
                                                              width: 25,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child: Text(
                                                                "أحجز الأن",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ).addDirectionality(),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/icon_cat.png",
                                                              width: 25,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 140,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey[300]!),
                                                                    color: Get
                                                                        .theme
                                                                        .accentColor,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            20,
                                                                        offset: Offset(
                                                                            0,
                                                                            3), // changes position of shadow
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Get.to(
                                                                          ServicesScreen(
                                                                              0));
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                              Icon(
                                                                            Icons.local_attraction_outlined,
                                                                            color:
                                                                                Get.theme.accentColor,
                                                                            size:
                                                                                25,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          "داخل العيادة",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.white),
                                                                        ).addDirectionality(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30,
                                                              ),
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    print(
                                                                        "click     ........");
                                                                    Get.to(
                                                                        ServicesScreen(
                                                                            1));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 140,
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey[300]!),
                                                                      color: Colors
                                                                          .white,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              20,
                                                                          offset: Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          decoration: BoxDecoration(
                                                                              color: Get.theme.accentColor,
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                              Icon(
                                                                            Icons.home_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          "داخل المنزل",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Get.theme.accentColor),
                                                                        ).addDirectionality(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: controller.inReview.value
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Text(
                                                                  "الحيوانات الخاصة بك",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ).addDirectionality(),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Image.asset(
                                                                "assets/images/icon_cat2.png",
                                                                width: 25,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => Container(
                                                            height: 170,
                                                            color: Colors.white,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: controller
                                                                        .controller
                                                                        .petsList
                                                                        .value
                                                                        .data ==
                                                                    null
                                                                ? Container(
                                                                    child: controller
                                                                            .noPets
                                                                            .value
                                                                        ? AddPetsCard()
                                                                        : Container(
                                                                            color:
                                                                                Colors.white,
                                                                            height:
                                                                                170,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                Shimmer.fromColors(
                                                                              baseColor: Colors.white,
                                                                              highlightColor: Colors.grey[100]!,
                                                                              enabled: true,
                                                                              child: ListView.builder(
                                                                                  itemCount: 4,
                                                                                  shrinkWrap: true,
                                                                                  reverse: true,
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  itemBuilder: (context, index) {
                                                                                    return Card(
                                                                                      child: Container(
                                                                                        width: 170,
                                                                                        height: 170,
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                          ),
                                                                  )
                                                                : Container(
                                                                    child: ListView.builder(
                                                                        itemCount: controller.controller.petsList.value.data!.myPet!.length + 1,
                                                                        shrinkWrap: true,
                                                                        reverse: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemBuilder: (context, index) {
                                                                          return controller.controller.petsList.value.data!.myPet!.length == index
                                                                              ? AddPetsCard()
                                                                              : PetsCard(controller.controller.petsList.value.data!.myPet![index]);
                                                                        }),
                                                                  ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),

                                            //       SizedBox(
                                            //         width: 20,
                                            //       ),
                                            //
                                            //     ],
                                            //   ),
                                            // ),

                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.to(
                                                              SectionsScreen());
                                                        },
                                                        child: Text(
                                                          "المزيد",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Get.theme
                                                                  .accentColor),
                                                        ).addDirectionality(),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                      "الأقسام",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ).addDirectionality(),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    "assets/images/icon_cat.png",
                                                    width: 25,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Obx(
                                              () => Container(
                                                height: 130,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: controller.mainCategory
                                                        .value.isEmpty
                                                    ? Container(
                                                        height: 120,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[100]!,
                                                          enabled: true,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: 4,
                                                                  shrinkWrap:
                                                                      true,
                                                                  reverse: true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Card(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            110,
                                                                      ),
                                                                    );
                                                                  }),
                                                        ),
                                                      )
                                                    : ListView.builder(
                                                        itemCount: controller
                                                            .mainCategory
                                                            .length,
                                                        shrinkWrap: true,
                                                        reverse: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return sectionCard(
                                                              controller
                                                                      .mainCategory[
                                                                  index]);
                                                        }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.to(
                                                              AllOfferPopularScreen(
                                                                  1));
                                                        },
                                                        child: Text(
                                                          "المزيد",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Get.theme
                                                                  .accentColor),
                                                        ).addDirectionality(),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                      "الأكثر شيوعاً",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ).addDirectionality(),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    "assets/images/icon_cat.png",
                                                    width: 25,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 270,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: controller
                                                      .popularItem.value.isEmpty
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      enabled: true,
                                                      child: ListView.builder(
                                                          itemCount: 4,
                                                          shrinkWrap: true,
                                                          reverse: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Card(
                                                              child: Container(
                                                                width: 150,
                                                                height: 110,
                                                              ),
                                                            );
                                                          }),
                                                    )
                                                  : ListView.builder(
                                                      itemCount: controller
                                                          .popularItem.length,
                                                      shrinkWrap: true,
                                                      reverse: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return itemCard(
                                                            controller
                                                                    .popularItem[
                                                                index],
                                                            favouriteController1,
                                                            cartController);
                                                      }),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            controller.offerEmpty.value
                                                ? Container()
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.to(
                                                                        AllOfferPopularScreen(
                                                                            0));
                                                                  },
                                                                  child: Text(
                                                                    "المزيد",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Get
                                                                            .theme
                                                                            .accentColor),
                                                                  ).addDirectionality(),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child: Text(
                                                                "أخر العروض",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ).addDirectionality(),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/icon_cat.png",
                                                              width: 25,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 270,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: controller
                                                                .offersItem
                                                                .value
                                                                .isEmpty
                                                            ? Shimmer
                                                                .fromColors(
                                                                baseColor:
                                                                    Colors.grey[
                                                                        300]!,
                                                                highlightColor:
                                                                    Colors.grey[
                                                                        100]!,
                                                                enabled: true,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            4,
                                                                        shrinkWrap:
                                                                            true,
                                                                        reverse:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Card(
                                                                            child:
                                                                                Container(
                                                                              width: 150,
                                                                              height: 110,
                                                                            ),
                                                                          );
                                                                        }),
                                                              )
                                                            : ListView.builder(
                                                                itemCount:
                                                                    controller
                                                                        .offersItem
                                                                        .length,
                                                                shrinkWrap:
                                                                    true,
                                                                reverse: true,
                                                                scrollDirection:
                                                                    Axis
                                                                        .horizontal,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return itemCard(
                                                                      controller
                                                                              .offersItem[
                                                                          index],
                                                                      favouriteController1,
                                                                      cartController);
                                                                }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                ),
                        ),
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
                                                        MainAxisAlignment
                                                            .center,
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 6,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .teal[900],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          cartController
                                                              .cartModel.length
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
        ));
  }
}
