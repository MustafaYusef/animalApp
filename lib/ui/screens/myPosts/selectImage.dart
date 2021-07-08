import 'package:animal_app/controller/authController/myPostController.dart';
import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/controller/mainController/postController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/metods/extentions.dart';

void selecteImagePost(MyPostController? controller) {
  //  = Get.find();

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: Get.context!,
      builder: (builder) {
        return Container(
            height: Get.height / 3,
            color: Colors.transparent,
            child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller!.isCamera.value = false;
                        controller.getImage();
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "الأختيار من المعرض",
                              style: TextStyle(fontSize: 18),
                            ).addDirectionality(),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller!.isCamera.value = true;
                        controller.getImage();
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ألتقاط صورة",
                              style: TextStyle(fontSize: 18),
                            ).addDirectionality(),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                )));
      });
}
