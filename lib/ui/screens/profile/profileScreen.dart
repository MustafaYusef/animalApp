import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:animal_app/ui/screens/myPosts/myPosts/myPostsScreen.dart';
import 'package:animal_app/ui/screens/profile/myBookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/authController/loginController.dart';
import 'package:animal_app/metods/logoutPopUp.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/needToLogin.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/screens/profile/myOrderScreen.dart';
import 'package:animal_app/ui/screens/profile/contactUsScreen.dart';
import 'package:animal_app/ui/screens/profile/editeProfileScreen.dart';

import '../../../metods/deleteAccountPopup.dart';
import '../cartScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginController _profController = Get.put(LoginController());
  ItemDetailsController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            Text("الحساب", style: TextStyle(color: Colors.black, fontSize: 22))
                .addDirectionality(),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () {
              return _profController.getProfile();
            },
            child: SingleChildScrollView(
              child: Container(
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    Container(
                        height: 360,
                        child: Obx(
                          () => Container(
                            child: _profController.isLoading.value
                                ? Container(
                                    width: Get.width,
                                    height: Get.height,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Container(
                                    child: _profController.needLogin.value
                                        ? NeedToLoginWidget()
                                        : Container(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: RefreshIndicator(
                                                    onRefresh: () {
                                                      return _profController
                                                          .getProfile();
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: 0),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: 0),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey[
                                                                        300]!),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                spreadRadius: 2,
                                                                blurRadius: 20,
                                                                offset: Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: [
                                                              Card(
                                                                elevation: 0,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        _profController
                                                                            .profile
                                                                            .value
                                                                            .data!
                                                                            .profile!
                                                                            .name!
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .person,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                elevation: 0,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        _profController
                                                                            .profile
                                                                            .value
                                                                            .data!
                                                                            .profile!
                                                                            .phone!,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .phone,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                child: _profController
                                                                        .inReview
                                                                        .value
                                                                    ? Container()
                                                                    : InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Get.to(
                                                                              ContactUsScreen());
                                                                        },
                                                                        child:
                                                                            Card(
                                                                          elevation:
                                                                              0,
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Text(
                                                                                  "حول العيادة",
                                                                                  style: TextStyle(fontSize: 18),
                                                                                ).addDirectionality(),
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Icon(
                                                                                  Icons.add_box_outlined,
                                                                                  color: Theme.of(context).primaryColor,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  LogoutPopUp(
                                                                      context);
                                                                },
                                                                child: Card(
                                                                  elevation: 0,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          "تسجيل الخروج",
                                                                          style:
                                                                              TextStyle(fontSize: 18),
                                                                        ).addDirectionality(),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .exit_to_app,
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        60.0,
                                                                    width: 200,
                                                                    child:
                                                                        RaisedButton(
                                                                      color: Get
                                                                          .theme
                                                                          .accentColor,
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(
                                                                            EditProfileScreen());
                                                                      },
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(0),
                                                                              topRight: Radius.circular(30),
                                                                              bottomLeft: Radius.circular(30),
                                                                              bottomRight: Radius.circular(30))),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.edit,
                                                                              color: Colors.white,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text(
                                                                              "تعديل الحساب",
                                                                              style: TextStyle(
                                                                                fontSize: 18,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                          ),
                        )),
                    Expanded(child: Container()),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: _profController.needLogin.value
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.grey[300]!),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 20,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(MyOrderScreen());
                                        },
                                        child: Text("سجل الطلبات",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Get.theme.accentColor)),
                                      ),
                                      Container(
                                        child: _profController.inReview.value
                                            ? Container()
                                            : Column(
                                                children: [
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(MyBookingScreen());
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 4,
                                                      ),
                                                      child: Text(
                                                          "سجل الحجوزات",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Get.theme
                                                                  .accentColor)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(MyPostsScreen());
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Text("المنشورات الخاصة بك",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      Get.theme.accentColor)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50.0,
                          width: Get.width - 20,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: RaisedButton(
                            color: Colors.red,
                            onPressed: () {
                              DeleteAccountPopUp();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "تعطيل الحساب",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ).addDirectionality(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                        color: Colors.teal[900],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
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
    );
  }
}
