import 'package:animal_app/controller/authController/myPostController.dart';
import 'package:animal_app/data/allPostRes.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/data/myPostModel.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/loadingImage.dart';
import 'package:animal_app/ui/screens/servicesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant.dart';

class MyPostDetailsScreen extends StatelessWidget {
  MyPost item;
  MyPostDetailsScreen(this.item);
  MyPostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Get.delete<ItemDetailsController>();
        // controller.count.value = 1;
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("التفاصيل",
                  style: TextStyle(color: Colors.black, fontSize: 22))
              .addDirectionality(),
          centerTitle: true,
        ),
        body: Container(
          height: Get.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height / 1.5,
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[300]),
                              ),
                              child: Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: CachedNetworkImage(
                                  // color: Colors.white,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: Get.height / 1.5 - 50,
                                  imageUrl: imageUrl + item.photo.toString(),
                                  placeholder: (context, url) => loadinImage(),
                                  errorWidget: (context, url, error) =>
                                      loadinImage(),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 5.0,
                                left: 40.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            String token =
                                                prefs.getString('token');
                                            if (token == null) {
                                              Get.snackbar(
                                                  "يجب عليك تسجيل الدخول",
                                                  "أو انشاء حساب جديد",
                                                  duration:
                                                      Duration(seconds: 3),
                                                  icon: Icon(
                                                    Icons.info,
                                                    color: Colors.white,
                                                  ),
                                                  colorText: Colors.white,
                                                  backgroundColor: Get
                                                      .theme.primaryColorDark
                                                      .withOpacity(0.3));
                                            } else {
                                              controller.likePost(item.id);
                                            }
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: Get.theme.accentColor),
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
                                            padding: EdgeInsets.all(5),
                                            child: Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          item.likesCount.toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Get.theme.accentColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            ),
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
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        countWidget(controller, item.id),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class countWidget extends StatelessWidget {
  MyPostController controller;
  int id;
  countWidget(this.controller, this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              height: 50.0,
              width: 125,
              margin: EdgeInsets.only(left: 10),
              child: RaisedButton(
                color: Get.theme.accentColor,
                onPressed: () {
                  controller.deletePost(id);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'حذف المنشور',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ).addDirectionality(),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            // Container(
            //   height: 60.0,
            //   width: 125,
            //   margin: EdgeInsets.only(left: 10),
            //   child: RaisedButton(
            //     color: Get.theme.primaryColor,
            //     onPressed: () {},
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Container(
            //       alignment: Alignment.center,
            //       child: Text(
            //         'تعديل المنشور',
            //         style: TextStyle(
            //           fontSize: 18,
            //           color: Colors.white,
            //         ),
            //       ).addDirectionality(),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
