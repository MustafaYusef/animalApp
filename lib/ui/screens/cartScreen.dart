import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_grid/responsive_grid.dart';
import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/ui/customWidget/cartItemCard.dart';
import 'package:animal_app/ui/customWidget/favouriteItemCard.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/customWidget/needToLogin.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/screens/makeOrderScreen.dart';

import 'authScreen/regesterSceen.dart';

// class CartScreen extends StatefulWidget {
//   CartScreen({Key key}) : super(key: key);

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

class CartScreen extends StatelessWidget {
  ItemDetailsController favouriteController = Get.put(ItemDetailsController());
  // @override
  // void initState() {
  //   super.initState();
  //   favouriteController.getCart();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "سلة المشتريات",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ).addDirectionality(),
        ),
        body: Container(
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => favouriteController.cartModel.value == null
                      ? Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: favouriteController.needLogin.value
                              ? NeedToLoginWidget()
                              : Container(
                                  width: Get.width,
                                  child: favouriteController.noNetFlage.value
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
                                                        favouriteController
                                                            .getCart();
                                                      },
                                                      child: Text(
                                                        "إعادة المحاولة",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ))
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                        )
                      : Container(
                          child: favouriteController
                                  .cartModel.value.data.myCart.isEmpty
                              ? Container(
                                  width: Get.width,
                                  height: Get.height,
                                  child: Center(child: Text("السلة فارغة")),
                                )
                              : SingleChildScrollView(
                                  child: Container(
                                    height: GetPlatform.isIOS
                                        ? Get.height - 120
                                        : Get.height - 120,
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: RefreshIndicator(
                                            onRefresh: () {
                                              return favouriteController
                                                  .getCart();
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 100),
                                              child: ListView.builder(
                                                  itemCount: favouriteController
                                                      .cartModel
                                                      .value
                                                      .data
                                                      .myCart
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CartitemCard(
                                                        favouriteController
                                                            .cartModel
                                                            .value
                                                            .data
                                                            .myCart[index]);
                                                  }),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          child: Container(
                                            height: 50.0,
                                            color: Colors.transparent,
                                            width: Get.width - 40,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: RaisedButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                Get.to(MakeOrderScreen());
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "أكمال الطلب",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ).addDirectionality(),
                                                    // Expanded(child: Container())
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                ),
              ),
            ],
          ),
        ));
  }
}
