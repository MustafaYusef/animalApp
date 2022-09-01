import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/sectionsController.dart';
import 'package:animal_app/controller/testController.dart';

import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/sectionCard.dart';
import 'package:animal_app/ui/customWidget/sectionCard2.dart';

import '../../controller/mainController/itemDetailsController.dart';
import 'cartScreen.dart';

class SectionsScreen extends StatelessWidget {
  SectionsScreen({Key? key}) : super(key: key);

  SectionsController _controller = Get.put(SectionsController());
  ScrollController _scrollController = new ScrollController();
  ItemDetailsController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "الأقسام",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ).addDirectionality(),
      ),
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: Get.height,
              child: _controller.noNetFlage.value
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
                                    _controller.getSections();
                                  },
                                  child: Text(
                                    "إعادة المحاولة",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ))
                  : Container(
                      child: _controller.isLoading.value
                          ? Container(
                              width: Get.width,
                              height: Get.height,
                              child: Center(
                                child: Container(
                                  height: Get.height,
                                  width: Get.width,
                                  child: Center(
                                    child: Container(child: circularProgress()),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: GetPlatform.isIOS
                                        ? Get.height - 180
                                        : Get.height - 110,
                                    child: Column(children: [
                                      Expanded(
                                        child: RefreshIndicator(
                                          onRefresh: () {
                                            // _controller.page.value = 1;
                                            // _controller.itemsOffPop.clear();
                                            // _controller.lastPage.value = false;
                                            return _controller.getSections();
                                          },
                                          child: GridView.builder(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: _controller
                                                .sectionsList.value.length,
                                            itemBuilder: (context, index) {
                                              return sectionCard2(_controller
                                                  .sectionsList.value[index]);
                                            },
                                            scrollDirection: Axis.vertical,
                                            controller: _scrollController,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio:
                                                  (Get.width / 2.2) / 140,
                                              crossAxisSpacing: 2.0,
                                              mainAxisSpacing: 2.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            )),
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
