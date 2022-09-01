import 'package:animal_app/controller/mainController/postController.dart';
import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/postCard.dart';
import 'package:animal_app/ui/screens/authScreen/regesterSceen.dart';
import 'package:animal_app/ui/screens/myPosts/myPosts/addPostScreen.dart';
import 'package:animal_app/ui/screens/myPosts/myPosts/myPostsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/mainController/itemDetailsController.dart';
import '../cartScreen.dart';

class AllPostsScreen extends StatelessWidget {
  // MyPostsScreen({Key key}) : super(key: key);
  late PostController controller;
  ItemDetailsController cartController = Get.find();

  // int status;
  AllPostsScreen() {
    controller = Get.put(PostController());

    controller.getMyPost();
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!controller.isLoading.value) {
            if (!controller.lastPage.value) {
              controller.getMyPost();
            }
          }
        }
      });
    Future<bool> _wiilPop() async {
      Get.delete<PostController>();
      Get.back();
      return true;
    }

    return WillPopScope(
      onWillPop: _wiilPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "المنشورات",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                  heroTag: "btn1",
                  backgroundColor: Get.theme.accentColor,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    String? token = prefs.getString('token');
                    if (token == null) {
                      Get.to(RegesterScreen());
                    } else {
                      Get.to(MyPostsScreen());
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.my_library_books_outlined,
                        size: 30,
                      ),
                    ),
                  )),
              FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    String? token = prefs.getString('token');
                    if (token == null) {
                      Get.to(RegesterScreen());
                    } else {
                      Get.to(AddPostScreen());
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        size: 30,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.itemsOffPop.isEmpty
                    ? Container(
                        child: Center(
                          child: controller.noNetFlage.value
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    NoInternetWidget(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      // onTap: () {
                                      //   controller.initial();
                                      // },
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
                                )
                              : Container(
                                  child: controller.isEmptyFlage.value
                                      ? Text("لا يوجد عناصر لديك")
                                      : Container(
                                          height: Get.height - 200,
                                          width: Get.width,
                                          child: Center(
                                            child: Container(
                                                child: circularProgress()),
                                          ),
                                        )),
                        ),
                      )
                    : Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: RefreshIndicator(
                                    onRefresh: () {
                                      controller.page.value = 1;
                                      controller.itemsOffPop.clear();
                                      controller.lastPage.value = false;
                                      return controller.getMyPost();
                                    },
                                    child: GridView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: controller.itemsOffPop.length,
                                      itemBuilder: (context, index) {
                                        return postCard(
                                            controller.itemsOffPop[index]);
                                      },
                                      scrollDirection: Axis.vertical,

                                      controller: _scrollController,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            (Get.width / 2.2) / 225,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 2.0,
                                      ),

                                      // children: controller.itemsOffPop
                                      //     .map((e) {})
                                      //     .toList()
                                    ),
                                  ),
                                ),
                              ),
                              !controller.isLoading.value
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 20,
                                            height: 20,
                                            color: Colors.transparent,
                                            margin: EdgeInsets.only(
                                                bottom: 20, top: 10),
                                            child: Theme(
                                              data: ThemeData(
                                                  accentColor:
                                                      Get.theme.primaryColor,
                                                  primaryColor:
                                                      Get.theme.primaryColor),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )),
                                      ],
                                    )
                            ],
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
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  width: Get.width,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .grey[500]!,
                                                            blurRadius: 6)
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "كلفة الطلب : " +
                                                                    cartController
                                                                        .sumCart
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Get.theme
                                                                .primaryColor),
                                                        height: 45,
                                                        width: 170,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: RaisedButton(
                                                              color: Get.theme
                                                                  .primaryColor,
                                                              onPressed:
                                                                  () async {
                                                                Get.to(
                                                                    CartScreen());
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "عرض السلة",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            3),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.teal[
                                                                            900],
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Text(
                                                                      cartController
                                                                          .cartModel
                                                                          .length
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15),
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
          ],
        ),
      ),
    );
  }
}
