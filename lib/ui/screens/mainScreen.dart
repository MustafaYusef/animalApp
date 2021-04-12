import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/ui/screens/servicesScreen.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  MainScreen({Key key}) : super(key: key);
  var listImage = [
    "https://img.freepik.com/free-photo/pretty-young-stylish-sexy-woman-pink-luxury-dress-summer-fashion-trend-chic-style-sunglasses-blue-studio-background-shopping-holding-paper-bags-talking-mobile-phone-shopaholic_285396-2957.jpg?size=626&ext=jpg",
    "https://thumbs.dreamstime.com/b/portrait-pretty-woman-sunglasses-hat-over-blue-colorful-portrait-pretty-woman-sunglasses-hat-over-blue-103615694.jpg",
    "https://assets.vogue.com/photos/5f5fac8b7d9362f52d645560/16:9/w_1280,c_limit/social-holding.jpg"
  ];
  int _current = 0;
  MainController controller = Get.put(MainController());
  ItemDetailsController favouriteController = Get.put(ItemDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          centerTitle: true,
          title: Column(
            children: [
              Image.asset(
                "assets/images/cat_image.png",
                width: 50,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15, top: 10),
              child: Obx(
                () => Container(
                  child: favouriteController.cartModel.value == null
                      ? Container()
                      : Container(
                          child: favouriteController
                                      .cartModel.value.data.myCart.length ==
                                  0
                              ? Container()
                              : Badge(
                                  badgeContent: Text(
                                    favouriteController
                                        .cartModel.value.data.myCart.length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  badgeColor: Colors.deepOrange,
                                  child: InkWell(
                                      onTap: () {
                                        Get.to(CartScreen());
                                      },
                                      child: Icon(Icons.shopping_cart_outlined,
                                          color: Colors.black)),
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
          child: SingleChildScrollView(
            child: Obx(
              () => Container(
                child: controller.noNetFlage.value
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
                                height: Get.height,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  sliderSection(
                                    current: _current,
                                    banners: controller.banners1.value,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/icon_cat.png",
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                          "أحجز الأن",
                                          style: TextStyle(fontSize: 20),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.grey[300]),
                                              color: Get.theme.accentColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 20,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(ServicesScreen(0));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(
                                                      Icons
                                                          .local_attraction_outlined,
                                                      color:
                                                          Get.theme.accentColor,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
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
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              print("click     ........");
                                              Get.to(ServicesScreen(1));
                                            },
                                            child: Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.grey[300]),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 20,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: Get
                                                            .theme.accentColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(
                                                      Icons.home_outlined,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "داخل المنزل",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Get
                                                            .theme.accentColor),
                                                  ).addDirectionality(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Text(
                                            "الحيوانات الخاصة بك",
                                            style: TextStyle(fontSize: 20),
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
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 120,
                                          width: Get.width / 5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey[300]),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 20,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Get.theme.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 150,
                                          width: Get.width / 3.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey[300]),
                                            color: Get.theme.primaryColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 20,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.asset(
                                                  "assets/images/dog_image.png",
                                                  width: 25,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "جلبة",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ).addDirectionality(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Obx(
                                  //   () => Container(
                                  //     height: 120,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     child: controller
                                  //             .mainCategory.value.isEmpty
                                  //         ? Container(
                                  //             height: 120,
                                  //             width: MediaQuery.of(context)
                                  //                 .size
                                  //                 .width,
                                  //             child: Shimmer.fromColors(
                                  //               baseColor: Colors.grey[300],
                                  //               highlightColor:
                                  //                   Colors.grey[100],
                                  //               enabled: true,
                                  //               child: ListView.builder(
                                  //                   itemCount: 4,
                                  //                   shrinkWrap: true,
                                  //                   reverse: true,
                                  //                   scrollDirection:
                                  //                       Axis.horizontal,
                                  //                   itemBuilder:
                                  //                       (context, index) {
                                  //                     return Card(
                                  //                       child: Container(
                                  //                         width: 150,
                                  //                         height: 110,
                                  //                       ),
                                  //                     );
                                  //                   }),
                                  //             ),
                                  //           )
                                  //         : ListView.builder(
                                  //             itemCount: controller
                                  //                 .mainCategory.length,
                                  //             shrinkWrap: true,
                                  //             reverse: true,
                                  //             scrollDirection: Axis.horizontal,
                                  //             itemBuilder: (context, index) {
                                  //               return sectionCard(controller
                                  //                   .mainCategory[index]);
                                  //             }),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Obx(
                                  //   () => Container(
                                  //     child: controller.banners2.value.isEmpty
                                  //         ? Container(
                                  //             height: Get.height / 4,
                                  //             width: MediaQuery.of(context)
                                  //                 .size
                                  //                 .width,
                                  //             child: Shimmer.fromColors(
                                  //               baseColor: Colors.grey[300],
                                  //               highlightColor:
                                  //                   Colors.grey[100],
                                  //               enabled: true,
                                  //               child: ListView.builder(
                                  //                   itemCount: 4,
                                  //                   shrinkWrap: true,
                                  //                   reverse: true,
                                  //                   scrollDirection:
                                  //                       Axis.horizontal,
                                  //                   itemBuilder:
                                  //                       (context, index) {
                                  //                     return Card(
                                  //                       child: Container(
                                  //                         width: Get.width,
                                  //                         height:
                                  //                             Get.height / 4,
                                  //                       ),
                                  //                     );
                                  //                   }),
                                  //             ),
                                  //           )
                                  //         : sliderSection(
                                  //             current: _current,
                                  //             banners:
                                  //                 controller.banners2.value,
                                  //           ),
                                  //   ),
                                  // ),
                                  //      Container(
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(SectionsScreen());
                                              },
                                              child: Text(
                                                "عرض الكل",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[700]),
                                              ).addDirectionality(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Text(
                                            "الأقسام",
                                            style: TextStyle(fontSize: 20),
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
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      child: controller
                                              .mainCategory.value.isEmpty
                                          ? Container(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[100],
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
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: controller
                                                  .mainCategory.length,
                                              shrinkWrap: true,
                                              reverse: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return sectionCard(controller
                                                    .mainCategory[index]);
                                              }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Obx(
                                  //   () => Container(
                                  //     child: controller.banners2.value.isEmpty
                                  //         ? Container(
                                  //             height: Get.height / 4,
                                  //             width: MediaQuery.of(context)
                                  //                 .size
                                  //                 .width,
                                  //             child: Shimmer.fromColors(
                                  //               baseColor: Colors.grey[300],
                                  //               highlightColor:
                                  //                   Colors.grey[100],
                                  //               enabled: true,
                                  //               child: ListView.builder(
                                  //                   itemCount: 4,
                                  //                   shrinkWrap: true,
                                  //                   reverse: true,
                                  //                   scrollDirection:
                                  //                       Axis.horizontal,
                                  //                   itemBuilder:
                                  //                       (context, index) {
                                  //                     return Card(
                                  //                       child: Container(
                                  //                         width: Get.width,
                                  //                         height:
                                  //                             Get.height / 4,
                                  //                       ),
                                  //                     );
                                  //                   }),
                                  //             ),
                                  //           )
                                  //         : sliderSection(
                                  //             current: _current,
                                  //             banners:
                                  //                 controller.banners2.value,
                                  //           ),
                                  //   ),
                                  // ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(AllOfferPopularScreen(1));
                                          },
                                          child: Text(
                                            "عرض الكل",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[700]),
                                          ).addDirectionality(),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                          "الأكثر شيوعاً",
                                          style: TextStyle(fontSize: 20),
                                        ).addDirectionality(),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 280,
                                    width: MediaQuery.of(context).size.width,
                                    child: controller.popularItem.value.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.grey[100],
                                            enabled: true,
                                            child: ListView.builder(
                                                itemCount: 4,
                                                shrinkWrap: true,
                                                reverse: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: Container(
                                                      width: 150,
                                                      height: 110,
                                                    ),
                                                  );
                                                }),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                controller.popularItem.length,
                                            shrinkWrap: true,
                                            reverse: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return itemCard(controller
                                                  .popularItem[index]);
                                            }),
                                  ),
                                  controller.offerEmpty.value
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          AllOfferPopularScreen(
                                                              0));
                                                    },
                                                    child: Text(
                                                      "عرض الكل",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.grey[700]),
                                                    ).addDirectionality(),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Text(
                                                    "أخر العروض",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ).addDirectionality(),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 280,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: controller
                                                      .offersItem.value.isEmpty
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300],
                                                      highlightColor:
                                                          Colors.grey[100],
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
                                                          .offersItem.length,
                                                      shrinkWrap: true,
                                                      reverse: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return itemCard(
                                                            controller
                                                                    .offersItem[
                                                                index]);
                                                      }),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                      ),
              ),
            ),
          ),
        ));
  }
}
