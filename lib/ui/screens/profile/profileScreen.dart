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

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginController _profController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _profController.getProfile();
  }

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
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height - 150,
          child: Column(
            children: [
              Container(
                  height: 360,
                  child: Obx(
                    () => _profController.profile.value == null
                        ? Column(
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
                                        _profController.getProfile();
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
                          )
                        : Container(
                            child: _profController.needLogin.value
                                ? NeedToLoginWidget()
                                : Column(
                                    children: [
                                      _profController.profile.value.data == null
                                          ? Container(
                                              height: 360,
                                              width: Get.width,
                                              child: Center(
                                                child: Container(
                                                    child: circularProgress()),
                                              ),
                                            )
                                          : Expanded(
                                              child: RefreshIndicator(
                                                onRefresh: () {
                                                  return _profController
                                                      .getProfile();
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 0),
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[300]),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 2,
                                                            blurRadius: 20,
                                                            offset: Offset(0,
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
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Padding(
                                                              padding: EdgeInsets
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
                                                                        .data
                                                                        .profile
                                                                        .name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            elevation: 0,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
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
                                                                        .data
                                                                        .profile
                                                                        .phone,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Icon(
                                                                    Icons.phone,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                ],
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
                                                              margin: EdgeInsets
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
                                                                      "تسجيل الخروج",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ).addDirectionality(),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .exit_to_app,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
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
                                                                height: 60.0,
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
                                                                          topLeft: Radius.circular(
                                                                              0),
                                                                          topRight: Radius.circular(
                                                                              30),
                                                                          bottomLeft: Radius.circular(
                                                                              30),
                                                                          bottomRight:
                                                                              Radius.circular(30))),
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          "تعديل الحساب",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.white,
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
                            border: Border.all(color: Colors.grey[300]),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(MyBookingScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text("سجل الحجوزات",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Get.theme.accentColor)),
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text("المنشورات الخاصة بك",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Get.theme.accentColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
