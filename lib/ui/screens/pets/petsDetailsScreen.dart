import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/loadingImage.dart';
import 'package:animal_app/ui/screens/pets/editPetScreen.dart';
import 'package:animal_app/ui/screens/servicesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';

class PetsDetailsScreen extends StatelessWidget {
  MyPet item;
  PetsDetailsScreen(this.item);
  MyPetsController favouriteController = Get.put(MyPetsController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Get.delete<ItemDetailsController>();
        // controller.count.value = 1;
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.grey[100],
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
                              color: Colors.grey[100],
                              height: Get.height / 2 + 100,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Container(
                                    // margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      // color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Colors.grey[300]),
                                    ),
                                    child: CachedNetworkImage(
                                      // color: Colors.grey[100],
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: Get.height / 2,
                                      imageUrl: imageUrl + item.photo,
                                      placeholder: (context, url) =>
                                          loadinImage(),
                                      errorWidget: (context, url, error) =>
                                          loadinImage(),
                                    ),
                                  ),
                                  Positioned(
                                      top: Get.height / 2 - 75,
                                      right: 10.0,
                                      left: 10,
                                      child: Container(
                                        height: 155,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.white),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/icon_cat.png",
                                                  width: 25,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(5),
                                                  child: Text(
                                                    item.type,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ).addDirectionality(),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Image.asset(
                                                  "assets/images/icon_cat.png",
                                                  width: 25,
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    // margin: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "الأسم",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          item.name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    // margin: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "العمر",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          calculateAge(item.age)
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    // margin: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "الجنس",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          item.sex == 0
                                                              ? "ذكر"
                                                              : "أنثى",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ).addDirectionality(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  // margin: EdgeInsets.all(5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        item.lastVaccine
                                                            .toString()
                                                            .split(" ")[0],
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "تاريخ أخر لقاح",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .grey[700]),
                                                      ).addDirectionality(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Image.asset(
                                                  "assets/images/icon_cat.png",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[800],
                                ),
                              ).addDirectionality(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: Get.width,
                  child: Row(
                    children: [
                      Container(
                        height: 60.0,
                        width: 150,
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          color: Get.theme.accentColor,
                          onPressed: () {
                            Get.to(ServicesScreen(null));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.volunteer_activism,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'حجز موعد',
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
                      Expanded(child: Container()),
                      Container(
                        height: 50.0,
                        width: 70,
                        margin: EdgeInsets.only(right: 10),
                        child: RaisedButton(
                          color: Get.theme.accentColor,
                          onPressed: () {
                            favouriteController.deletePet(item.id);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  "حذف",
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
                      Container(
                        height: 50.0,
                        width: 70,
                        margin: EdgeInsets.only(right: 20),
                        child: RaisedButton(
                          color: Get.theme.primaryColor,
                          onPressed: () {
                            Get.to(EditPetsScreen(item));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  "تعديل",
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
                  )),
            )
          ],
        ),
      ),
    );
  }
}
