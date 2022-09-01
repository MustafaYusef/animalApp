import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/itemsSectionController.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/customWidget/itemMainCard.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/subCategoryCard.dart';

import '../../controller/mainController/itemDetailsController.dart';
import 'cartScreen.dart';

class SectionsItemScreen extends StatefulWidget {
  final MainCategory? section;
  SectionsItemScreen(this.section);

  @override
  _SectionsItemScreenState createState() => _SectionsItemScreenState();
}

class _SectionsItemScreenState extends State<SectionsItemScreen> {
  SectionsItemsController _controller = Get.put(SectionsItemsController());
  ItemDetailsController cartController = Get.find();

  @override
  void initState() {
    print("category id    " + widget.section!.id.toString());
    _controller.id.value = widget.section!.id!;
    _controller.isMainLoading.value = true;

    _controller.getSubCategory();
    super.initState();
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!_controller.isLoading.value) {
            if (!_controller.lastPage.value) {
              _controller.isLoading.value = true;
              _controller.getSubCategory();
            }
          }
        }
      });
    Future<bool> _wiilPop() async {
      Get.delete<SectionsItemsController>();
      Get.back();
      return true;
    }

    return WillPopScope(
      onWillPop: _wiilPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.section!.name!,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ).addDirectionality(),
        ),
        body: Obx(
          () => Stack(
            children: [
              Container(
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
                                      _controller.getSubCategory();
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
                        child: _controller.isMainLoading.value
                            ? Container(
                                width: Get.width,
                                height: Get.height,
                                child: Center(
                                  child: Container(
                                    height: Get.height,
                                    width: Get.width,
                                    child: Center(
                                      child:
                                          Container(child: circularProgress()),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: Get.height - 120,
                                child: Column(children: [
                                  Expanded(
                                    child: _controller.sectionsList.value.data!
                                            .subCategory!.isEmpty
                                        ? Column(
                                            children: [
                                              Expanded(
                                                child: RefreshIndicator(
                                                  onRefresh: () {
                                                    _controller.page.value = 1;
                                                    _controller.itemsOffPop
                                                        .clear();
                                                    _controller.lastPage.value =
                                                        false;
                                                    return _controller
                                                        .getSubCategory();
                                                  },
                                                  child: ListView.builder(
                                                    itemCount: _controller
                                                        .itemsOffPop.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return itemMainCard(
                                                          _controller
                                                                  .itemsOffPop[
                                                              index]);
                                                    },
                                                    scrollDirection:
                                                        Axis.vertical,

                                                    controller:
                                                        _scrollController,

                                                    // children: controller.itemsOffPop
                                                    //     .map((e) {})
                                                    //     .toList()
                                                  ),
                                                ),
                                              ),
                                              !_controller.isLoading.value
                                                  ? Container()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: 20,
                                                            height: 20,
                                                            color: Colors
                                                                .transparent,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 20,
                                                                    top: 10),
                                                            child: Theme(
                                                              data: ThemeData(
                                                                  accentColor: Get
                                                                      .theme
                                                                      .primaryColor,
                                                                  primaryColor: Get
                                                                      .theme
                                                                      .primaryColor),
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                              ),
                                                            )),
                                                      ],
                                                    )
                                            ],
                                          )
                                        : Container(
                                            child: RefreshIndicator(
                                              onRefresh: () {
                                                // _controller.page.value = 1;
                                                // _controller.itemsOffPop.clear();
                                                // _controller.lastPage.value = false;
                                                return _controller
                                                    .getSubCategory();
                                              },
                                              child: GridView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                itemCount: _controller
                                                    .sectionsList
                                                    .value
                                                    .data!
                                                    .subCategory!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return SubCategoryCard(
                                                      _controller
                                                          .sectionsList
                                                          .value
                                                          .data!
                                                          .subCategory![index]);
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
                                          ),
                                  )
                                ]),
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
        ),
      ),
    );
  }
}
