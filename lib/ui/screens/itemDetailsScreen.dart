import 'package:animal_app/data/itemsPagination.dart';
import 'package:animal_app/ui/customWidget/loadingImage.dart';
import 'package:animal_app/ui/screens/cartScreen.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/data/itemDetails.dart';
import 'package:animal_app/main.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/itemSlider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';

// class ItemDetailsScreen extends StatefulWidget {

//   @override
//   _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
// }

class ItemDetailsScreen extends StatelessWidget {
  ItemDetailsController controller = Get.find();
  FavouriteController favouriteController = Get.find();

  Item item;
  int? cartCount;
  ItemDetailsScreen(this.item, [this.cartCount]) {
    // controller = Get.put(ItemDetailsController());
    controller.id = item.id;
    if (cartCount != null) {
      controller.count.value = cartCount!;
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   c
  //   // getCart();
  // }

  int cart = 0;
  // getCart() async {

  //   final result = await db.getAllItems();
  //   cart = result.length;
  //   setState(() {});
  // }
  Future<bool> _wiilPop() async {
    controller.count.value = 1;
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _wiilPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("التفاصيل",
                  style: TextStyle(color: Colors.black, fontSize: 22))
              .addDirectionality(),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15, top: 10),
              child: Obx(
                () => Container(
                  child: controller.needLogin.value
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: controller.isLoading.value
                              ? Container()
                              : Container(
                                  child: controller.cartModel.length == 0
                                      ? Container()
                                      : Badge(
                                          badgeContent: Text(
                                            controller.cartModel.length
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          badgeColor: Colors.deepOrange,
                                          child: InkWell(
                                              onTap: () {
                                                Get.to(CartScreen());
                                              },
                                              child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.black)),
                                        ),
                                ),
                        ),
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () => Container(
            height: Get.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: InkWell(
                              onTap: () {
                                // Get.to(ImagesScreenDetails(
                                //     controller: controller));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey[300]!),
                                            // color: Get.theme.accentColor,
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         Colors.grey.withOpacity(0.5),
                                            //     spreadRadius: 2,
                                            //     blurRadius: 20,
                                            //     offset: Offset(0,
                                            //         3), // changes position of shadow
                                            //   ),
                                            // ],
                                          ),
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            semanticContainer: true,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  // color: Colors.white,
                                                  fit: BoxFit.cover,
                                                  width: Get.width,
                                                  height: (Get.height / 3) + 40,
                                                  imageUrl: imageUrl +
                                                      item.covePhoto.toString(),
                                                  placeholder: (context, url) =>
                                                      loadinImage(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          loadinImage(),
                                                ),
                                                if (item.count != 0)
                                                  Container()
                                                else
                                                  Container(
                                                    child: Container(
                                                      width: Get.width,
                                                      height:
                                                          (Get.height / 3) + 40,
                                                      child: Center(
                                                        child: Text(
                                                          "غير متوفر",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      favouriteController.isLoading.value
                                          ? Container()
                                          : Positioned(
                                              top: 50.0,
                                              right: 50.0,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      String? token =
                                                          await prefs.getString(
                                                              'token');
                                                      if (token != null) {
                                                        int id = 0;
                                                        if (favouriteController
                                                            .favouriteList
                                                            .value
                                                            .data!
                                                            .myFavorite!
                                                            .any((e) =>
                                                                e.items!.id ==
                                                                item.id)) {
                                                          print("yes");
                                                          id = favouriteController
                                                              .favouriteList
                                                              .value
                                                              .data!
                                                              .myFavorite!
                                                              .indexWhere((e) =>
                                                                  e.items!.id ==
                                                                  item.id)
                                                              .toInt();
                                                          print(id);
                                                          favouriteController
                                                              .deleteFavourite(
                                                                  favouriteController
                                                                      .favouriteList
                                                                      .value
                                                                      .data!
                                                                      .myFavorite![
                                                                          id]
                                                                      .id);
                                                        } else {
                                                          print("no");

                                                          favouriteController
                                                              .addFavourite(
                                                                  item.id);
                                                        }
                                                      } else {
                                                        Get.snackbar(
                                                            "يجب تسجيل الدخول",
                                                            "يجب تسجيل الدخول",
                                                            duration: Duration(
                                                                seconds: 3),
                                                            icon: Icon(
                                                              Icons.info,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            colorText:
                                                                Colors.white,
                                                            backgroundColor: Get
                                                                .theme
                                                                .primaryColorDark
                                                                .withOpacity(
                                                                    0.3));
                                                      }
                                                    },
                                                    child:
                                                        favouriteController
                                                                .needLogin.value
                                                            ? Container()
                                                            : Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            22.5)),
                                                                    color: Colors
                                                                        .grey),
                                                                width: 45,
                                                                height: 45,
                                                                child: Center(
                                                                    child: favouriteController
                                                                            .favouriteList
                                                                            .value
                                                                            .data!
                                                                            .myFavorite!
                                                                            .any((e) =>
                                                                                e.items!.id ==
                                                                                item.id)
                                                                        ? Icon(
                                                                            Icons.favorite,
                                                                            size:
                                                                                25,
                                                                            color:
                                                                                Colors.red[600],
                                                                          )
                                                                        : Icon(
                                                                            Icons.favorite,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                25,
                                                                          )),
                                                              ),
                                                  ),
                                                ],
                                              ))
                                    ],
                                  ),
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius:
                                  //       BorderRadius.circular(0.0),
                                  // ),
                                  elevation: 0,
                                ),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  item.name!,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ).addDirectionality(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: !item.offer!
                                        ? Container()
                                        : Text(
                                            item.price.toString() + " " + "د.ع",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 22,
                                              color: Colors.grey,
                                            ),
                                          ).addDirectionality(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      item.offer!
                                          ? item.offerPrice.toString() +
                                              " " +
                                              "د.ع"
                                          : item.price.toString() + " " + "د.ع",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: item.offer!
                                            ? red
                                            : Get.theme.accentColor,
                                      ),
                                    ).addDirectionality(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  item.description!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ).addDirectionality(),
                              ),
                              SizedBox(
                                height: 200,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: Get.width,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          countWidget(controller, item),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class countWidget extends StatelessWidget {
  ItemDetailsController? controller;
  Item item;
  countWidget(this.controller, this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  height: 60.0,
                  width: 160,
                  margin: EdgeInsets.only(left: 10),
                  child: RaisedButton(
                    color: Get.theme.primaryColor,
                    onPressed: item.count == 0
                        ? null
                        : () {
                            print("idddddddd");
                            print(controller!.id);
                            if (controller!.count.value != 0) {
                              controller!.addCart(controller!.id);
                            } else {
                              Get.snackbar(
                                  "أضف كمية", "يجب اضافة الكمية المطلوبة",
                                  duration: Duration(seconds: 3),
                                  icon: Icon(
                                    Icons.info,
                                    color: Colors.white,
                                  ),
                                  colorText: Colors.white,
                                  backgroundColor: Get.theme.primaryColorDark
                                      .withOpacity(0.3));
                            }
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Container(
                      alignment: Alignment.center,
                      child: item.count == 0
                          ? Row(
                              children: [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'غير متوفر',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ).addDirectionality(),
                              ],
                            )
                          : Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'أضف إلى السلة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ).addDirectionality(),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                  // color: Get.theme.accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (controller!.count.value > 1) {
                          controller!.count.value--;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "-",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Obx(
                        () => Text(
                          controller!.count.value.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (item.count! > controller!.count.value) {
                          controller!.count.value++;
                        } else {
                          Get.snackbar("أنتهت الكمية", "أنتهت الكمية",
                              duration: Duration(seconds: 3),
                              icon: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              colorText: Colors.white,
                              backgroundColor:
                                  Get.theme.primaryColorDark.withOpacity(0.3));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
