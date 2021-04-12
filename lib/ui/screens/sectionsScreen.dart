import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:animal_app/controller/mainController/sectionsController.dart';
import 'package:animal_app/controller/testController.dart';

import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/sectionCard.dart';
import 'package:animal_app/ui/customWidget/sectionCard2.dart';

class SectionsScreen extends StatelessWidget {
  SectionsScreen({Key key}) : super(key: key);

  SectionsController _controller = Get.put(SectionsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "الأقسام",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ).addDirectionality(),
      ),
      body: Obx(
        () => Container(
          height: Get.height,
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
                                _controller.getSections();
                              },
                              child: Text(
                                "إعادة المحاولة",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ))
              : Container(
                  child: _controller.sectionsList.value == null
                      ? Container(
                          width: Get.width,
                          height: Get.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: Container(
                                height: GetPlatform.isIOS
                                    ? Get.height - 180
                                    : Get.height - 110,
                                child: Column(children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () {
                                        return _controller.getSections();
                                      },
                                      child: ListView.builder(
                                        itemCount: _controller
                                            .sectionsList.value.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return sectionCard2(_controller
                                              .sectionsList.value[index]);
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ],
                        )),
        ),
      ),
    );
  }
}
