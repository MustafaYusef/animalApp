import 'package:TeamiPro/controllers/mainController/collectionController.dart';
import 'package:TeamiPro/controllers/mainController/orderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../metods/getString.dart';
import '../../../metods/methods.dart';

void selecteImageCollection(CollectionController controller) {
  //  = Get.find();

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: Get.context,
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
                        controller.isCamera.value = false;
                        controller.getImage();
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslate("fromGallary"),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.isCamera.value = true;
                        controller.getImage();
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslate("takePicture"),
                              style: TextStyle(fontSize: 20),
                            ),
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
